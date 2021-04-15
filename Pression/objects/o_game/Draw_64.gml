/// @description Gamepad Connected

if(gamepad_connected)
{
	if(keyboard_check(vk_anykey))
	{
		draw_set_alpha(0.5);
		draw_set_font(font_quattrocento);
		
		draw_text(10, 10, "Gamepad Connected");
		
		draw_set_font(-1);
		draw_set_alpha(1);
	}
}