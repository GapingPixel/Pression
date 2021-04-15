/// @description Draw Synopsis

draw_set_alpha(0.5 * alpha);

draw_set_font(font_quattrocento);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

switch(section)
{
	case -1: 
		//gpu_set_colorwriteenable(true, true, true, false);
		draw_set_alpha(1);
		draw_rectangle(0, 0, 640, 360, false);
		draw_set_color(c_white);
		draw_text(320, 140, "P R E S S I O N - Prototype Build 02");
		draw_text(320, 180, "Copyright \u00A9 2018, 2019 Martin Bergman All Rights Reserved");
		draw_set_color(c_black);
		//gpu_set_colorwriteenable(true, true, true, false);
		break;
	case 0: draw_text(320, 180,
			
			"In 1947 an island several miles off the coast\n" +
			"of Russia disappeared"
			
			); break
	case 1: draw_text(320, 180,
			
			"A team of select individuals was dispatched\n" +
			"to investigate the area and report back on their findings"
			
			); break
	case 2: draw_text(320, 180,
			
			"That team would never be heard from again\n" +
			"and the failed investigation was covered up"
			
			); break
	case 3: draw_text(320, 180,
			
			"Many decades later a ship travelling through\n" +
			"those same waters was reported missing"
			
			); break
	case 4: draw_text(320, 180,
			
		"What follows are the events that took place during that time . . ."
			
		); break
	case 5: draw_set_font(font_synopsis_title);
	
		draw_text(320, 180,
			
		"P R E S S I O N"
			
		); break
}

draw_set_font(-1);

draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_set_alpha(1);