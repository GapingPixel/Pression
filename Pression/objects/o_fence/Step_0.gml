/// @description Process

if(instance_exists(o_player))
{
	if(o_player.x > x)
	{
		depth = o_player.depth - 1;
	}
	else
	{
		layer = layer_start;
	}
}

var active = o_game.switch_id[ident];
image_index = active ? 1 : 0;

if(image_index == 1)
{
	sprite_index = noone; //do this so there will be no collision
	//the sprite will be manually drawn instead
}