//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vDispcoord;

uniform sampler2D u_sDispMap;

void main()
{	
	vec2 persp_correction = vec2(0.0, 0.0); //vec2(2.0 * (0.5 - v_vDispcoord.x) * (1.0 - v_vDispcoord.y), 0.0); 
	
	vec2 disp = texture2D(u_sDispMap, v_vDispcoord + persp_correction).rg;
	
	vec2 uv = v_vTexcoord;
	uv.xy = vec2(uv.x + ((disp.r - 0.5) * 0.05), uv.y + ((disp.g - 0.5) * 0.05));
	
	vec4 final_colour = v_vColour;
	final_colour.rgb = vec3(v_vColour.r * 0.3, v_vColour.g * 0.33, v_vColour.b * 0.35);
	
	gl_FragColor = final_colour * texture2D(gm_BaseTexture, uv);
}
