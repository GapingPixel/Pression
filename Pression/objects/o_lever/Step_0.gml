/// @description Insert description here
// You can write your code in this editor
if !lever_used and round(image_index) == 0 {
	image_index = 0;
	image_speed = 0;
}

if instance_exists(o_player) {

	if o_player.state == PlayerState.interact_pull_lever {
		visible = false;
	} else {
		visible = true;
	}
}
