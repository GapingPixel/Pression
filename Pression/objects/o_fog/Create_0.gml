/// @description Initialize Fog

surf_fog	= -1;

time_factor = 0.000001;

fog_map0	= smp_fog;
fog_map1	= smp_fogNormal;

shader    = shader_fog;

u_offset		= shader_get_uniform(shader, "u_fOffset");
u_speed			= shader_get_uniform(shader, "u_speed");
u_time			= shader_get_uniform(shader, "u_time");
u_fog_colour	= shader_get_uniform(shader, "u_fogColor");
u_fog_scale		= shader_get_uniform(shader, "u_fogScale");
u_dist_amount	= shader_get_uniform(shader, "u_distAmount");
u_fog_density	= shader_get_uniform(shader, "u_fogDensity");
sampler0		= shader_get_sampler_index(shader, "sampler0");
texture0		= sprite_get_texture(fog_map0, 0);
sampler1		= shader_get_sampler_index(shader, "sampler1");
texture1		= sprite_get_texture(fog_map1, 0);

    
move_speed	= 0.025;
scale		= 0.75;
dist		= 0.05;
density		= 0.6;
    
fogColor_RGB[0] = 0.9;
fogColor_RGB[1] = 1.0;
fogColor_RGB[2] = 0.95;