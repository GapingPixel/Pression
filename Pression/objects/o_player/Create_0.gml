/// @description Initialize Player

//new stuff
user_input[UserInput.length - 1] = false;

//state engine
state = PlayerState.normal_idle;

//player info
facing		= 1;
grounded	= false;
ammo		= 6;

//spawning in new rooms
spawn_x = x;
spawn_y = y;

//movement variables
speed_walk		= 2;
speed_run		= 4;
speed_slide		= 3;
dist_slide		= 64; //max distance to slide
xstart_slide	= 0;

speed_leap_gnd	= 2;
speed_leap_air	= 5;
height_leap		= 8;
ystart_leap		= 0;

//ledges
height_jump = 24;
ledge_id	= 0;
ledge_side	= 0;
ledge_x		= 0;
ledge_y		= 0;

//doors
door_id = noone;
door_x = 0;
door_next_room = 0;

//pulley
pulley_id = noone;
pulley_x = noone;

velocity[1] = 0;

//sounds
left_footstep_played = false;
right_footstep_played = false;

//sprite and animation speed
sprite[PlayerState.normal_idle, 0]			= s_player_stand;
sprite[PlayerState.normal_idle, 1]			= 0.0;
sprite[PlayerState.normal_walk, 0]			= s_player_walk;
sprite[PlayerState.normal_walk, 1]			= 1.2;
sprite[PlayerState.normal_run, 0]			= s_player_walk_to_run;
sprite[PlayerState.normal_run, 1]			= 1.0;
sprite[PlayerState.normal_stumble, 0]		= s_player_stumble;
sprite[PlayerState.normal_stumble, 1]		= 1.0;
sprite[PlayerState.normal_turn, 0]			= s_player_turn;
sprite[PlayerState.normal_turn, 1]			= 2.0;
sprite[PlayerState.normal_leap, 0]			= s_player_leap;
sprite[PlayerState.normal_leap, 1]			= 0.0;
sprite[PlayerState.normal_jump, 0]			= s_player_jump;
sprite[PlayerState.normal_jump, 1]			= 1.0;
sprite[PlayerState.normal_fall, 0]			= s_player_fall;
sprite[PlayerState.normal_fall, 1]			= 0.0;
sprite[PlayerState.normal_slide, 0]			= s_player_slide;
sprite[PlayerState.normal_slide, 1]			= 1.5;
sprite[PlayerState.hoist_align, 0]			= s_player_stand;
sprite[PlayerState.hoist_align, 1]			= 0.0;
sprite[PlayerState.hoist_walk, 0]			= s_player_walk;
sprite[PlayerState.hoist_walk, 1]			= 1.2;
sprite[PlayerState.hoist_turn, 0]			= s_player_turn;
sprite[PlayerState.hoist_turn, 1]			= 2.0;
sprite[PlayerState.hoist_jump, 0]			= s_player_jump;
sprite[PlayerState.hoist_jump, 1]			= 1.0;
sprite[PlayerState.hoist_idle, 0]			= s_player_hang;
sprite[PlayerState.hoist_idle, 1]			= 0.0;
sprite[PlayerState.hoist_up, 0]				= s_player_hoist_up;
sprite[PlayerState.hoist_up, 1]				= 1.0;
sprite[PlayerState.hoist_down, 0]			= s_player_hoist_down;
sprite[PlayerState.hoist_down, 1]			= 1.0;
sprite[PlayerState.hoist_swing, 0]			= s_player_swing;
sprite[PlayerState.hoist_swing, 1]			= 0.5;
sprite[PlayerState.combat_draw_gun, 0]		= s_player_draw_gun;
sprite[PlayerState.combat_draw_gun, 1]		= 2.0;
sprite[PlayerState.combat_aim_gun, 0]		= s_player_aim_gun;
sprite[PlayerState.combat_aim_gun, 1]		= 0.0;
sprite[PlayerState.combat_holster_gun, 0]	= s_player_holster_gun;
sprite[PlayerState.combat_holster_gun, 1]	= 2.0;
sprite[PlayerState.combat_shoot_gun, 0]		= s_player_shoot_gun;
sprite[PlayerState.combat_shoot_gun, 1]		= 0.5;
sprite[PlayerState.combat_reload_gun, 0]	= s_player_reload_gun;
sprite[PlayerState.combat_reload_gun, 1]	= 0.0;
sprite[PlayerState.combat_turn, 0]			= s_player_turn;
sprite[PlayerState.combat_turn, 1]			= 2.0;
sprite[PlayerState.interact_door_align, 0]	= s_player_stand;
sprite[PlayerState.interact_door_align, 1]	= 0.0;
sprite[PlayerState.interact_door_enter, 0]	= s_player_enter_door;
sprite[PlayerState.interact_door_enter, 1]	= 0.5;
sprite[PlayerState.interact_door_turn, 0]	= s_player_turn;
sprite[PlayerState.interact_door_turn, 1]	= 2.0;
sprite[PlayerState.interact_door_walk, 0]	= s_player_walk;
sprite[PlayerState.interact_door_walk, 1]	= 1.2;
sprite[PlayerState.interact_pulley_align, 0]= s_player_stand;
sprite[PlayerState.interact_pulley_align, 1]= 0.0;
sprite[PlayerState.interact_pulley_turn, 0]	= s_player_turn;
sprite[PlayerState.interact_pulley_turn, 1]	= 2.0;
sprite[PlayerState.interact_pulley_walk, 0]	= s_player_walk;
sprite[PlayerState.interact_pulley_walk, 1]	= 1.2;
sprite[PlayerState.interact_pulley, 0]		= s_player_pulley;
sprite[PlayerState.interact_pulley, 1]		= 1.0;


revolver_frame = 21;