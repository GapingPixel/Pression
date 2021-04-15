//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_fAmbient;
uniform sampler2D u_sLight;

void main()
{
    gl_FragColor = (u_fAmbient + texture2D(u_sLight, v_vTexcoord)) * texture2D(gm_BaseTexture, v_vTexcoord);
}