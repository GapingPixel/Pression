/// @description Set Sprite

var active = o_game.switch_id[ident];

image_index = active ? 1 : 0;

switch(ident)
{
	case Switch.harbor_inside:
		if(active)
		{	
			if(!instance_exists(o_rain))
			{
				instance_create_layer(0, 0, "IN_Controllers", o_rain);
			}
		}
	break;
}