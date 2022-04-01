/// @description Insert description here
// You can write your code in this editor
if sprite_index == s_player_walk_to_run {
	sprite[PlayerState.normal_run, 0] = s_player_run;
	
}

if sprite_index == s_player_pull_lever_2 {
	state = PlayerState.normal_idle;
	with o_lever {
		image_index = image_number-1;
	}
}

if sprite_index == s_player_pull_lever_1 {
	sprite_index = s_player_pull_lever_2;
	image_index = 0;
	image_speed = .4;
	with o_gate {
		image_speed = 1;
	}
}




