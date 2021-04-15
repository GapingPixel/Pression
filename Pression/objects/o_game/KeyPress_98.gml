/// @desc Toggle Fullscreen

window_set_fullscreen(!window_get_fullscreen());

if(!window_get_fullscreen())
{
	window_set_size(_game_width * game_scale, _game_height * game_scale);
}

//update window position
alarm[0] = 1;