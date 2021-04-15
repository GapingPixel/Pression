/// @description Get Background IDs

//set initial position
if(target != noone)
{
	if(instance_exists(target))
	{
		if(target == o_player)
		{
			x = target.spawn_x;
			y = target.spawn_y;
		}
		else
		{
			x = target.xstart;
			y = target.ystart;
		}
	}
}

var bg_name, bg_exists, i;

//foreground
foreground = layer_get_id("BG_Foreground");

//single foregrounds
foreground_single[0, 1] = -1;

bg_exists	= true;
i			= 0;

while(bg_exists)
{
	bg_name		= "BG_Foreground_Single_" + string(i);
	bg_exists	= layer_exists(bg_name);
	
	if(bg_exists)
	{
		foreground_single[i, 0] = layer_get_id(bg_name);
		foreground_single[i, 1] = layer_get_x(bg_name);
		i++;
	}
	else
	{
		break;	
	}
}


//background
background[0, 1] = -1;

bg_exists	= true;
i			= 0;

while(bg_exists)
{
	bg_name		= "BG_Background_" + string(i);
	bg_exists	= layer_exists(bg_name);
	
	if(bg_exists)
	{
		background[i, 0] = layer_get_id(bg_name);
		background[i, 1] = layer_get_x(bg_name);
		i++;
	}
	else
	{
		break;	
	}
}

//background singles
background_single[0, 1] = -1;

bg_exists	= true;
i			= 0;

while(bg_exists)
{
	bg_name		= "BG_Background_Single_" + string(i);
	bg_exists	= layer_exists(bg_name);
	
	if(bg_exists)
	{
		background_single[i, 0] = layer_get_id(bg_name);
		background_single[i, 1] = layer_get_x(bg_name);
		i++;
	}
	else
	{
		break;	
	}
}

//distance
distance[0, 1] = -1;

bg_exists	= true;
i			= 0;

while(bg_exists)
{
	bg_name		= "BG_Distance_" + string(i);
	bg_exists	= layer_exists(bg_name);
	
	if(bg_exists)
	{
		distance[i, 0] = layer_get_id(bg_name);
		distance[i, 1] = layer_get_x(bg_name);
		i++;
	}
	else
	{
		break;	
	}
}

//sky
sky = layer_get_id("BG_Sky");