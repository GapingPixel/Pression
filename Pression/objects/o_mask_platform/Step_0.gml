/// @description

if(instance_exists(o_player))
{
	if(o_player.bbox_bottom < bbox_top)
	{
		sprite_index = sprite;
	}
	else
	{
		sprite_index = noone;
	}
}