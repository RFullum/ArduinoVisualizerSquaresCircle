public class EllipseFun
{
  // Ellipse location and velocity variables
  float centerW;
  float centerH;
  float eWidth;
  float eHeight;
  float xSpeed;
  float ySpeed;
  float speedLimit = 50.0f;    // Adjust maximum vector speed
  
  // Color 1
  color clr1 = color(0, 0, 0, 255);
  float clr1R = 0.0f;
  float clr1G = 0.0f;
  float clr1B = 0.0f;
  float clr1A = 100.0f;
  
  // Color 2
  color clr2 = color(255, 255, 255, 255);
  float clr2R = 255.0f;
  float clr2G = 255.0f;
  float clr2B = 255.0f;
  float clr2A = 255.0f;
  
  // Vectors
  PVector location;
  PVector velocity;
  
  // Stroke control
  Boolean strokeGrow = true;
  float strokeCounter = 2.0f;
  
  // Constructor
  EllipseFun()
  {
    // Center screen
    centerW = width / 2.0f;
    centerH = height / 2.0f;
    
    // Initialize width and height of ellipse
    eWidth = 0.0f;
    eHeight = 0.0f;
    
    // Random initial vector speeds
    xSpeed = random(-10, 10);
    ySpeed = random(-10, 10);
    
    // Initialize vectors
    location = new PVector(centerW, centerH);
    velocity = new PVector(xSpeed, ySpeed);
  }
  
  
  /// Draws the ellipse: float ampVal 0.0f to 1.0f
  void drawEllipse(float ampVal)
  {
    // ampVal modifies the width and height of ellipse
    radiiControl(ampVal);
    
    // Vector to new location by velocity
    location.add(velocity);
    
    // bound to screen: Edge Bounces
    if ( (location.x > width) || (location.x < 0) )
    {
      // Reverse X direction
      velocity.x *= -1;
      
      // new random color 1
      clr1R = random(0, 255);
      clr1G = random(0, 255);
      clr1B = random(0, 255);
      clr1A = random(100, 255);
      clr1 = color(clr1R, clr1G, clr1B, clr1A);
      
      // Boost speed
      xSpeed += ampVal * 2.0f;
    }
    
    if ( (location.y > height) || (location.y < 0) )
    {
      // Reverse Y direction
      velocity.y *= -1;
      
      // New random color 2
      clr2R = random(0, 255);
      clr2G = random(0, 255);
      clr2B = random(0, 255);
      clr2A = random(100, 255);
      clr2 = color(clr2R, clr2G, clr2B, clr2A);
      
      // Boost speed
      ySpeed += ampVal * 2.0f;
    }
    
    //
    // Draw ellipse
    //
    
    // evolve strokeWeight
    strokeSizer();
    
    // lerps using color 1, 2, and ampVal for ellipse and stroke
    color ellipseColor = lerpColor(clr1, clr2, ampVal);
    color strokeColor = lerpColor(clr2, clr1, ampVal);
    
    // Drawing the actual ellipse
    fill(ellipseColor);
    strokeWeight(strokeCounter);
    stroke(strokeColor);
    blendMode(DIFFERENCE);
    ellipse(location.x, location.y, eWidth, eHeight);
    
    // When ellipse hits speed limit, new random velocity vector
    if (abs(xSpeed) > speedLimit || abs(ySpeed) > speedLimit)
    {
      xSpeed = random(-10, 10);
      ySpeed = random(-10, 10);
    }
  }
  
  // Changes size of width and height per ampVal
  void radiiControl(float ampVal_)
  {
    eWidth = 200.0f + (50.0f * ampVal_);
    eHeight = 200.0f - (50.0f * ampVal_);
  }
  
  // Grows and shrinks stroke by growthFactor
  void strokeSizer()
  {
    float growthFactor = 0.5f;
    
    if ( (strokeCounter < 1.0f) || (strokeCounter > eWidth) )
    {
      strokeGrow = !strokeGrow;
    }
    
    if (strokeGrow)
    {
      strokeCounter += growthFactor;
    }
    else
    {
      strokeCounter -= growthFactor;
    }
  }
  
}
