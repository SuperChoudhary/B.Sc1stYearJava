//Hue Invert and Greyscale using Image Processing
//replace RainbowLion.jpg with own image

PImage image;
PImage hueInvert;
PImage greyscale;
  
void setup()
{
  size(500, 500);
  image = loadImage("RainbowLion.jpg");
  greyscale = createImage(500, 500, HSB);
  hueInvert = createImage(500, 500, HSB);
  println("Press LEFT Mouse Button for Hue Invert.");
  println("Press RIGHT Mouse Button for Greyscale.");
}

void draw()
{ 
  loadPixels();
  image.loadPixels();
  for (int x = 0; x < width; x++)
  {
    for (int y = 0; y < height; y++)
    {
      int loc = x + y * width;
      float h = hue(image.pixels[loc]);
      float s = saturation(image.pixels[loc]);
      float br = brightness(image.pixels[loc]);
      
      //Hue Invert, by subtracting current hue value with max hue value i.e 1.0
      colorMode(HSB, 1.0);
      hueInvert.pixels[loc] = color(1-h, s, br);
      
      //As greyscale is basically 0 saturation
      greyscale.pixels[loc] = color(h, 0, br);
     
    }
  }
  updatePixels();
  
  //Default original image
  image(image, 0, 0);
  
  //press right mouse button for greyscale
  if (mousePressed && mouseButton == RIGHT) 
  {
    image(greyscale, 0, 0);
  }
  //press left mouse button for hue inverted image
  else if (mousePressed && mouseButton == LEFT)
  {
    image(hueInvert, 0, 0);
  }
}
