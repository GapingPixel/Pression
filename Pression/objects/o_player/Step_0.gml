/// @desc Process Player

//debug_respawn
if(y > room_height)
{
	room_restart();	
}

if(!instance_exists(o_synopsis)) //debug disable controls
{
	check_input(user_input, 0);
}

grounded = place_meeting(x, y + 1, o_mask_solid); //check if grounded

//simplify directional input
var l, r, u, d;

l = user_input[UserInput.left]	? 1 : 0;
r = user_input[UserInput.right] ? 1 : 0;
u = user_input[UserInput.up]	? 1 : 0;
d = user_input[UserInput.down]	? 1 : 0;

var left_right	= r - l;
var up_down		= d - u;

switch(state)
{
	case PlayerState.normal_idle:
		if(!grounded)
		{
			state = PlayerState.normal_fall;
		}
		else if(user_input[UserInput.aim])
		{
			state = PlayerState.combat_draw_gun;
		}
		else if(up_down == -1)
		{
			ledge_id = instance_place(x, y - height_jump, o_mask_ledge);
					
			if(ledge_id == noone)
			{
				if(!place_meeting(x, y - height_jump, o_mask_solid))
				{
					state = PlayerState.normal_jump;
				}
			}
			else
			{
				state = PlayerState.hoist_align;
			}
		}
		else if(up_down == 1)
		{
			ledge_id = instance_place(x, y + 1, o_mask_ledge);
						
			if(ledge_id != noone)
			{
				state = PlayerState.hoist_align;
			}
		}
		else if(user_input[UserInput.leap])
		{
			if(!place_meeting(x, y - height_jump, o_mask_solid))
			{
				speed_leap_air	= 3;
				ystart_leap		= y;
				state = PlayerState.normal_leap;
			}
		}
		else if(left_right != 0)
		{
			if(left_right != facing)
			{
				state = PlayerState.normal_turn;
			}
			else
			{
				state = user_input[UserInput.run] ? PlayerState.normal_run : PlayerState.normal_walk;
			}
		}
		else if(user_input[UserInput.action0]) //pressed action one time only
		{
			door_id = instance_place(x, y, o_mask_door);
			if(door_id != noone)
			{
				state = PlayerState.interact_door_align;
			}
			
			switch_id = instance_place(x, y, o_switch);
			if(switch_id != noone)
			{
				o_game.switch_id[switch_id.ident] = !o_game.switch_id[switch_id.ident];
			}
		}
		else if(user_input[UserInput.action1]) //pressing and holding action
		{
			pulley_id = instance_place(x, y, o_pulley);
			if(pulley_id != noone)
			{
				state = PlayerState.interact_pulley_align;
			}
		}
	break;
	case PlayerState.normal_walk:
		if(!grounded)
		{
			state = PlayerState.normal_fall;
		}
		else if(user_input[UserInput.aim])
		{
			state = PlayerState.combat_draw_gun;
		}
		else if(user_input[UserInput.leap])
		{
			if(!place_meeting(x, y - height_jump, o_mask_solid))
			{
				speed_leap_air	= 3;
				ystart_leap		= y;
				state = PlayerState.normal_leap;
			}
		}
		else if(left_right == 0)
		{
			state = PlayerState.normal_idle;
		}
		else if(left_right != facing)
		{
			state = PlayerState.normal_turn;
		}
		else if(user_input[UserInput.run])
		{
			state = PlayerState.normal_run;
		}
	break;
	case PlayerState.normal_run:
		if(!grounded)
		{
			state = PlayerState.normal_fall;
		}
		else if(left_right != facing || !user_input[UserInput.run] || user_input[UserInput.aim])
		{
			state = PlayerState.normal_stumble;
		}
		else if(user_input[UserInput.leap])
		{
			if(!place_meeting(x, y - height_jump, o_mask_solid))
			{
				speed_leap_air	= 5;
				ystart_leap		= y;
				state = PlayerState.normal_leap;
			}
		}
		else if(up_down == 1 && abs(velocity[0]) >= speed_slide)
		{
			xstart_slide = x;
			state = PlayerState.normal_slide;
		}
	break;
	case PlayerState.normal_stumble:
		if(!grounded)
		{
			state = PlayerState.normal_fall;
		}
		else if(floor(image_index) == 7)
		{
			if(user_input[UserInput.aim])
			{
				state = PlayerState.combat_draw_gun;
			}
			else if(left_right == 0)
			{
				state = PlayerState.normal_idle;
			}
			else if(left_right == facing)
			{
				state = user_input[UserInput.run] ? PlayerState.normal_run : PlayerState.normal_walk;
			}
		}
		else if(image_index >= image_number - 1)
		{
			facing *= -1;
			
			if(left_right == 0)
			{
				state = PlayerState.normal_idle;
			}
			else if(left_right == facing)
			{
				state = user_input[UserInput.run] ? PlayerState.normal_run : PlayerState.normal_walk;
			}
			else
			{
				state = PlayerState.normal_turn;	
			}
		}
	break;
	case PlayerState.normal_turn:
		if(!grounded) 
		{
			state = PlayerState.normal_fall;
		}
		else if(image_index >= image_number - 1)
		{
			facing *= -1;
			
			if(user_input[UserInput.aim])
			{
				state = PlayerState.combat_draw_gun;
			}
			else if(left_right != 0)
			{
				if(left_right != facing)
				{
					state = PlayerState.normal_turn;
				}
				else
				{
					state = user_input[UserInput.run] ? PlayerState.normal_run : PlayerState.normal_walk;
				}
			}
			else
			{
				state = PlayerState.normal_idle;	
			}
		}
	break;
	case PlayerState.normal_leap:
		if(!grounded)
		{
			if(y > ystart_leap)
			{
				state = PlayerState.normal_fall;
			}
			else
			{
				ledge_id = instance_place(x, y, o_mask_ledge);
						
				if(ledge_id != noone)
				{
					var side, xx, yy;
					
					with(o_mask_platform)
					{
						sprite_index = sprite;
					}
				
					with(ledge_id)
					{
						side	= instance_place(x + 1, y, o_mask_solid) ? 1 : -1;
						xx		= side ? bbox_right + 1 : bbox_left;
						yy		= bbox_top;
					}
					
					with(o_mask_platform)
					{
						if(other.bbox_bottom >= bbox_top)
						{
							sprite_index = noone;
						}
					}
					
					ledge_side	= side;
					ledge_x		= xx - (sprite_get_width(mask_index) * 0.5 * side);
					ledge_y		= yy + (sprite_get_height(mask_index) * 0.5) + 4; //+ 4 to make sprite look right
					
					if(facing == ledge_side && y < ledge_y && y >= ledge_y - 4) //y >= ledge_y - 6 is the flexible amount so the player doesnt snap to the ledge if his feet hit it
					{
						if(!place_meeting(ledge_x, ledge_y, o_mask_solid))
						{
							x = ledge_x;
							y = ledge_y;
							state = PlayerState.hoist_swing;
						}
					}
				}
			}
		}
		else if(image_index >= image_number - 1)
		{
			if(user_input[UserInput.aim])
			{
				state = PlayerState.combat_draw_gun;
			}
			else if(left_right != 0)
			{
				if(left_right != facing)
				{
					state = PlayerState.normal_turn;
				}
				else
				{
					state = user_input[UserInput.run] ? PlayerState.normal_run : PlayerState.normal_walk;
				}
			}
			else
			{
				state = PlayerState.normal_idle;	
			}
		}
	break;
	case PlayerState.normal_jump:
		if(image_index > 10 && velocity[1] > 0)
		{
			state = PlayerState.normal_fall;
		}
	break;
	case PlayerState.normal_fall:
		ledge_id = instance_place(x, y, o_mask_ledge);
				
		if(grounded)
		{
			state = PlayerState.normal_idle;
		}
		else if(ledge_id != noone)
		{
			var side, xx, yy;
			
			with(o_mask_platform)
			{
				sprite_index = sprite;	
			}
			
			with(ledge_id)
			{
				side	= instance_place(x + 1, y, o_mask_solid) ? 1 : -1;
				xx		= side ? bbox_right + 1 : bbox_left;
				yy		= bbox_top;
			}
			
			with(o_mask_platform)
			{
				if(other.bbox_bottom >= bbox_top)
				{
					sprite_index = noone;
				}
			}
			
			ledge_side	= side;
			ledge_x		= xx - (sprite_get_width(mask_index) * 0.5 * side);
			ledge_y		= yy + (sprite_get_height(mask_index) * 0.5) + 4; //+ 4 to make sprite look right
					
			if(facing == ledge_side && y < ledge_y && y >= ledge_y - 4) //y >= ledge_y - 6 is the flexible amount so the player doesnt snap to the ledge if his feet hit it
			{
				if(!place_meeting(ledge_x, ledge_y, o_mask_solid))
				{
					x = ledge_x;
					y = ledge_y;
					state = PlayerState.hoist_swing;
				}
			}
		}
	break;
	case PlayerState.normal_slide:
		mask_index = s_mask_player_slide;
				
		if(!grounded)
		{	
			mask_index = s_mask_player;
					
			if(!place_meeting(x, y, o_mask_solid))
			{
				state = PlayerState.normal_fall;
			}
			else
			{
				mask_index = s_mask_player_slide;
			}
		}
				
		if(abs(x - xstart_slide) >= dist_slide)
		{
			mask_index = s_mask_player;
					
			if(!place_meeting(x, y, o_mask_solid))
			{
				state = PlayerState.normal_idle;
			}
			else
			{
				mask_index = s_mask_player_slide;
			}
		}
	break;
	case PlayerState.hoist_align:
		//get ledge properties
		if(ledge_id != noone)
		{
			var side, xx, yy;
			
			with(o_mask_platform)
			{
				sprite_index = sprite;
			}
			
			with(ledge_id)
			{
				side	= instance_place(x + 1, y, o_mask_solid) ? 1 : -1;
				xx		= side ? bbox_right + 1 : bbox_left;
				yy		= bbox_top;
			}
			
			with(o_mask_platform)
			{
				if(other.bbox_bottom >= bbox_top)
				{
					sprite_index = noone;
				}
			}
			
			ledge_side	= side;
			ledge_x		= xx - (sprite_get_width(mask_index) * 0.5 * side);
			ledge_y		= yy + (sprite_get_height(mask_index) * 0.5) + 4; //+ 4 to make sprite look right
					
			ledge_id = noone; //set to noone so we don't re-run this code
		}
				
		if(user_input[UserInput.aim])
		{
			state = PlayerState.combat_draw_gun;
		}
		else if(left_right != 0)
		{
			if(left_right != facing)
			{
				state = PlayerState.normal_turn;
			}
			else
			{
				state = user_input[UserInput.run] ? PlayerState.normal_run : PlayerState.normal_walk;
			}
		}
		else
		{
			var desired_x = y > ledge_y ? ledge_x : ledge_x + (8 * ledge_side);
					
			//align with ledge properties then jump
			if(x != desired_x)
			{
				state = facing == sign(desired_x - x) ? PlayerState.hoist_walk : PlayerState.hoist_turn;	
			}
			else if(facing != ledge_side)
			{
				state = PlayerState.hoist_turn;	
			}
			else
			{
				state = y > ledge_y ? PlayerState.hoist_jump : PlayerState.hoist_down;	
			}
		}
	break;
	case PlayerState.hoist_walk:
		var desired_x = y > ledge_y ? ledge_x : ledge_x + (8 * ledge_side);
				
		if(x == desired_x)
		{
			state = PlayerState.hoist_align;
		}
		else if(user_input[UserInput.aim])
		{
			state = PlayerState.combat_draw_gun;
		}
		else if(left_right != 0)
		{
			if(left_right != facing)
			{
				state = PlayerState.normal_turn;
			}
			else
			{
				state = user_input[UserInput.run] ? PlayerState.normal_run : PlayerState.normal_walk;
			}
		}
	break;
	case PlayerState.hoist_turn:
		if(image_index >= image_number - 1)
		{
			facing *= -1;
			state = PlayerState.hoist_align;
		}
	break;
	case PlayerState.hoist_jump:
		if(y <= ledge_y)
		{
			state = PlayerState.hoist_idle;
		}
		else if(image_index > 10 && velocity[1] > 0)
		{
			state = PlayerState.normal_fall;
		}
	break;
	case PlayerState.hoist_idle:
		if(x != ledge_x || y != ledge_y)
		{
			//something happened, abort the procedure
			state = PlayerState.normal_fall;
		}
		else
		{
			if(up_down == 1)
			{
				state = PlayerState.normal_fall;
			}
			else if(up_down == -1)
			{
				state = PlayerState.hoist_up;	
			}
		}
	break;
	case PlayerState.hoist_up:
		if(x == ledge_x && y == ledge_y)
		{
			//something went wrong
			state = PlayerState.hoist_idle;
		}
		else if(image_index >= image_number - 1)
		{
			state = PlayerState.normal_idle;
		}
	break;
	case PlayerState.hoist_down:
		if(x != ledge_x && y != ledge_y)
		{
			//something went wrong
			state = PlayerState.normal_idle;
		}
		else if(image_index >= image_number - 1)
		{
			state = PlayerState.hoist_idle;
		}
	break;
	case PlayerState.hoist_swing:
		if(image_index >= image_number - 1)
		{
			state = PlayerState.hoist_idle;
		}
	break;
	case PlayerState.combat_draw_gun:
		if(image_index >= image_number - 1)
		{
			state = PlayerState.combat_aim_gun;
		}
	break;
	case PlayerState.combat_aim_gun:
		if(!user_input[UserInput.aim])
		{
			state = PlayerState.combat_holster_gun;
		}
		else if(user_input[UserInput.shoot])
		{
			if(ammo > 0)
			{
				state = PlayerState.combat_shoot_gun;
			}
		}
		else if(user_input[UserInput.reload])
		{
			if(ammo < 6)
			{
				ammo++;
				state = PlayerState.combat_reload_gun;
			}
		}
		else if(left_right != 0 && left_right != facing)
		{
			state = PlayerState.combat_turn;	
		}
	break;
	case PlayerState.combat_holster_gun:
		if(image_index >= image_number - 1)
		{
			state = PlayerState.normal_idle;
		}
	break;
	case PlayerState.combat_shoot_gun:
		if(image_index >= image_number - 1)
		{
			state = PlayerState.combat_aim_gun;
			ammo--;
			revolver_frame--;
		}
	break;
	case PlayerState.combat_reload_gun:
		if(user_input[UserInput.aim] && user_input[UserInput.reload] && ammo < 6)
		{
			if(round(image_index) == 8)
			{
				image_index = 3;
				ammo++;
			}
		}
		else if(image_index >= image_number - 1)
		{
			state = PlayerState.combat_aim_gun;
		}
	break;
	case PlayerState.combat_turn:
		if(image_index >= image_number - 1)
		{
			facing *= -1;
					
			if(user_input[UserInput.aim])
			{
				state = PlayerState.combat_draw_gun;
			}
			else
			{
				state = PlayerState.normal_idle;
			}
		}
	break;
	case PlayerState.interact_door_align:
		door_x = door_id.x + (door_id.sprite_width * 0.5);
		
		if(user_input[UserInput.aim])
		{
			state = PlayerState.combat_draw_gun;
		}
		else if(left_right != 0)
		{
			if(left_right != facing)
			{
				state = PlayerState.normal_turn;
			}
			else
			{
				state = user_input[UserInput.run] ? PlayerState.normal_run : PlayerState.normal_walk;
			}
		}
		else
		{
			if(x != door_x)
			{
				state = facing == sign(door_x - x) ? PlayerState.interact_door_walk : PlayerState.interact_door_turn;
			}
			else
			{
				state = PlayerState.interact_door_enter;
			}
		}
	break;
	case PlayerState.interact_door_enter:
		if(image_index >= image_number - 1)
		{
			if(room_exists(door_id.next_room))
			{
				spawn_x = door_id.spawn_x;
				spawn_y = door_id.spawn_y;
				room_goto(door_id.next_room);
			}
			
			state = PlayerState.normal_idle; //make sure we return to the normal state
		}
	break;
	case PlayerState.interact_door_turn:
		if(image_index >= image_number - 1)
		{
			facing *= -1;
			state = PlayerState.interact_door_align;
		}
	break;
	case PlayerState.interact_door_walk:
		if(x == door_x)
		{
			state = PlayerState.interact_door_enter;
		}
		else if(user_input[UserInput.aim])
		{
			state = PlayerState.combat_draw_gun;
		}
		else if(left_right != 0)
		{
			if(left_right != facing)
			{
				state = PlayerState.normal_turn;
			}
			else
			{
				state = user_input[UserInput.run] ? PlayerState.normal_run : PlayerState.normal_walk;
			}
		}
	break;
	case PlayerState.interact_pulley_align:
		var side = sign(x - pulley_id.x);
		var offset = 3;
		
		if(side == 0)
		{
			side = -1;
		}
		
		if(side == 1)
		{
			offset = 6; //due to the origin not being the actual center of the sprites
		}
		
		pulley_x = pulley_id.x + (offset * side);
		
		if(!user_input[UserInput.action1])
		{
			state = PlayerState.normal_idle;
		}
		else
		{
			if(x != pulley_x)
			{
				state = facing == sign(pulley_x - x) ? PlayerState.interact_pulley_walk : PlayerState.interact_pulley_turn;
			}
			else
			{
				if(facing != sign(pulley_id.x - x))
				{
					state = PlayerState.interact_pulley_turn;
				}
				else
				{
					state = PlayerState.interact_pulley;
				}
			}
		}
		
	break;
	case PlayerState.interact_pulley_turn:
		if(image_index >= image_number - 1)
		{
			facing *= -1;
			state = PlayerState.interact_pulley_align;
		}
	break;
	case PlayerState.interact_pulley_walk:
		if(x == pulley_x)
		{
			if(facing != sign(pulley_id.x - x))
			{
				state = PlayerState.interact_pulley_turn;
			}
			else
			{
				state = PlayerState.interact_pulley;
			}
		}
		else if(!user_input[UserInput.action1])
		{
			state = PlayerState.normal_idle;
		}
	break;
	case PlayerState.interact_pulley:
		if(!user_input[UserInput.action1])
		{
			state = PlayerState.normal_idle;
		}
		else
		{
			//normal
			image_speed = 0;
			
			var p = pulley_id.ident;
			
			if(user_input[UserInput.up] && o_game.pulley_id[p] != 1)
			{
				//pulley up
				image_speed = 1.0;
				
				with(o_game)
				{
					pulley_id[p] = clamp(pulley_id[p] + 0.01, 0, 1);
				}
			}
			
			if(user_input[UserInput.down] && o_game.pulley_id[p] != 0)
			{
				//pulley down
				image_speed = -1.0;
				with(o_game)
				{
					pulley_id[p] = clamp(pulley_id[p] - 0.01, 0, 1);
				}
			}
		}
	break;
}

