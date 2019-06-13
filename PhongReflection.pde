//Phone Reflection representing SpecularFocus, SpecularContribution and DiffuseContribution using GLSL Shaders in Processing IDE

import peasy.*;
import javax.swing.*;

PeasyCam cam;

PShape torus;
PShader texlightShader;
PImage tiles;

float sf = 1.0;
float sc = 1.0;
float dc = 1.0;

float noLights = 1;

void setup()
{
  lights();
  //JSlider first = new JSlider(JSlider.HORIZONTAL, 0, 10);
  
  size(500, 500, P3D);
    
  cam = new PeasyCam(this, 0);
  cam.setMinimumDistance(500);
  cam.setMaximumDistance(2000);
  
  //tiles = loadImage("tile.png");
  texlightShader =  loadShader("lightfrag.glsl", "lightvert.glsl");
  
  torus = getTorus(150.0, 50.0, 10, 30, tiles);
  
}

void draw()
{
    shader(texlightShader);
    background(30);
    //lights();
    pointLight(255, 0, 0, mouseX, mouseY, 200);
    //spotLight(255, 0, 0, 80, 20, 40, -1, 0, 0, PI/2, 2);
    //pointLight(255, 0, 0, 200, 200, 200);
    
    
    if (keyPressed)
    {
      if (key == 'q' && sf >= 0.0) sf -= 0.1;
      else if(key == 'w' && sf <= 1.0) sf += 0.1;
      
      if (key == 'a' && sc >= 0.0) sc -= 0.1;
      else if (key == 's' && sc <= 1.0) sc += 0.1;
      
      if (key == 'z' && sc >= 0.0) dc -= 0.1;
      else if (key == 'x' && sc <= 1.0) dc += 0.1;
    }
    
    texlightShader.set("SpecularFocus", sf);
    texlightShader.set("SpecularContribution", sc);
    texlightShader.set("DiffuseContribution", dc);
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
         sh.vertex(x, y, z);
         
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

varying vec4 vertColor;

void main() {
  gl_FragColor = vertColor;
}
*/

//VERTEX SHADER
/*
#define PROCESSING_LIGHT_SHADER

uniform mat4 modelview;
uniform mat4 transform;
uniform mat3 normalMatrix;

uniform vec4 lightPosition;
uniform float SpecularFocus;
uniform float SpecularContribution;
uniform float DiffuseContribution;

attribute vec4 vertex;
attribute vec4 color;
attribute vec3 normal;

varying vec4 vertColor;

void main(){
    gl_Position = transform*vertex;
    vec3 vertexCamera = vec3(modelview * vertex);
    vec3 transformedNormal = normalize(normalMatrix * normal); //Vertex normal direction
	
    vec3 dir = normalize(lightPosition.xyz - vertexCamera); //Vertex to light direction 
    float amountDiffuse = max(0.0, dot(dir, transformedNormal));
	
	// calculate the vertex position in eye coordinates
	vec3 vertexViewDir = normalize(-vertexCamera);
	
	// calculate the vector corresponding to the light source reflected in the vertex surface.
	// lightDir is negated as GLSL expects an incoming (rather than outgoing) vector
	vec3 lightReflection = reflect(-dir, transformedNormal);
	
	// specular light is dot product of light reflection vector and our viewing vector.
	// the closer we are to the reflection angle, the greater the specular sheen.
	float amountSpecular = max(0.0, dot(lightReflection, vertexViewDir));
	
	// apply an additional pow() to focus the specular effect
	amountSpecular = pow(amountSpecular, SpecularFocus);
	
	// calculate actual light intensity
	float light = SpecularContribution * amountSpecular + DiffuseContribution * amountDiffuse;
	vertColor = vec4(light, light, light, 1) * color;
	
}
*/
