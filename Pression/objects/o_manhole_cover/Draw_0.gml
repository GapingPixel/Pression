/// @description Draw Cover

if(place_meeting(x, y, o_player))
{
	draw_sprite(sprite_index, image_index, x, y + 1);
}
else
{
	draw_self();
}