import processing.sound.*;

SoundFile song;
FFT fft;
float[] spectrum; // The frequency space
float[] history; // Keeps track of amplitude averages
float[] positions; // X positions of all of the bars
int[] newBands;

final int historyLength = 5; // How many iterations we keep track of the amplitudes
final int bands = (int) pow(2, 12); // Number of bands
final int minF = 2; // Minumum frequency to show, Hz
final int maxF = 24000; // Maximum frequency to show, Hz
final int framerate = 60; // Framerate, frames
final int bandWidth = 10; // How wide the bars are, pixels
final int bleed = 30; // How much sound-bleed there is between bands, pixels
final int bandDistance = 5; // Distance between bands, pixels
final float bleedBase = 0.99; // The base of the pixel distance bleed scale
final float bleedPower = 0; // Power per pixel distance to apply to the bleed base, 0 for nothing
final boolean enableRecording = false; // Enables recording if set to true
int numBands;

void setup() {
  // Sketch setup
  // size(1920*2, 1080, P2D); // 4k width
  size(1280, 600, P2D);
  colorMode(HSB);
  background(0);
  frameRate(framerate);
  pixelDensity(1);
  noStroke();
  // Importing the sound file
  song = new SoundFile(this, "IWon't_BirthdayParty_17.wav"); // Replace the .wav file with another of your choosing
  song.play();
  // Fast Fourier Transform
  fft = new FFT(this, bands);
  fft.input(song);
  spectrum = new float[bands];
  history = new float[bands];
  positions = new float[bands];
  // Scaling the band positions. Octaves are scaled logarithmically in music.
  for (int i = 0; i < bands; i++) {
    float pos = log(i) / log(bands);
    float x = map(pos, log(minF) / log(24000), log(maxF) / log(24000), 0, width);
    positions[i] = x;
  }
  // Do some math for the number of bands based on the width, bandWidth, and bandDistance
  numBands = (int) (width / (bandWidth + bandDistance));
  // Find new scaled band values (closest old band to each new band location)
  newBands = new int[numBands];
  int curLocation = bleed * 2;
  int i = 0;
  while (i < numBands) {
    // Find band where curLocation is
    int low = 0;
    int high = bands;
    while (low <= high) {
      int mid = low + (high - low) / 2;
      if (mid >= bands) {
        break;
      } else if (positions[mid] <= curLocation) {
        low = mid + 1;
      } else {
        high = mid - 1;
      }
    }
    // High is the band cloest to curLocation
    if (high >= bands) {
      high = bands - 1;
    }
    newBands[i] = high;
    curLocation += bandWidth + bandDistance;
    i++;
  }
}

void draw() {
  background(0);
  // Analyze the current frame
  fft.analyze(spectrum);
  // Collect values into history
  for (int i = 0; i < bands; i++) {
    float curHeight = spectrum[i] * pow(i, map(i, 0, bands, 1.2, 1.8)) / i;
    history[i] = (history[i] * (historyLength - 1) + curHeight) / historyLength;
  }
  // Draw each custom band
  for (int i = 0; i < numBands; i++) {
    int count = 0;
    int curBand = newBands[i];
    float middlePosition = positions[curBand];
    float average = 0;
    // Left bands
    while (curBand >= 0 && middlePosition - positions[curBand] < bandWidth + bleed) {
      count++;
      average =
        average * ((count - 1) / count)
        + pow(bleedBase, bleedPower * (middlePosition - positions[curBand])) * history[curBand] / count;
      curBand--;
    }
    // Right bands
    curBand = newBands[i] + 1;
    while (curBand < bands && positions[curBand] - middlePosition < bandWidth + bleed) {
      count++;
      average =
        average * ((count - 1) / count)
        + pow(bleedBase, bleedPower * (middlePosition - positions[curBand])) * history[curBand] / count;
      curBand++;
    }

    // At this point the average has been calculated, but the value may need adjusting.
    // The Fourier Transform calculates the amplitude for each small frequency range.
    // This frequency range stays constant the whole way up the spectrum.
    // The way pitch works in music is that it is a logarithmic scale if you set the linear scale to be octave based (every octave is doubled each time A4 = 440hz, A5 = 880hz, A6 = 1,760hz).
    // Because of this, the average amplitude of a note is gonna be a lot lower for higher notes, so we need to bring them back up.

    // Average scaling
    average *= pow(count, 1.0);
    average *= pow(map(abs(middlePosition - width * 2 / 3), 0, width * 2 / 3, 1, 0), 0.5) + 1;
    average = pow(average, 0.7);
    average = min(average, 1);

    // Draw
    fill(
      map(average, 0, 1, 170, 180), // Hue
      // map(i, 0, numBands, 50, 200), // Hue
      map(average, 0, 1, 255, 180), // Saturation
      // map(i, 0, numBands, 0, 255), // Saturation
      map(average, 0, 1, 180, 255)  // Brightness
      // map(i, 0, numBands, 180, 255) // Brightness
    );

    rect(i * (bandWidth + bandDistance) + 10, height - height * average, bandWidth, height * average, 100);
  }
  
  // Record video
  if (enableRecording) {
    recordVideo();
  }

}
