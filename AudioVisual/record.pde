import com.hamoid.*;

VideoExport videoExport;

void record() {
  if (frameCount == 1) {
    videoExport = new VideoExport(this, "epictest.mp4");
    videoExport.setFrameRate(60);
    videoExport.startMovie();
  }
  videoExport.saveFrame();
}

void endMovie() {
  videoExport.endMovie();
}
