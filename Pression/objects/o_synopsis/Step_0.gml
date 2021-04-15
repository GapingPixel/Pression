/// @description

if(begin_game)
{
	x += 80;
	if(x >= o_player.x)
	{
		cam.target = o_player;
		instance_destroy();
	}
}

var time = 3;
if(section == -1)
{
	time = 12;
}
if(section == 5)
{
	time = 6;
}

if(transition == 1)
{
	alpha += 1 / (room_speed * time);
	if(alpha >= 1)
	{
		if(section == -1)
		{
			alpha = 0;
			transition = 0;
			section = 0;
			alarm[0] = 90;
		}
		else
		{
			alpha = 1;
			transition = 2;
		}
		
		if(!audio_is_playing(sfx_harbor_waves))
		{
			audio_sound_gain(sfx_harbor_waves, 0, 0);
			audio_sound_gain(sfx_harbor_waves, 1, 300);
			audio_play_sound(sfx_harbor_waves, 0, true);
		}
	}
	
	if(section == 5)
	{
		if(!audio_is_playing(sfx_music_harbor))
		{
			audio_sound_gain(sfx_music_harbor, 0.3, 0);
			audio_play_sound(sfx_music_harbor, 0, true);
		}
	}
}
else if(transition == 2)
{
	if(alpha > 0)
	{
		alpha -= 1 / (room_speed * time);
	}
	else
	{
		alpha = 0;
		
		section++;
		if(section > 5)
		{
			begin_game = true;
		}
		else
		{
			alarm[0] = 30;
			transition = 0;
		}
	}
}