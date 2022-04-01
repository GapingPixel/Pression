/// @description Draw Player

draw_sprite_ext(sprite_index, image_index, x, y, facing, image_yscale, image_angle, c_white, image_alpha);

var _x = x;
var _y = y - 30;
var _img_spd = .125;

if state == PlayerState.combat_draw_gun or state == PlayerState.combat_aim_gun or state == PlayerState.combat_turn  {
	revolver_frame = round(revolver_frame);
	
	if ammo = 0 then revolver_frame = 0;
	
	if state == PlayerState.combat_draw_gun {
		revolver_hud_alpha += .15;
		revolver_hud_alpha = clamp(revolver_hud_alpha,0.0,1.0);
	}
	
	draw_sprite_ext(s_revolver,revolver_frame,_x,_y,1,1,0,c_white,revolver_hud_alpha);
	
}

if state == PlayerState.combat_shoot_gun {
	if revolver_frame > 0 {
		revolver_frame -= _img_spd;
	}
	draw_sprite(s_revolver,revolver_frame,_x,_y);
}

if state == PlayerState.combat_reload_gun {
	if ammo == 1 {
		revolver_frame += _img_spd;
		revolver_frame = clamp(revolver_frame,0,1);
	} else {
		revolver_frame += _img_spd;
		
	}
	draw_sprite(s_revolver,revolver_frame,_x,_y);
}


if state == PlayerState.combat_holster_gun {
	revolver_hud_alpha -= .15;
	revolver_hud_alpha = clamp(revolver_hud_alpha,0.0,1.0);
	if ammo == 0 {
		revolver_frame = 0;
		
	}
	draw_sprite_ext(s_revolver,revolver_frame,_x,_y,1,1,0,c_white,revolver_hud_alpha);
	
}

//Draw Stamina 
if state == PlayerState.normal_run {
	stamina -= .25; 
	if stamina <= 0 then state = PlayerState.normal_walk;
	
	
	stamina_hud_alpha += .25;
	
	draw_sprite_ext(s_stamina_bar,round(stamina),_x,_y,1,1,0,c_white,stamina_hud_alpha);
	
} else if stamina < max_stamina {
	stamina += .3; 
	stamina_hud_alpha -= .25;
	draw_sprite_ext(s_stamina_bar,round(stamina),_x,_y,1,1,0,c_white,stamina_hud_alpha);
} 

stamina_hud_alpha = clamp(stamina_hud_alpha,0.0,1.0);

if state == PlayerState.interact_pull_lever {
	if sprite_index == s_player_pull_lever_1 {
		button_hud_alpha += .25;
		button_hud_frame +=0.3;
	} else {
		button_hud_alpha -= .25;	
	}
	button_hud_alpha = clamp(button_hud_alpha,0.0,1.0);
	draw_sprite_ext(s_button_press,round(button_hud_frame),_x+2,_y+27,1,1,0,c_white,button_hud_alpha);
}




