import com.hamoid.*;

VideoExport videoExport;

void recordVideo() {
  if (frameCount == 1) {
    videoExport = new VideoExport(this, "Output.mp4");
    videoExport.setFrameRate(60);
    videoExport.startMovie();
  }
  videoExport.saveFrame();
}

void endMovie() {
  videoExport.endMovie();
}
