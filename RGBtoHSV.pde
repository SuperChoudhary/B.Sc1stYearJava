//Java code to convert RGB to HSV

import javax.swing.JColorChooser;
import java.awt.Color;

Color userColor;

int hue, saturation, brightness, min, max;

void setup()
{
   size(500, 500);
   println("Select the RGB tab.");
   //User Java's Color Chooser to get color and extract RGB value
   userColor  = JColorChooser.showDialog(null,"Select the RGB tab.", null);
   if(userColor != null) 
   fill(userColor.getRed(),userColor.getGreen(),userColor.getBlue());
   rect(0, 0, width, height);   
   
   print("Red: " + userColor.getRed() + ", ");
   print("Green: " + userColor.getGreen() + ", ");
   print("Blue: " + userColor.getBlue() + ".");
   println();
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
  
  print("Hue: " + hue + "°, ");
  print("Saturation: " + saturation + "%, ");
  print("Brightness: " + brightness + "%.");
  
}
  
 
  
