/// @description Initialize Game

#region Variable Declarations

//################################################
//Global Variables
//################################################

//camera
//------------------------------------------------
global.Camera = camera_create_view(0, 0, _game_width, _game_height, 0, noone, -1, -1, _game_width * 0.5, _game_height * 0.5);

//################################################
//Instance Variables
//################################################

//switches / pulleys
//------------------------------------------------
switch_id[Pulley.harbor_inside] = false;	//switches - true or false
pulley_id[Pulley.harbor_inside] = 0.0;		//pulleys - range 0.0 to 1.0

//display properties
//------------------------------------------------
game_scale		= 1;
max_game_scale	= 1;
game_x			= 0; //position at which to draw the game within the window
game_y			= 0;

gamepad_connected = false;

//display properties
//------------------------------------------------
inside_building = false;
#endregion

#region Set Resolution

//get hardware specs
var disp_width, disp_height, disp_aspect, game_aspect;

disp_width	= display_get_width();
disp_height = display_get_height();
disp_aspect = disp_width / disp_height;
game_aspect = _game_width / _game_height;

//get max game scale
max_game_scale = disp_aspect <= game_aspect ? disp_width div _game_width : disp_height div _game_height; //value = statement ? true : false

game_scale		= max_game_scale; //debug set fullscreen

//set application surface
surface_resize(application_surface, _game_width * game_scale, _game_height * game_scale); //application surface scaled up to allow smoother camera using sub-pixels
application_surface_draw_enable(false); //disable auto-drawing - this is done manually in post-draw event

//build and set camera matrices

//set all room view settings
for(var i = room_first; i <= room_last; i++)
{
	if(room_exists(i))
	{
		room_set_view_enabled(i, true);
		room_set_viewport(i, 0, true, 0, 0, _game_width, _game_height);
		room_set_camera(i, 0, global.Camera);
	}
}

//set initial game window size
//window_set_size(_game_width * game_scale, _game_height * game_scale);
if(!window_get_fullscreen())
{
	window_set_fullscreen(true);
}

alarm[0] = 1;

#endregion

#region Required Control Objects

instance_create_depth(0, 0, 0, o_camera);
instance_create_depth(320, 180, 0, o_synopsis);
instance_create_layer(0, 0, "IN_Lights", o_lighting);

#endregion

room_goto_next(); //Go to the first room