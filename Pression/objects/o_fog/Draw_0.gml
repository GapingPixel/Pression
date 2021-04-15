/// @description Draw Fog

if(!o_game.inside_building)
{
	var x_off = camera_get_view_x(view_camera[0]);
	var y_off = camera_get_view_y(view_camera[0]);

	if(!surface_exists(surf_fog))
	{
		surf_fog = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));
	}

	if(surface_exists(surf_fog))
	{
		if(surface_get_width(surf_fog) != surface_get_width(application_surface))
		{
			surface_resize(surf_fog, surface_get_width(application_surface), surface_get_height(application_surface));
		}
		else
		{
			surface_copy(surf_fog, 0, 0, application_surface);
	
			var time = get_timer() * time_factor;
	
			shader_set(shader);
				shader_set_uniform_f(u_offset, x_off * 0.0016);
		        shader_set_uniform_f(u_time, time);
		        shader_set_uniform_f(u_speed, move_speed);
		        shader_set_uniform_f(u_fog_scale, scale);
		        shader_set_uniform_f(u_dist_amount, dist);
		        shader_set_uniform_f(u_fog_colour, fogColor_RGB[0], fogColor_RGB[1], fogColor_RGB[2]);
				shader_set_uniform_f(u_fog_density, density);
		        gpu_set_tex_repeat_ext(sampler0, true);
		        gpu_set_tex_repeat_ext(sampler1, true);
		        texture_set_stage(sampler0,texture0);
		        texture_set_stage(sampler1,texture1);
        
				draw_surface_stretched(surf_fog, x_off, y_off, _game_width, _game_height);
		
		    shader_reset();
		}
	}
}