FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt \
    && pip install --no-cache-dir fastapi uvicorn python-multipart

COPY . /app

ENV PYTHONUNBUFFERED=1
ENV WAVE2SCORE_WORKDIR=/tmp/wave2score

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "10000"]
