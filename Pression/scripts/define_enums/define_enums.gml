/// @description Only Required During Compiling
function define_enums() {

	//user input
	enum UserInput
	{
		left,
		right,
		up,
		down,
		run,
		jump,
		leap,
		action0,
		action1,
		aim,
		shoot,
		reload,
		length
	}

	//player
	enum PlayerState
	{
		normal_idle,
		normal_walk,
		normal_run,
		normal_stumble,
		normal_turn,
		normal_leap,
		normal_jump,
		normal_fall,
		normal_slide,
		hoist_align,
		hoist_walk,
		hoist_turn,
		hoist_jump,
		hoist_idle,
		hoist_up,
		hoist_down,
		hoist_swing,
		combat_draw_gun,
		combat_aim_gun,
		combat_holster_gun,
		combat_shoot_gun,
		combat_reload_gun,
		combat_turn,
		interact_door_align,
		interact_door_enter,
		interact_door_turn,
		interact_door_walk,
		interact_pulley_align,
		interact_pulley_turn,
		interact_pulley_walk,
		interact_pulley
	}

	//switches and pulleys
	enum Switch
	{
		harbor_inside
	}

	enum Pulley
	{
		harbor_inside
	}



}
