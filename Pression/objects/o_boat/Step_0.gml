/// @description Insert description here
// You can write your code in this editor

if x > 872 {
	sprite_index = s_onboat_wakeup;
	image_speed = 0;
	image_index = 0;
	instance_activate_object(o_player);
	o_camera.target = o_player;
}

if sprite_index != s_onboat then exit;

if x <= 872 {
	x+=.75;
	image_speed = 0.25;
}

/*
if gamepad_axis_value(0,gp_axislh) > .7 { 
	x+=1;
	image_speed = 0.3;
} else {
	image_speed = 0;
}



