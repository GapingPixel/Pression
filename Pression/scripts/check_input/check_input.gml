/// @function check_input()
/// @argument input_array
/// @argument gamepad_slot
function check_input(argument0, argument1) {

	var input	= argument0;
	var slot	= argument1;


	//test
	var gp_num = gamepad_get_device_count();

	for(var i = 0; i < gp_num; i++)
	{
		if(gamepad_is_connected(i))
		{
			slot = i;
		}
	}




	if(gamepad_is_connected(slot))
	{
		o_game.gamepad_connected = true;
	
		//gamepad
		input[@ UserInput.left]		= gamepad_button_check(slot, gp_padl) || gamepad_axis_value(slot, gp_axislh) < -0.3;
		input[@ UserInput.right]	= gamepad_button_check(slot, gp_padr) || gamepad_axis_value(slot, gp_axislh) > 0.3;
		input[@ UserInput.up]		= gamepad_button_check(slot, gp_padu) || gamepad_axis_value(slot, gp_axislv) < -0.3;
		input[@ UserInput.down]		= gamepad_button_check(slot, gp_padd) || gamepad_axis_value(slot, gp_axislv) > 0.3;
		input[@ UserInput.run]		= gamepad_button_check(slot, gp_face3);
		input[@ UserInput.jump]		= gamepad_button_check(slot, gp_padu) || gamepad_axis_value(slot, gp_axislv) < -0.3;
		input[@ UserInput.leap]		= gamepad_button_check_pressed(slot, gp_face1);
		input[@ UserInput.action0]	= gamepad_button_check_pressed(slot, gp_face4);
		input[@ UserInput.action1]	= gamepad_button_check(slot, gp_face4);
		input[@ UserInput.aim]		= gamepad_button_check(slot, gp_shoulderrb);
		input[@ UserInput.shoot]	= gamepad_button_check_pressed(slot, gp_face2);
		input[@ UserInput.reload]	= gamepad_button_check(slot, gp_face1);
	}
	else
	{
		o_game.gamepad_connected = false;
	
		//keyboard
		input[@ UserInput.left]		= keyboard_check(vk_left);
		input[@ UserInput.right]	= keyboard_check(vk_right);
		input[@ UserInput.up]		= keyboard_check(vk_up);
		input[@ UserInput.down]		= keyboard_check(vk_down);
		input[@ UserInput.run]		= keyboard_check_direct(vk_lshift);
		input[@ UserInput.jump]		= keyboard_check_pressed(vk_up);
		input[@ UserInput.leap]		= keyboard_check_pressed(vk_space);
		input[@ UserInput.action0]	= keyboard_check_pressed(ord("E"));
		input[@ UserInput.action1]	= keyboard_check(ord("E"));
		input[@ UserInput.aim]		= keyboard_check(ord("W"));
		input[@ UserInput.shoot]	= keyboard_check_pressed(ord("F"));
		input[@ UserInput.reload]	= keyboard_check(ord("R"));
	}


}
