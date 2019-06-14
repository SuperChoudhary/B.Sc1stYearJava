//Using a 2D heightmap image create a 3D heightmap

import peasy.*;

int scale = 3;
int columns;
int rows;
PImage heightmap;
float[][] matrix;

//PeasyCam
PeasyCam cam;

void setup()
{
  size(800, 800, P3D);
  columns = height/scale;
  rows = width/scale;
  matrix = new float[rows][columns];
 
  heightmap = loadImage("gray.png"); 
  heightmap.resize(width, height);
  
  //PeasyCam
  cam = new PeasyCam(this, 0);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(5000);
}

void draw()
{
  lights();
  background(255);
  //stroke(0);
  noStroke();
  //fill(255, 0, 0);
  fill(155);
  
  for (int y=0 ; y < columns ;  y++)
  {
    beginShape(TRIANGLE_STRIP);
    for (int x=0 ; x < rows ; x++)
    {
      color img = heightmap.pixels[index(x*scale, y*scale)];
      float oldG = red(img);
      matrix[x][y] = map(oldG, 0, 255, -50, 50); 
    }
    endShape();
   
  }
  
  translate(width/2, height/2);
  rotateX(PI/4);
  translate(-width/2, -height/2);
  translate(0, -100);
  
  for (int y=0 ; y < columns - 1 ; y++)
  {
    beginShape(TRIANGLE_STRIP);
    for (int x=0 ; x < rows ; x++)
    {
       vertex(x*scale, y*scale, matrix[x][y]);
       vertex(x*scale,(y+1)*scale, matrix[x][y+1]);
    }
    endShape();
  }
  
}

int index(int x, int y)
{
  return x + y * heightmap.width;
}
