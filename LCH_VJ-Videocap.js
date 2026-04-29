/**
 * Record a specific Hydra output for a fixed duration using vidRecorder.
 *
 * Example:
 *   osc().out(o1);
 *   videocap(o1, 6000);
 */
function videocap(target = o0, durationMs = 5000, options = {}) {
  const {
    filename = `hydra-${Date.now()}.webm`,
    renderTarget = true,   // set false if the target is already the visible output
    restore = null,        // optional function to restore your previous render setup
  } = options;

  if (renderTarget) {
    // Hydra records what is being rendered to the visible canvas.
    // If you want a specific buffer, render it before recording.
    render(target);
  }

  if (typeof vidRecorder === "undefined") {
    throw new Error("vidRecorder is not available in this Hydra environment.");
  }

  // Start recording
  vidRecorder.start();

  // Stop after N milliseconds
  setTimeout(() => {
    try {
      vidRecorder.stop();
    } finally {
      if (typeof restore === "function") {
        restore();
      }
    }
  }, durationMs);

  return {
    filename,
    target,
    durationMs,
  };
}
