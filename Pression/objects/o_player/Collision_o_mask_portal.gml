/// @description Next Room

if(room_exists(other.next_room))
{
	spawn_x = other.spawn_x;
	spawn_y = other.spawn_y;
	room_goto(other.next_room);
}