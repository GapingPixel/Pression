/// @description Scale Down

game_scale--;

if(game_scale <= 0)
{
	game_scale = max_game_scale;
}

//set window size
if(!window_get_fullscreen())
{
	window_set_size(_game_width * game_scale, _game_height * game_scale);
}

//update window position
alarm[0] = 1;