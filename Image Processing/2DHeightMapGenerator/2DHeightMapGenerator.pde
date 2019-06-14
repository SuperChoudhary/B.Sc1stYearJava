int cols;
int rows;
int scl = 1;
float scale = 0.01;
float[][] colour;

void draw()
{
  size(800, 800);
  cols = height/scl;
  rows = width/scl;
  colour = new float[rows][cols];
  
  float yoff =  0;
  for (int y = 0; y < cols; y++)
  {
    float xoff = 0;
    for (int x = 0 ; x < rows ; x++)
    {
      colour[x][y] = map(noise(xoff, yoff), 0, 1, 0, 255);
      xoff += scale;
    }
    yoff += scale;
  }
 
  for (int y = 0 ; y < cols ; y++)
  {
    for (int x = 0; x < rows ; x++)
    {
      noStroke();
      fill(colour[x][y]);
      rect(x*scl, y*scl, scl, scl);
    }
  }
  
  save("2DHeightMap.png");
}
