attribute vec3 in_Position;
attribute vec2 in_TextureCoord;

uniform float u_speed;
uniform float u_time;
uniform float u_fogScale;
uniform float u_fOffset;

varying vec2 v_uv0;
varying vec2 v_uv0Mov;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
        
    v_uv0       = in_TextureCoord;    
    v_uv0Mov    = (in_TextureCoord + vec2(u_speed,0.0) * u_time);
    v_uv0Mov.x *= u_fogScale; //stretch the fog
	v_uv0Mov = v_uv0Mov + vec2(u_fOffset, 0.0);
}

