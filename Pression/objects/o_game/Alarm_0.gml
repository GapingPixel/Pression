/// @description Update Window Position

if(window_get_fullscreen()) //fullscreen mode
{
	game_x = max(floor((display_get_width() - (_game_width * game_scale)) * 0.5), 0);
	game_y = max(floor((display_get_height() - (_game_height * game_scale)) * 0.5), 0);
}
else //windowed mode
{
	game_x = 0;
	game_y = 0;
	window_center();
}

surface_resize(application_surface, _game_width * game_scale, _game_height * game_scale);

display_set_gui_maximize(game_scale, game_scale, game_x, game_y);