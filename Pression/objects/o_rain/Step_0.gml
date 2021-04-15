/// @description Check Inside

if(irandom(900) == 5){
    if(!audio_is_playing(sfx_thunder)){
        audio_play_sound(sfx_thunder, 0, 0);
    }
}

if(raining = o_game.inside_building) //then we are set wrong
{	
	raining = !o_game.inside_building;
	
	if(raining)
	{
		part_emitter_region(rain_sys_background, rain_emit_background, 0, room_width, -64, 0, ps_shape_rectangle, ps_distr_linear);
		part_emitter_region(rain_sys_normal, rain_emit_normal, 0, room_width, -64, 0, ps_shape_rectangle, ps_distr_linear);
		part_emitter_region(rain_sys_foreground, rain_emit_foreground, 0, room_width, -64, 0, ps_shape_rectangle, ps_distr_linear);
		
		part_emitter_stream(rain_sys_background, rain_emit_background, rain_part_small, ceil(room_width * 0.02));
		part_emitter_stream(rain_sys_normal, rain_emit_normal, rain_part_normal, ceil(room_width * 0.01));
		part_emitter_stream(rain_sys_foreground, rain_emit_foreground, rain_part_large, ceil(room_width * 0.002));
		
		//make it so the rain doesn't start form the top of the screen
		repeat(5)
		{
			part_system_update(rain_sys_background);
			part_system_update(rain_sys_normal);
			part_system_update(rain_sys_foreground);
		}
		
		audio_sound_pitch(sfx_rain, 1);
		
		audio_sound_gain(sfx_thunder, 1, 0);
		audio_sound_pitch(sfx_thunder, 1);
	
		if(!audio_is_playing(sfx_rain))
		{
			audio_play_sound(sfx_rain, 0, 1);
		}
	}
	else
	{
		part_emitter_clear(rain_sys_background, rain_emit_background);
		part_emitter_clear(rain_sys_normal, rain_emit_normal);
		part_emitter_clear(rain_sys_foreground, rain_emit_foreground);
		
		part_particles_clear(rain_part_small);
		part_particles_clear(rain_part_normal);
		part_particles_clear(rain_part_large);
		part_particles_clear(rain_part_water);
		part_particles_clear(rain_part_splatter);
		
		audio_sound_pitch(sfx_rain, 0.5);
		
		audio_sound_gain(sfx_thunder, 0.7, 0);
		audio_sound_pitch(sfx_thunder, 0.5);
	
		if(!audio_is_playing(sfx_rain))
		{
			audio_play_sound(sfx_rain, 0, 1);
		}
	}
}

for(var i = 0; i < instance_number(o_mask_rain_splatter); i++)
{
	var instance = instance_find(o_mask_rain_splatter, i);
	var x1, y1, x2, y2, area;
	
	with(instance)
	{
		x1 = x;
		y1 = y;
		x2 = x + sprite_width;
		y2 = y + sprite_height;
		area = sprite_width * sprite_height;
	}
	
	part_emitter_region(rain_sys_splatter, rain_emit_splatter, x1, x2, y1, y2, ps_shape_rectangle, ps_distr_linear);
	part_emitter_burst(rain_sys_splatter, rain_emit_splatter, rain_part_splatter, ceil(area * 0.03));
	part_emitter_region(rain_sys_splatter, rain_emit_splatter, x1 + 2, x2 - 2, y1 + 2, y2 - 2, ps_shape_rectangle, ps_distr_linear);
	part_emitter_burst(rain_sys_splatter, rain_emit_splatter, rain_part_water, ceil(area * 0.002));
	part_emitter_clear(rain_sys_splatter, rain_emit_splatter);
}

for(var i = 0; i < instance_number(o_water); i++)
{
	var instance = instance_find(o_water, i);
	var x1, y1, x2, y2, area;
	
	with(instance)
	{
		x1 = x;
		y1 = y;
		x2 = x + sprite_width;
		y2 = y + sprite_height;
		area = sprite_width * sprite_height;
	}
	
	part_emitter_region(rain_sys_splatter, rain_emit_splatter, x1 + 2, x2 - 2, y1 + 2, y2 - 2, ps_shape_rectangle, ps_distr_linear);
	part_emitter_burst(rain_sys_splatter, rain_emit_splatter, rain_part_water, ceil(area * 0.005));
	part_emitter_clear(rain_sys_splatter, rain_emit_splatter);
}