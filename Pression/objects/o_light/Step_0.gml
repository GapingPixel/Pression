/// @description Process

var active = o_game.switch_id[ident];

image_index = active ? 1 : 0;

if(active)
{
	if(light_source == noone)
	{
		light_source = instance_create_layer(x + 13, y + 10, "IN_Lights", o_point_light);
	
		with(light_source)
		{
			radius		= 128;
			colour		= c_red;
			intensity	= 0.8;
		}
	}
}
else if(light_source != noone)
{
	instance_destroy(light_source);
}