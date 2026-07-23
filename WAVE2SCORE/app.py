from __future__ import annotations

import os
import sys
import time
import uuid
import shutil
import zipfile
import threading
import subprocess
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor

from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import FileResponse

APP_DIR = Path("/app")
WORK_DIR = Path(os.getenv("WAVE2SCORE_WORKDIR", "/tmp/wave2score"))
WORK_DIR.mkdir(parents=True, exist_ok=True)

FRONTEND_ORIGIN = os.getenv("FRONTEND_ORIGIN", "*")

app = FastAPI(title="WAVE2SCORE API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"] if FRONTEND_ORIGIN == "*" else [FRONTEND_ORIGIN],
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)

JOBS: dict[str, dict] = {}
JOBS_LOCK = threading.Lock()
EXECUTOR = ThreadPoolExecutor(max_workers=1)


def set_job(job_id: str, **patch):
    with JOBS_LOCK:
        job = JOBS.setdefault(job_id, {})
        job.update(patch)
        job["job_id"] = job_id
        job["updated_at"] = time.time()


def get_job(job_id: str):
    with JOBS_LOCK:
        return JOBS.get(job_id)


def run_job(job_id: str):
    job = get_job(job_id)
    if not job:
        return

    job_dir = Path(job["job_dir"])
    input_path = Path(job["input_path"]).resolve()
    out_base = str(job_dir / "result")

    if not str(input_path).startswith(str(WORK_DIR.resolve())):
        raise RuntimeError("Invalid input path: outside of work directory")

    try:
        set_job(job_id, status="running", message="Running main.py")

        cmd = ["python3", "main.py", str(input_path), "--out", out_base]
        proc = subprocess.run(
            cmd,
            cwd=str(APP_DIR),
            capture_output=True,
            text=True,
        )

        (job_dir / "stdout.txt").write_text(proc.stdout or "", encoding="utf-8")
        (job_dir / "stderr.txt").write_text(proc.stderr or "", encoding="utf-8")

        if proc.returncode != 0:
            raise RuntimeError(proc.stderr.strip() or proc.stdout.strip() or f"exit code {proc.returncode}")

        zip_path = job_dir / "wave2score_output.zip"
        with zipfile.ZipFile(zip_path, "w", compression=zipfile.ZIP_DEFLATED) as zf:
            for p in sorted(job_dir.iterdir()):
                if p.is_file() and p.name != zip_path.name:
                    zf.write(p, arcname=p.name)

        set_job(
            job_id,
            status="completed",
            message="Completed",
            zip_path=str(zip_path),
            finished_at=time.time(),
        )

    except Exception as e:
        set_job(
            job_id,
            status="failed",
            message=str(e),
            error=str(e),
            finished_at=time.time(),
        )


@app.post("/api/jobs")
async def create_job(file: UploadFile = File(...)):
    filename = (file.filename or "").lower()
    if not filename.endswith(".wav"):
        raise HTTPException(status_code=400, detail="INPUT_FILE must be a .wav file")

    job_id = uuid.uuid4().hex
    job_dir = WORK_DIR / job_id
    job_dir.mkdir(parents=True, exist_ok=True)

    input_path = job_dir / "input.wav"
    with input_path.open("wb") as f:
        shutil.copyfileobj(file.file, f)

    set_job(
        job_id,
        status="queued",
        message="Added a queue",
        job_dir=str(job_dir),
        input_path=str(input_path),
        created_at=time.time(),
    )

    EXECUTOR.submit(run_job, job_id)

    return {
        "job_id": job_id,
        "status_url": f"/api/jobs/{job_id}",
        "download_url": f"/api/jobs/{job_id}/download",
    }


@app.get("/api/jobs/{job_id}")
def job_status(job_id: str):
    job = get_job(job_id)
    if not job:
        raise HTTPException(status_code=404, detail="job not found")

    return {
        "job_id": job_id,
        "status": job.get("status"),
        "message": job.get("message"),
        "error": job.get("error"),
        "download_ready": job.get("status") == "completed",
    }


@app.get("/api/jobs/{job_id}/download")
def job_download(job_id: str):
    job = get_job(job_id)
    if not job:
        raise HTTPException(status_code=404, detail="job not found")

    if job.get("status") != "completed":
        raise HTTPException(status_code=409, detail="job is not completed yet")

    zip_path = job.get("zip_path")
    if not zip_path or not os.path.exists(zip_path):
        raise HTTPException(status_code=404, detail="zip not found")

    return FileResponse(
        zip_path,
        media_type="application/zip",
        filename=f"{job_id}.zip",
    )
