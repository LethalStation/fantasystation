// Base fantasystation organic floor types, like mats and whatnot, basetype is dried grass

/turf/open/floor/fantasy_organic
	name = "grass floor mat"
	desc = "A woven mat made of dried grass. Can be cut apart with a knife."
	icon = 'icons/obj/fantasystation_obj/floors/grassmat.dmi'
	icon_state = "grassmat-0"
	base_icon_state = "grassmat"
	baseturfs = /turf/baseturf_bottom // These shouldnt be map placed ever but just in case
	floor_tile = null
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_TURF_OPEN + SGROUP_GRASS_MAT
	canSmoothWith = SGROUP_GRASS_MAT
	flags_1 = NONE
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS
	clawfootstep = FOOTSTEP_GRASS
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	/// What we make when we're torn up
	var/obj/torn_up_result = /obj/item/fantasy_cut_grass

/turf/open/floor/fantasy_organic/broken_states()
	return

/turf/open/floor/fantasy_organic/crowbar_act(mob/living/user, obj/item/I)
	return FALSE

/turf/open/floor/fantasy_organic/attackby(obj/item/object, mob/living/user, params)
	if(object.tool_behaviour == TOOL_KNIFE)
		if(!do_after(user, 3 SECONDS, src))
			return
		playsound(src, 'sound/items/poster_ripped.ogg', 50, TRUE)
		new torn_up_result(src)
		src.ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
	else
		return ..()

// Reed mats

/turf/open/floor/fantasy_organic/reed
	name = "reed floor mat"
	desc = "A woven mat made of river reeds. Can be cut apart with a knife."
	icon = 'icons/obj/fantasystation_obj/floors/reedmat.dmi'
	icon_state = "reedmat-0"
	base_icon_state = "reedmat"
	torn_up_result = /obj/item/fantasy_cut_cattail
	smoothing_groups = SMOOTH_GROUP_TURF_OPEN + SGROUP_REED_MAT
	canSmoothWith = SGROUP_REED_MAT
