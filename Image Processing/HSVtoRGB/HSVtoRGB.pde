//Java code to convert HSV values to RGB for Processing IDE

import javax.swing.JColorChooser;
import java.awt.Color;

Color userColor;

float p, q, t, i, f, red, green, blue, hue, saturation, brightness, min, max;

void setup()
{
  size(500, 500);
  println("Select the HSV tab.");
  userColor  = JColorChooser.showDialog(null,"Select the HSV tab.", null);
  if(userColor != null) 
   fill(userColor.getRed(),userColor.getGreen(),userColor.getBlue());
   rect(0, 0, width, height);   

   RGBtoHSB(userColor.getRed(), userColor.getGreen(), userColor.getBlue());
   
}

public void RGBtoHSB(int red, int green, int blue)
{
  
  //finding min max
  max = Math.max(red, Math.max(green, blue));
  min = Math.min(red, Math.min(green, blue));
  
  //Calculate Hue
  if (max == min) hue = 0;
  else if (max == red)
  {
    hue = (green - blue) / (max-min);
  }
  else if (max == green)
  {
    hue = 2 + (blue - red / max - min);
  }
  else if (max == blue)
  {
    hue = 4 + (red - green / max - min);
  }
  
  hue *= 60;
  //if Hue is negative, add 360
  if (hue < 0) hue += 360;
  
  //Calculate Saturation
  saturation = max == 0 ? 0 : (1 - (min/max)) * 100;
  
  //Calculate Brightness
  brightness = max/255 * 100;
  
  //Converting RGB to HSB to check method
  HSBtoRGB(hue, saturation, brightness);
}

public void HSBtoRGB(float hue, float saturation, float brightness)
{
  i = int (3 * hue / 180);
  f = int (3 * hue / 180 - i);
  
  p = brightness * (1 - saturation);
  q = brightness * (1 - f * saturation);
  t = brightness * (1 - (1 - f) * saturation);
  
  if (i == 0) red = brightness; green = t; blue = p;
  if (i == 1) red = q; green = brightness; blue = p;
  if (i == 2) red = p; green = brightness; blue = t;
  if (i == 3) red = p; green = q; blue = brightness;
  if (i == 4) red = t; green = p; blue = brightness;
  if (i == 5) red = brightness; green = p; blue = q;
  
  print("Hue: " + hue + ", ");
  print("Saturation: " + saturation + ", ");
  print("Brightness: " + brightness + ". ");
  println();
    
}
