//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

uniform float u_fTime;
uniform float u_fOffset;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vDispcoord;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
	vec2 uv = in_TextureCoord;
	uv.x = uv.x + (0.025 * u_fTime);
	v_vDispcoord = uv + vec2(u_fOffset, 0.0);
	
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}
