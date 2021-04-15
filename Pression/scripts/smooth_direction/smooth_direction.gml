/// @description smooth_direction(direction, new direction, angle);
/// @param direction
/// @param  new direction
/// @param  angle
function smooth_direction(argument0, argument1, argument2) {
	return argument0+(sin(degtorad(argument1-argument0))*argument2);


}
