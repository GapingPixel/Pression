/// @description Setup intro

cam = instance_find(o_camera, 0);

cam.target = self;

begin_game = false;


alpha	= 0;
section = 5;
transition = 0;

alarm[0] = 90; //delay between sections