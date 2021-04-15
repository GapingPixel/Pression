/// @desc Scale Up

game_scale++;

if(game_scale > max_game_scale)
{
	game_scale = 1;
}

//set window size
if(!window_get_fullscreen())
{
	window_set_size(_game_width * game_scale, _game_height * game_scale);
}

//update window position
alarm[0] = 1;