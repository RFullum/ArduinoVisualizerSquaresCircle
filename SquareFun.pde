public class SquareFun
{
  // General values
  int numSquares = 0;
  int fillVal = 0;
  
  // Dimensions for each rectangle
  float rectangleWidth = 0.0f;
  float rectangleHeight = 0.0f;
  
  // Origin of each rectangle
  float xCoord = 0.0f;
  float yCoord = 0.0f;
  
  // Base Color of each rectangle
  color baseColor = color(0.0f, 0.0f, 0.0f, 255.0f);
  float baseR = 0.0f;
  float baseG = 0.0f;
  float baseB = 0.0f;
  float baseA = 255.0f;
  
  // Second color of each rectangle
  color shiftColor = color(0.0f, 0.0f, 0.0f, 255.0f);
  float shiftR = 0.0f;
  float shiftG = 0.0f;
  float shiftB = 0.0f;
  float shiftA = 255.0f;
  
  // Alpha controls
  Boolean visibility = true;
  Boolean alphaLevelRise = true;
  
  // Amp thresholds: Adjust accordingly
  float threshHi = 0.5f;
  float threshLo = 0.2f;
  int threshCount = 0;
  int rgbCount = 0;
  
  // Constructor
  SquareFun()
  {
  }
  
  // Sets the size of the rectangles
  void setSize(int numSqrs)
  {
    numSquares = numSqrs;
    rectangleWidth = float(width) / float(numSqrs);
    rectangleHeight = float(height) / float(numSqrs);
  }
  
  // Set location and shiftColor
  void setLocation(int indexI, int indexJ)
  {    
    xCoord = (indexI % numSquares) * rectangleWidth;
    yCoord = (indexJ % numSquares) * rectangleHeight;
    
    shiftR = 255 - (xCoord % 255);
    shiftG = 255 - (yCoord % 255);
    shiftB = (xCoord + yCoord) % 255;
    shiftColor = color(shiftR, shiftG, shiftB, 255);
  }
  
  // Sets base color, white or black, alternating
  void setColor(int colorVal)
  {
    baseR = colorVal;
    baseG = colorVal;
    baseB = colorVal;
  }
  
  // Draws the rectangle and modifies color based on amp
  void drawRect(float amp)
  {
    // Alter colors values when amp above threshold
    if (amp > threshHi)
    {
      shiftR = (shiftR + 1) % 255;
      shiftG = (shiftG + 2) % 255;
      shiftB = (shiftB + 3) % 255;
    }
    
    baseColor = color(baseR, baseG, baseB, baseA);
    shiftColor = color(shiftR, shiftG, shiftB, shiftA);
 
    color displayColor = lerpColor(baseColor, shiftColor, amp);

    noStroke();
    fill(displayColor);
    rect(xCoord, yCoord, rectangleWidth, rectangleHeight);
  }

}
