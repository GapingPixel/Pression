/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

var pos = o_game.pulley_id[ident];

y = ystart - floor((ystart - y_end) * pos);

if(ystart - y <= sprite_get_height(s_mask_player)) //disable ledge until higher than the player
{
	ledge_left.sprite_index		= noone;
	ledge_right.sprite_index	= noone;
}
else
{
	ledge_left.sprite_index		= s_mask_ledge;
	ledge_right.sprite_index	= s_mask_ledge;
	
	ledge_left.y	= y;
	ledge_right.y	= y;
}