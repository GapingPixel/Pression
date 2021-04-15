/// @description Draw Player

draw_sprite_ext(sprite_index, image_index, x, y, facing, image_yscale, image_angle, c_white, image_alpha);

var _x = x;
var _y = y - 30;
var _img_spd = .125;

if state == PlayerState.combat_draw_gun or state == PlayerState.combat_aim_gun or state == PlayerState.combat_holster_gun {
	revolver_frame = round(revolver_frame)
	draw_sprite(s_revolver,revolver_frame,_x,_y);

}

if state == PlayerState.combat_shoot_gun {
	if revolver_frame > 0 {
		revolver_frame -= _img_spd;
	}
	draw_sprite(s_revolver,revolver_frame,_x,_y);
}

if state == PlayerState.combat_reload_gun {
	revolver_frame += _img_spd;
	draw_sprite(s_revolver,revolver_frame,_x,_y);
}