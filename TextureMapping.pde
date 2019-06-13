//Using GLSL shaders to perform texture mapping on a torus

import peasy.*;

PeasyCam cam;

PShape torus;
PShader tileShader;
PImage tiles;

void setup()
{
  size(500, 500, P3D);
    
  cam = new PeasyCam(this, 0);
  cam.setMinimumDistance(500);
  cam.setMaximumDistance(2000);
  
  tiles = loadImage("tile.jpg");
  tileShader =  loadShader("frag.glsl", "vert.glsl");
  
  torus = getTorus(150.0, 50.0, 10, 30, tiles);
  
}

void draw()
{
    shader(tileShader);
    background(30);
    lights();
    fill(30);
    shape(torus);
}

// Example of use:     torus = getTorus(200,100,32,32);
PShape getTorus(float outerRad, float innerRad, int numc, int numt, PImage tiles) {
  textureMode(NORMAL);
  PShape sh = createShape();
  sh.beginShape(TRIANGLE_STRIP);
  sh.noStroke();
  //Added to add tile texture
  sh.texture(tiles);

  float x, y, z, s, t, u, v;
  float nx, ny, nz;
  float a1, a2;
  int idx = 0;
  for (int i = 0; i < numc; i++) 
  {
    for (int j = 0; j <= numt; j++) 
    {
      for (int k = 1; k >= 0; k--) 
      {
         s = (i + k) % numc + 0.5;
         t = j % numt;
         u = s / numc;
         v = t / numt;
         a1 = s * TWO_PI / numc;
         a2 = t * TWO_PI / numt;
 
         x = (outerRad + innerRad * cos(a1)) * cos(a2);
         y = (outerRad + innerRad * cos(a1)) * sin(a2);
         z = innerRad * sin(a1);
 
         nx = cos(a1) * cos(a2); 
         ny = cos(a1) * sin(a2);
         nz = sin(a1);
         sh.normal(nx, ny, nz);
         sh.vertex(x, y, z, u, v);
         
      }
    }
  }
   sh.endShape(); 
  return sh;
}

//FRAG SHADER
/*
#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
  gl_FragColor = texture2D(texture, vertTexCoord.st) * vertColor;
}
*/

//VERT SHADER
/*
uniform mat4 transform;
uniform mat4 texMatrix;

attribute vec4 position;
attribute vec4 color;
attribute vec2 texCoord;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
  gl_Position = transform * position;

  vertColor = color;
  vertTexCoord = texMatrix * vec4(texCoord, 1.0, 1.0);
}
*/
