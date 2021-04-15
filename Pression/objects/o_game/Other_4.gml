/// @description Set Inside or Outside

inside_building = false;
switch(room)
{
	case r_harbor_inside: inside_building = true; break;
}


//debug music and whatnot
/*
if(!audio_is_playing(sfx_music_harbor))
{
	audio_sound_gain(sfx_music_harbor, 0.3, 0);
	audio_play_sound(sfx_music_harbor, 0, true);
}*/

if(inside_building || room != r_harbor)
{
	if(audio_is_playing(sfx_harbor_waves))
	{
		audio_stop_sound(sfx_harbor_waves);
	}
}
else if(!instance_exists(o_synopsis))
{
	if(!audio_is_playing(sfx_harbor_waves))
	{
		audio_play_sound(sfx_harbor_waves, 0, true);
	}
}