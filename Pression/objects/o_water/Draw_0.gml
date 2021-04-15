/// @description Draw Water

var cam_width	= camera_get_view_width(view_camera[0]);
var cam_height	= camera_get_view_height(view_camera[0]);

var cam_x1 = camera_get_view_x(view_camera[0]);
var cam_y1 = camera_get_view_y(view_camera[0]);
var cam_x2 = cam_x1 + cam_width;
var cam_y2 = cam_y1 + cam_height;

var surf_width	= min(sprite_width, cam_width);
var surf_height = min(sprite_height, cam_height);
var surf_x1		= clamp(x, cam_x1 - 2, cam_x2 + 2);
var surf_y1		= clamp(y, cam_y1 - 2, cam_y2 + 2);
var surf_x2		= clamp(x + sprite_width, cam_x1 - 2, cam_x2 + 2);
var surf_y2		= clamp(y + sprite_height, cam_y1 - 2, cam_y2 + 2);

var scale = o_game.game_scale;

if(surf_x1 == surf_x2 || surf_y1 == surf_y2)
{
	//water surface is no longer on screen - do not draw it
}
else
{
	//check if surface exists and create if not
	if(!surface_exists(surf_water))
	{
		surf_water = surface_create(surf_width, surf_height + buffer);
	}

	//draw water
	if(surface_exists(surf_water))
	{	
		surface_set_target(surf_water);
			draw_clear_alpha(c_black, 0);
			draw_surface_part_ext(application_surface, (surf_x1 - cam_x1) * scale, ((surf_y1 - cam_y1) - (surf_y2 - surf_y1)) * scale, (surf_x2 - surf_x1) * scale, (surf_y2 - surf_y1) * scale, 0, surf_y2 - surf_y1 + buffer, 1 / scale, -1 / scale, c_white, 1.0);
		surface_reset_target();

		shader_set(shader);
			shader_set_uniform_f(u_time, get_timer() * time_factor);
			shader_set_uniform_f(u_offset, cam_x1 * 0.0016);
			gpu_set_tex_repeat_ext(u_disp_map, true);
			texture_set_stage(u_disp_map, sprite_get_texture(disp_map, 0));
			draw_surface_part(surf_water, 0, buffer, surf_x2 - surf_x1, surf_y2 - surf_y1, surf_x1, surf_y1);
		shader_reset();
	}
}