//set sprite


if(sprite_index != sprite[state, 0])
{
	sprite_index = sprite[state, 0];
	image_speed  = sprite[state, 1];
	image_index  = 0;
}

if sprite_index != sprite[PlayerState.normal_run, 0] {
	sprite[PlayerState.normal_run, 0] = s_player_walk_to_run;
}

//audio
var walk_surface	= "concrete";
var numb_sounds		= 7;
var walk_vol		= 1;
if(room == r_road)
{
	walk_surface = "gravel";
	numb_sounds		= 3;
	walk_vol		= 0.3;
}

switch(sprite_index)
{
	case s_player_walk:
		if(round(image_index) == 3 && !left_footstep_played)
		{
			//left step sound
			var step_sound	= asset_get_index("sfx_walk_" + walk_surface + "_" + string(irandom(numb_sounds)));
			audio_sound_gain(step_sound, (irandom_range(75, 100) / 100) * walk_vol, 0);
			audio_sound_pitch(step_sound, irandom_range(75, 100) / 100);
			audio_play_sound(step_sound, 0, false);
			left_footstep_played = true;
		}
		
		if(round(image_index) == 8 && !right_footstep_played)
		{
			//right step sound
			var step_sound	= asset_get_index("sfx_walk_" + walk_surface + "_" + string(irandom(numb_sounds)));
			audio_sound_gain(step_sound, (irandom_range(75, 100) / 100) * walk_vol, 0);
			audio_sound_pitch(step_sound, irandom_range(75, 100) / 100);
			audio_play_sound(step_sound, 0, false);
			right_footstep_played = true;
		}
		
		if(image_index < 1)
		{
			//reset
			left_footstep_played = false;
			right_footstep_played = false;
		}
	break
	
	case s_player_run:
		if(round(image_index) == 8 && !left_footstep_played)
		{
			//left step sound
			var step_sound	= asset_get_index("sfx_run_" + walk_surface + "_" + string(irandom(numb_sounds)));
			audio_sound_gain(step_sound, (irandom_range(75, 100) / 100) * walk_vol, 0);
			audio_sound_pitch(step_sound, irandom_range(75, 100) / 100);
			audio_play_sound(step_sound, 0, false);
			left_footstep_played = true;
		}
		
		if(round(image_index) == 15 && !right_footstep_played)
		{
			//right step sound
			var step_sound	= asset_get_index("sfx_run_" + walk_surface + "_" + string(irandom(numb_sounds)));
			audio_sound_gain(step_sound, (irandom_range(75, 100) / 100) * walk_vol, 0);
			audio_sound_pitch(step_sound, irandom_range(75, 100) / 100);
			audio_play_sound(step_sound, 0, false);
			right_footstep_played = true;
		}
		
		if(image_index < 1)
		{
			//reset
			left_footstep_played = false;
			right_footstep_played = false;
		}
	break
	case s_player_shoot_gun:
		if(image_index == 0)
		{
			numb_sounds = 3;
			var shot_sound	= asset_get_index("sfx_revolver_shoot_" + string(irandom(numb_sounds)));
			
			audio_sound_gain(shot_sound, 1, 0);
			audio_play_sound(shot_sound, 0, false);
		}
	break;
	case s_player_reload_gun:
		if(image_index == 3)
		{
			audio_sound_gain(sfx_revolver_reload, 1, 0);
			audio_play_sound(sfx_revolver_reload, 0, false);
		}
		if(image_index == 8) //need a more robust system than this...
		{
			audio_play_sound(sfx_revolver_reload_final, 0, false);
		}
	break;
}

