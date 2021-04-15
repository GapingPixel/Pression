/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

ledge_left = instance_create_layer(bbox_left - sprite_get_width(s_mask_ledge), y, "IN_Collision_Map", o_mask_ledge);
ledge_right = instance_create_layer(bbox_right + 1, y, "IN_Collision_Map", o_mask_ledge);