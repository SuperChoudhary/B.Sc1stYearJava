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
