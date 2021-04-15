/// @description Clean Up

part_emitter_destroy(rain_sys_background, rain_emit_background);
part_emitter_destroy(rain_sys_normal, rain_emit_normal);
part_emitter_destroy(rain_sys_foreground, rain_emit_foreground);
part_emitter_destroy(rain_sys_splatter, rain_emit_splatter);

part_system_destroy(rain_sys_background);
part_system_destroy(rain_sys_normal);
part_system_destroy(rain_sys_foreground);
part_system_destroy(rain_sys_splatter);