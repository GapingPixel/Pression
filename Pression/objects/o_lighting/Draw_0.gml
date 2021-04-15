/// @description Draw Lighting Surface

var x_off = camera_get_view_x(view_camera[0]);
var y_off = camera_get_view_y(view_camera[0]);

if(!surface_exists(surf_lighting))
{
	surf_lighting = surface_create(camera_get_view_width(global.Camera), camera_get_view_height(global.Camera));
}

if(surface_exists(surf_lighting))
{
	//create lighting surface
	surface_set_target(surf_lighting);
		draw_clear_alpha(c_black, 1);
		gpu_set_blendmode(bm_add);
		switch(room)
		{
			case r_harbor_inside:
				if(o_game.switch_id[Switch.harbor_inside]) //draw lightmap
				{
					if(array_height_2d(lightmap) > 0)
					{
						if(sprite_exists(lightmap[0, 0]))
						{
							draw_sprite(lightmap[0, 0], 0, lightmap[0, 1] - x_off, lightmap[0, 2] - y_off);
						}
					}
				}
				else if(array_height_2d(lightmap) > 1)
				{
					if(sprite_exists(lightmap[1, 0]))
					{
						draw_sprite(lightmap[1, 0], 0, lightmap[1, 1] - x_off, lightmap[1, 2] - y_off);
					}
				}
			break;
		}
		
		//draw point lights
		with(o_point_light)
		{
			draw_set_alpha(intensity);
			draw_circle_color(x - x_off, y - y_off, radius, colour, c_black, false);
			draw_set_alpha(1);
		}
		gpu_set_blendmode(bm_normal);
	surface_reset_target();

	//draw lighting to screen
	if(!surface_exists(surf_environment))
	{
		surf_environment = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));
	}
	
	if(surface_exists(surf_environment))
	{
		if(surface_get_width(surf_environment) != surface_get_width(application_surface))
		{
			surface_resize(surf_environment, surface_get_width(application_surface), surface_get_height(application_surface));
		}
		else
		{
			surface_copy(surf_environment, 0, 0, application_surface);
		
			var lightmap_texture	= surface_get_texture(surf_lighting);
			var u_ambient_light		= shader_get_uniform(shader_multiply, "u_fAmbient");
			var u_light_sampler		= shader_get_sampler_index(shader_multiply, "u_sLight");
	
			shader_set(shader_multiply);
				shader_set_uniform_f(u_ambient_light, ambient_light);
				texture_set_stage(u_light_sampler, lightmap_texture);
				draw_surface_stretched(surf_environment, x_off, y_off, _game_width, _game_height);
			shader_reset();
		}
	}
}