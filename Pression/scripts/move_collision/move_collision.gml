/// @function move_collision()
/// @argument velocity_array
/// @argument solid_object_id
function move_collision(argument0, argument1) {

	var vel			= argument0;
	var solid_id	= argument1;

	var vec2_x		= 0; //reference for velocity array
	var vec2_y		= 1;

	//horizontal collision and movement
	var hsp = round(vel[vec2_x]);

	if(place_meeting(x + hsp, y, solid_id))
	{
		while(!place_meeting(x + sign(hsp), y, solid_id))
		{
			x += sign(hsp);
		}
		vel[@ vec2_x] = 0; //access actual velocity array
	}
	else
	{
		x += hsp;
	}

	//vertical collision and movement
	var vsp = round(vel[vec2_y]);

	if(place_meeting(x, y + vsp, solid_id))
	{
		while(!place_meeting(x, y + sign(vsp), solid_id))
		{
			y += sign(vsp);
		}
		vel[@ vec2_y] = 0; //access actual velocity array
	}
	else
	{
		y += vsp;
	}


}
