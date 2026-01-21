// Global stuff //<>//

static boolean someoneIsMoving = false;

int extraBounds = 2000; // Pixels; How far outside the frame a field line can go.
int[] values = {-1, 4, 1, -2}; // Coulombs; The charges' charges.
Charge[] charges = new Charge[values.length]; // The array for the charges.
float voltage = 0; // Volts; used to store the voltage across the program. Doesn't need to be global, but it is anyway.
double percentError = 0.05; // How many volts a pixel can be away from a real number and still display a black pixel, aka, the potential line thinkness setting.
int constant = 200; // This is a scaler for the voltage values. This can be treated as a weight for each charge, but that's kind of pointless.
int fieldLinesMultiplier = 8; // The multiplier for how many field lines a charge will have (proportional to the charge as well.)
double maxVoltage = 15; // The maximum absolute voltage for the potential lines, so your computer doesn't explode or something.
boolean showMouse = true; // If you want to see your mouse position in the console.
boolean showVoltage = true; // If you want to see the voltage of the pixel your mouse is on.
boolean equipotentialLines = true; // If you want to see the potential lines.
boolean fieldLines = false; // If you want to see the field lines.
boolean showNegativeFieldLines = false; // If you want the negative charges to also be a source of field lines.

public void setup() {
  // Basic stuff
  size(1600, 900, P2D);
  frameRate(60);
  // Charge initialization, they'll all be equally spaced horizontally in the middle of the window
  for (int i = 0; i < charges.length; ++i) {
    charges[i] = new Charge((i + 1) * width / (charges.length + 1), height / 2, values[i]);
    charges[i].setConstant(constant);
  }
}

public void draw() {
  background(200);
  // Display and move charges.
  for (int i = 0; i < charges.length; i++) {
    charges[i].display();
    charges[i].move();
  }

  // The magic

  // -------Equipotential Lines--------
  if (equipotentialLines) {
    loadPixels();
    for (int j = 0; j < height; j++) {
      for (int i = 0; i < width; i++) {
        // Calculate voltage
        voltage = 0;
        for (int k = 0; k < charges.length; k++) {
          double d = charges[k].getDistance(i, j);
          voltage += charges[k].calculateVoltage(d);
        }

        // If the voltage is close enough to make it a line
        if (abs(voltage - (int)voltage) < percentError) {
          int pixelPosition = j * width + i;
          color black = color(0);
          if (abs(voltage) < maxVoltage) {
            pixels[pixelPosition] = black;
          }
        }
      }
    }
    updatePixels();
  }

  // ------------Field Lines------------

  if (fieldLines) {
    loadPixels();
    // Field Variables
    PVector currentPosition = new PVector();
    PVector fieldDirection = new PVector();
    float angle = 0; // Angle position where the field line will start
    int numberOfLines = 0;
    float radianPerLine;
    float magnitudeOfField;

    for (int i = 0; i < charges.length; i++) {
      numberOfLines = abs(charges[i].charge) * fieldLinesMultiplier;

      // For every start point
      for (int lineNumber = 0; lineNumber < numberOfLines; lineNumber++) {
        radianPerLine = TWO_PI / numberOfLines;
        // Offset the lines by "half a line"
        angle = radianPerLine * lineNumber + (TWO_PI / (numberOfLines * 2));
        // Starting position
        currentPosition = new PVector(charges[i].position.x, charges[i].position.y);
        currentPosition.add(charges[i].getStartOfField(angle));

        // While the point is inside the actual screen
        while (0 - extraBounds < currentPosition.x && currentPosition.x < width + extraBounds && 0 - extraBounds < currentPosition.y && currentPosition.y < height + extraBounds) {
          // Stop the field line when it hits a charge.
          boolean doLoop = true;
          for (int check = 0; check < charges.length; check++) {
            if (dist(currentPosition.x, currentPosition.y, charges[check].position.x, charges[check].position.y) < charges[check].diameter / 2 - 1) {
              doLoop = false;
            }
          }
          if (!doLoop) {
            break;
          } else if (charges[i].charge < 0 && !showNegativeFieldLines) {
            break;
          }

          // Make the field map itself out aka find field direction === volatage / distance for magnitude
          magnitudeOfField = 0;
          PVector tempDirection = new PVector();
          fieldDirection = new PVector();

          for (int j = 0; j < charges.length; j++) {
            float d = (float)charges[j].getDistance(currentPosition.x, currentPosition.y);
            magnitudeOfField = ((float)charges[j].calculateVoltage(d)) / d;

            // Get the field vector
            tempDirection = new PVector (currentPosition.x, currentPosition.y);
            tempDirection.sub(charges[j].position).normalize();
            tempDirection.setMag(magnitudeOfField);
            fieldDirection.add(tempDirection);
          }

          // Incriment the field line current position in the direction of the field
          fieldDirection.normalize();
          if (charges[i].charge < 0) {
            currentPosition.sub(fieldDirection);
          } else {
            currentPosition.add(fieldDirection);
          }

          // Put a black pixel at the current position
          color black = color(0);
          if (0 < currentPosition.x && currentPosition.x < width && 0 < currentPosition.y && currentPosition.y < height) {
            int pixelPosition = ((int)currentPosition.y * width + (int)currentPosition.x);
            pixels[pixelPosition] = black;
          }

          // Now loop and repeat the process until the line is done
        }
      }
    }
    updatePixels();
  }
  
  if (showMouse) {
    print("mousePos(x, y): " );
    println("(" + mouseX + ", " + mouseY + ")");
  }

  if (showVoltage) {
    voltage = 0;
    for (int k = 0; k < charges.length; k++) {
      double d = charges[k].getDistance(mouseX, mouseY);
      voltage += charges[k].calculateVoltage(d);
    }
    println("Voltage: " + voltage);
  }

}
