varying vec2 v_uv0;
varying vec2 v_uv0Mov;

uniform sampler2D sampler0;
uniform sampler2D sampler1;

uniform vec3 u_fogColor;
uniform float u_distAmount;
uniform float u_fogDensity;

void main()
{
    vec4 DF         = texture2D( gm_BaseTexture, v_uv0 );
    vec4 NM         = texture2D( sampler1, v_uv0 ) * 2.0 - 1.0;
    vec2 FG_coords = v_uv0Mov + (NM.rg * u_distAmount);
    
    vec4 FG        = texture2D( sampler0, FG_coords );
	
    vec3 Complete = mix(DF.rgb, FG.rgb * u_fogColor, FG.a);
    
    gl_FragColor = vec4(Complete.rgb, u_fogDensity);
}

