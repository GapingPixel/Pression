/// @description Get Lightmaps

lightmap[0, 0] = -1;
lightmap[0, 1] = 0;
lightmap[0, 2] = 0;

var bg_exists	= true;
var i			= 0;

while(bg_exists)
{
	var bg_name	= "BG_Lightmap_" + string(i);
	
	var lid = layer_get_id(bg_name);
	
	bg_exists = layer_exists(lid);
	
	if(bg_exists)
	{
		show_debug_message("Yes");
		
		var blid = layer_background_get_id(lid);
		var spr = layer_background_get_sprite(blid);
		
		lightmap[i, 0] = spr;
		lightmap[i, 1] = layer_get_x(lid);
		lightmap[i, 2] = layer_get_y(lid);
		
		layer_background_visible(blid, false);
		
		i++;
	}
	else
	{
		break;
	}
}