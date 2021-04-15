/// @description Update Position

if(instance_exists(target))
{
	x = clamp(x + ((target.x - x) * 0.1), 320, room_width - 320);
	y = clamp(y + ((target.y - y) * 0.1), 180, room_height - 180);
}

camera_set_view_pos(view_camera[0], x - (_game_width * 0.5), y - (_game_height * 0.5)); //allows sub pixels

//Parallax Scrolling

//foreground
if(layer_exists(foreground))
{
	layer_x(foreground, x * -1.25);
}

//foreground single
for(var i = 0; i < array_height_2d(foreground_single); i++)
{
	if(layer_exists(foreground_single[i, 0]))
	{
		var pos = ((x - 320) - foreground_single[i, 1]) / 2;
		layer_x(foreground_single[i, 0], (foreground_single[i, 1] - pos));
	}
}

//background
var pos = ((x - 320) / (room_width - 640)) * (room_width - (array_height_2d(background) * 640));

for(var i = 0; i < array_height_2d(background); i++)
{
	if(layer_exists(background[i, 0]))
	{
		layer_x(background[i, 0], (pos + background[i, 1]));
	}
}

//background single
for(var i = 0; i < array_height_2d(background_single); i++)
{
	if(layer_exists(background_single[i, 0]))
	{
		var pos = (background_single[i, 1] - (x - 320)) / 3;
		layer_x(background_single[i, 0], (background_single[i, 1] - pos));
	}
}

//distance
var pos = ((x - 320) / (room_width - 640)) * (room_width - (array_height_2d(distance) * 640));

for(var i = 0; i < array_height_2d(distance); i++)
{
	if(layer_exists(distance[i, 0]))
	{
		layer_x(distance[i, 0], (pos+ distance[i, 1]));
	}
}

//sky
if(layer_exists(sky))
{
	layer_x(sky, x / 1.5);
}