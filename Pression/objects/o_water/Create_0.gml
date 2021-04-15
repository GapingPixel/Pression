/// @description Initialize

surf_water = -1;

buffer = 16;

shader = shader_water;

disp_map = s_disp_map_water;

time_factor = 0.000001;

u_time		= shader_get_uniform(shader, "u_fTime");
u_offset	= shader_get_uniform(shader, "u_fOffset");
u_disp_map	= shader_get_sampler_index(shader, "u_sDispMap");
