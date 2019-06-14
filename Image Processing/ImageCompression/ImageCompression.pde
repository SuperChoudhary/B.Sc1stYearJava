//Image Compression Algorithms
//topLeft() takes the top-left most pixel in 8x8 matrix only
//averageColors() takes the average of the color of the pixels in 8x8 matrix
//provide a "test.jpg" image in folder

PImage image; //Original image
PImage newImage1; //Upper left pixel in 8x8 block
PImage newImage2; //Average of 64 pixels color in 8x8 block
int pixCounter = 0;
int pixCounter2 = 0;
int _r, _g, _b;

void setup() {
  size(384, 288);
  image = loadImage("test.jpg");

  //Creating images with 1/8th the width and height of the  original 3072 x 2304
  newImage1 = createImage(image.width/8 ,image.height/8, RGB);
  newImage2 = createImage(image.width/8 ,image.height/8, RGB);
  
  topLeft();
  averageColors();
  
  println("Image '1.jpeg' is a result of storing upper left most pixel only.");
  println("Image '2.jpeg' is a result of the average of 64 pixel colors.");
}

//Saves top left pixel from 8x8 pixel block in newImage1
void topLeft()
{
  image.loadPixels();
  loadPixels();
  
  for (int x = 0 ; x < image.height ; x+=8)
  {
    for (int y = 0 ; y < image.width ; y+=8)
    {
      newImage1.pixels[pixCounter] = image.get(y, x);
      pixCounter++;
    }
  }
  
  updatePixels();
  image(newImage1, 0, 0);
  save("1.jpg");
}

void averageColors() {
  int x ,y, c;
  PImage newImage2;
  float redSum, greenSum, blueSum;
  PImage block;
  
  image.loadPixels();
  
  newImage2 = createImage(ceil(image.width / 8), ceil(image.height / 8), RGB);  
  newImage2.loadPixels();
  block = createImage(8, 8, RGB);
  block.loadPixels();
        
  c = 0;
  redSum = greenSum = blueSum = 0;
  for (y = 0; y < (image.height - image.height % 8); y+=8)
    for (x = 0; x < (image.width - image.width % 8); x+=8) {      
       block.copy(image, x, y, 8, 8, 0, 0, 8, 8);
              
       for (int i = 0; i < block.pixels.length; ++i) {
         redSum+= red(block.pixels[i]);
         greenSum+= green(block.pixels[i]);
         blueSum+= blue(block.pixels[i]);
       }
       
       newImage2.pixels[c] = color(round(redSum / block.pixels.length), round(greenSum / block.pixels.length), round(blueSum / block.pixels.length));     
       redSum = greenSum = blueSum = 0;
       c++;
    }      
    
    image(newImage2, 0, 0);
    save("2.jpg");
}