switch(state)
{
	case PlayerState.normal_idle:
		velocity[0] = 0;
		velocity[1] = 0;
	break;
	case PlayerState.normal_walk:
		velocity[0] = speed_walk * facing;
		velocity[1] = 0;
	break;
	case PlayerState.normal_run:
		velocity[0] = speed_run * facing;
		velocity[1] = 0;
	break;
	case PlayerState.normal_stumble:
		velocity[1] = 0;
		
		if(image_index > 8)
		{
			velocity[0] = 2 * -facing;	
		}
		else
		{
			velocity[0] = 2 * facing;
		}
	break;
	case PlayerState.normal_turn:
		velocity[0] = 0;
		velocity[1] = 0;
	break;
	case PlayerState.normal_leap:
		if(grounded && image_index > 3)
		{
			//landed prematurely
			if(image_index < 7)
			{
				image_index = 7;
				image_speed = 1;
			}
		}
		else
		{
			//normal jump animation sequence
			if(image_index < 4)
			{
				image_speed = 1;
			}
			else if(image_index < 7)
			{
				var t = abs(2 * -sqrt(2 * height_leap * _gravity) / _gravity);
				image_speed = (7 / t);
			}
			else if(grounded)
			{	
				image_speed = 1;
			}
			else
			{
				//not on the ground yet so pause animating until on ground
				image_index = 7;
				image_speed = 0;	
			}
		}
		
		if(grounded)
		{
			if(image_index > 2 && image_index < 7)
			{
				velocity[0] = speed_leap_air * facing;
				velocity[1] = -sqrt(2 * height_leap * _gravity);
			}
			else
			{
				velocity[0] = speed_leap_gnd * facing;
			}
		}
		else
		{
			velocity[1] += _gravity;
		}
	break;
	case PlayerState.normal_jump:
		//prevent from looping animation
		if(image_index >= image_number - 1)
		{
			image_index = image_number - 1;
			image_speed = 0;
		}
		
		velocity[0] = 0;
		velocity[1] += _gravity;
		
		if(grounded)
		{
			if(image_index > 10)
			{
				velocity[1] = -sqrt(2 * height_jump * _gravity);
			}
		}
	break;
	case PlayerState.normal_fall:
		velocity[1] += _gravity
	break;
	case PlayerState.normal_slide:
		velocity[0] = speed_slide * facing;
		velocity[1] = 0;
	break;
	case PlayerState.hoist_align:
		velocity[0] = 0;
		velocity[1] = 0;
	break;
	case PlayerState.hoist_walk:
		velocity[0] = speed_walk * facing;
		velocity[1] = 0;
		
		var desired_x = y > ledge_y ? ledge_x : ledge_x + (8 * ledge_side);
		
		if(facing == 1)
		{
			if(x + velocity[0] > desired_x)
			{
				if(!place_meeting(desired_x, y, o_mask_solid))
				{
					x = desired_x;
					velocity[0] = 0;
				}
			}
		}
		else
		{
			if(x + velocity[0] < desired_x)
			{
				if(!place_meeting(desired_x, y, o_mask_solid))
				{
					x = desired_x;
					velocity[0] = 0;
				}
			}
		}
		
	break;
	case PlayerState.hoist_turn:
		velocity[0] = 0;
		velocity[1] = 0;
	break;
	case PlayerState.hoist_jump:
		//prevent from looping animation
		if(image_index >= image_number - 1)
		{
			image_index = image_number - 1;
			image_speed = 0;
		}
	
		velocity[0] = 0;
		velocity[1] += _gravity;
		
		if(grounded)
		{
			if(image_index > 10)
			{
				velocity[1] = -sqrt(2 * (y - ledge_y) * _gravity);
			}
		}
	break;
	case PlayerState.hoist_idle:
		velocity[0] = 0;
		velocity[1] = 0;
		
		if(!place_meeting(ledge_x, ledge_y, o_mask_solid))
		{
			x = ledge_x;
			y = ledge_y;
		}
	break;
	case PlayerState.hoist_up:
		velocity[0] = 0;
		velocity[1] = 0;
		
		var xx = ledge_x + (8 * facing);
		var yy = ledge_y - sprite_get_height(mask_index) - 4;
		
		if(!place_meeting(xx, yy, o_mask_solid))
		{
			x = xx;
			y = yy;
		}
	break;
	case PlayerState.hoist_down:
		velocity[0] = 0;
		velocity[1] = 0;
		
		var xx = ledge_x;
		var yy = ledge_y;
		
		if(!place_meeting(xx, yy, o_mask_solid))
		{
			x = xx;
			y = yy;
		}
	break;
	case PlayerState.hoist_swing:
		velocity[0] = 0;
		velocity[1] = 0;
	break;
	case PlayerState.combat_draw_gun:
		velocity[0] = 0;
		velocity[1] = 0;
	break;
	case PlayerState.combat_aim_gun:
		velocity[0] = 0;
		velocity[1] = 0;
	break;
	case PlayerState.combat_holster_gun:	
		velocity[0] = 0;
		velocity[1] = 0;
	break;
	case PlayerState.combat_shoot_gun:	
		velocity[0] = 0;
		velocity[1] = 0;
		
		if(image_index == 0)
		{
			var xy = collision_line_find_nearest_point(x, y, x + (640 * facing), y, 1, o_mask_bullet_collider, false);
			
			if(xy[2] != noone)
			{
				effect_create_above(ef_spark, xy[0], xy[1], 0, c_black);
				instance_destroy(xy[2]);
			}
		}
		
	break;
	case PlayerState.combat_reload_gun:
		if(image_index < 3)
		{
			image_speed = 1;	
		}
		else if(image_index < 9)
		{
			image_speed = 0.5;	
		}
		else
		{
			image_speed = 1;	
		}
		
		velocity[0] = 0;
		velocity[1] = 0;
	break;
	case PlayerState.combat_turn:
		velocity[0] = 0;
		velocity[1] = 0;
	break;
	case PlayerState.interact_door_align:
		velocity[0] = 0;
		velocity[1] = 0;
	break;
	case PlayerState.interact_door_enter:
		velocity[0] = 0;
		velocity[1] = 0;
	break;
	case PlayerState.interact_door_turn:
		velocity[0] = 0;
		velocity[1] = 0;
	break;
	case PlayerState.interact_door_walk:
		velocity[0] = speed_walk * facing;
		velocity[1] = 0;
		
		if(facing == 1)
		{
			if(x + velocity[0] > door_x)
			{
				if(!place_meeting(door_x, y, o_mask_solid))
				{
					x = door_x;
					velocity[0] = 0;
				}
			}
		}
		else
		{
			if(x + velocity[0] < door_x)
			{
				if(!place_meeting(door_x, y, o_mask_solid))
				{
					x = door_x;
					velocity[0] = 0;
				}
			}
		}
	break;
	case PlayerState.interact_pulley_align:
		velocity[0] = 0;
		velocity[1] = 0;
	break;
	case PlayerState.interact_pulley_turn:
		velocity[0] = 0;
		velocity[1] = 0;
	break;
	case PlayerState.interact_pulley_walk:
		velocity[0] = speed_walk * facing;
		velocity[1] = 0;
		
		if(facing == 1)
		{
			if(x + velocity[0] > pulley_x)
			{
				if(!place_meeting(pulley_x, y, o_mask_solid))
				{
					x = pulley_x;
					velocity[0] = 0;
				}
			}
		}
		else
		{
			if(x + velocity[0] < pulley_x)
			{
				if(!place_meeting(pulley_x, y, o_mask_solid))
				{
					x = pulley_x;
					velocity[0] = 0;
				}
			}
		}
	break;
	case PlayerState.interact_pulley:
		velocity[0] = 0;
		velocity[1] = 0;
	break;
}

move_collision(velocity, o_mask_solid);