/// @description Update Size of Emitter

part_particles_clear(rain_part_small);
part_particles_clear(rain_part_normal);
part_particles_clear(rain_part_large);
part_particles_clear(rain_part_water);
part_particles_clear(rain_part_splatter);

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