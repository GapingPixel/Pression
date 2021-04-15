/// @description Initialize Rain System

raining = o_game.inside_building;

audio_play_sound(sfx_thunder, 0, 0);

audio_sound_gain(sfx_rain, 0, 0);
audio_sound_gain(sfx_rain, 0.5, 3000);

rain_sys_background = part_system_create_layer("EF_Rain_Background", true);
rain_sys_normal		= part_system_create_layer("EF_Rain_Normal", true);
rain_sys_foreground = part_system_create_layer("EF_Rain_Foreground", true);
rain_sys_splatter	= part_system_create_layer("IN_Rain_Splatter", true);

rain_part_small = part_type_create();
part_type_shape(rain_part_small, pt_shape_disk);
part_type_size(rain_part_small, 0.02, 0.02, 0, 0);
part_type_speed(rain_part_small, 8, 12, 0, 0);
part_type_direction(rain_part_small, 270, 300, 0, 0);
part_type_life(rain_part_small, 60, 60);
part_type_scale(rain_part_small, 0.5, 12);
part_type_color1(rain_part_small, make_color_hsv(130,90,160));
part_type_alpha1(rain_part_small, 0.9);
part_type_orientation(rain_part_small, 20, 20, 0, 0, false);

rain_part_normal = part_type_create();
part_type_shape(rain_part_normal, pt_shape_disk);
part_type_size(rain_part_normal, 0.04, 0.04, 0, 0);
part_type_speed(rain_part_normal, 16, 24, 0, 0);
part_type_direction(rain_part_normal, 270, 300, 0, 0);
part_type_life(rain_part_normal, 60, 60);
part_type_scale(rain_part_normal, 0.5, 12);
part_type_color1(rain_part_normal, make_color_hsv(130,90,160));
part_type_alpha1(rain_part_normal, 0.6);
part_type_orientation(rain_part_normal, 20, 20, 0, 0, false);

rain_part_large = part_type_create();
part_type_shape(rain_part_large, pt_shape_disk);
part_type_size(rain_part_large, 0.06, 0.06, 0, 0);
part_type_speed(rain_part_large, 32, 48, 0, 0);
part_type_direction(rain_part_large, 270, 300, 0, 0);
part_type_life(rain_part_large, 60, 60);
part_type_scale(rain_part_large, 0.5, 12);
part_type_color1(rain_part_large, make_color_hsv(130,90,160));
part_type_alpha1(rain_part_large, 0.3);
part_type_orientation(rain_part_large, 20, 20, 0, 0, false);

rain_part_water = part_type_create();
part_type_shape(rain_part_water, pt_shape_circle);
part_type_size(rain_part_water, 0.01, 0.1, 0.01, 0);
part_type_direction(rain_part_water, 80, 100, 0, 0);
part_type_life(rain_part_water, 4, 6);
part_type_scale(rain_part_water, 1, 0.5);
part_type_color1(rain_part_water, c_white);
part_type_alpha1(rain_part_water, 0.5);

rain_part_splatter = part_type_create();
part_type_shape(rain_part_splatter, pt_shape_disk);
part_type_size(rain_part_splatter, 0.01,0.03,0,0);
part_type_speed(rain_part_splatter, 1,3,0,0);
part_type_direction(rain_part_splatter, 20,160,0,0);
part_type_gravity(rain_part_splatter, 1,270);
part_type_life(rain_part_splatter, 2, 6);
part_type_scale(rain_part_splatter, 1, 1);
part_type_color2(rain_part_splatter, make_color_hsv(130,90,160), c_white);
part_type_alpha2(rain_part_splatter, 1, 0);

rain_emit_background	= part_emitter_create(rain_sys_background);
rain_emit_normal		= part_emitter_create(rain_sys_normal);
rain_emit_foreground	= part_emitter_create(rain_sys_foreground);
rain_emit_splatter		= part_emitter_create(rain_sys_splatter);