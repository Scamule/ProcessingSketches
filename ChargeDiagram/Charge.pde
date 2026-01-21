public class Charge {
  
  PVector position; // Position of the Charge.
  int charge; // Coulombs; Charge's charge.
  double constant = 100; // Voltage scalar, can be overridden.
  int diameter = 40; // Pixels; diameter of the Charge.
  boolean move = false; // Used to determine if a Charge should move or not.
  
  /**
    This is the constructor for a Charge.
    @param x The horizontal pixel position.
    @param y The vertical pixel position.
    @param charge The charge of the Charge in coulombs.
    @return A Charge object at (x, y) with charge q = charge.
  */
  public Charge(int x, int y, int charge) {
    position = new PVector(x, y);
    this.charge = charge;
  }
  
  /**
    Get's the distance from the given x and y to the charge.
    @param x x position.
    @param y y position.
    @return The distance in pixels from (x, y) to the Charge.
  */
  public double getDistance(float x, float y)  {
    float distance = dist(x, y, this.position.x, this.position.y);
    return distance;
  }
  
  /**
    Calculates the voltage from this Charge given a distance.
    @param distance The distance from the charge in pixels.
    @return The voltage from this Charge at the given distance.
  */
  public double calculateVoltage(double distance) {
    double voltage;
    voltage = this.constant * ((double)this.charge / distance);
    return voltage;
  }
  
  /**
    Checks if the mouse is inside of this Charge.
    @return Returns true if the mouse is inside this Charge, false otherwise.a
  */
  public boolean checkMousePos() {
    return (dist(mouseX, mouseY, position.x, position.y) < diameter / 2);
  }
  
  /**
    The function must be called to be able to move the Charge with the mouse.
  */
  public void move() {
    // If someone isn't moving, then check if we want to move the current charge
    if (!someoneIsMoving) {
      if (checkMousePos() && mousePressed) {
        someoneIsMoving = true;
        move = true;
      } else if (!mousePressed) {
        move = false;
      }
    } 
    // If someone IS moving and it's the current charge, check if we want to move and then move if needed.
    else if (move) {
      if (!mousePressed) {
        move = false;
        someoneIsMoving = false;
      }
    }
    // Move the charge
    if (move) {
      this.position.x = mouseX;
      this.position.y = mouseY;
    }
  }
  
  /**
    Returns the location on the edge of the Charge at the given angle.
    @param angle The angle of the location on the edge of the Charge we want.
    @return Returns the location on the edge of the Charge at the given angle.
  */
  public PVector getStartOfField(float angle) {
    float xValue = (this.diameter / 2) * cos(angle);
    float yValue = (this.diameter / 2) * sin(angle);
    return new PVector(xValue, yValue);
  }
  
  /**
    Sets the scalar value for the voltage of this charge.
    @param constant The new voltage scalar value
  */
  public void setConstant(double constant) {
    this.constant = constant;
  }
  
  /**
    Draws the charge on the window.
  */
  public void display() {
    textAlign(CENTER);
    textSize(15);
    // Positive Charge
    if (this.charge > 0) {
      fill(0, 0, 255, 100);
      ellipse(this.position.x, this.position.y, diameter, diameter);
      fill(0);
      text(this.charge, this.position.x + 1, this.position.y + 5);
    } 
    // Negative Charge
    else if (this.charge < 0) {
      fill(255, 0, 0, 100);
      ellipse(this.position.x, this.position.y, diameter, diameter);
      fill(0);
      text(this.charge, this.position.x, this.position.y + 5);
    }
    // Zero charge Charge
    else {
      fill(50, 100);
      ellipse(this.position.x, this.position.y, diameter, diameter);
      // Text for negative charge
      fill(0);
      text(this.charge, this.position.x + 1, this.position.y + 5);
    } 
  }
}
