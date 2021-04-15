/// @description Free Surface

if(surface_exists(surf_lighting))
{
	surface_free(surf_lighting);
}

if(surface_exists(surf_environment))
{
	surface_free(surf_environment);
}

lightmap = -1;