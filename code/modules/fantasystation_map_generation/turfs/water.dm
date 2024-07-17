/turf/open/water/vintage
	name = "shallow water"
	desc = "A pool of water, is it a pond? Is it a river? I don't know, you're the one looking at it, you tell me."
	icon = 'icons/turf/fantasystation/water.dmi'
	icon_state = "water-255"
	base_icon_state = "water"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_TURF_OPEN + SGROUP_SHALLOW_WATER
	canSmoothWith = SGROUP_SHALLOW_WATER + SGROUP_DEEP_WATER

	baseturfs = /turf/open/water/vintage
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE
	immerse_overlay_color = "#247296"

/turf/open/water/vintage/attackby(obj/item/attacking_item, mob/user, params)
	if(!attacking_item.is_open_container())
		return ..()
	if(!attacking_item.reagents.add_reagent(/datum/reagent/water, rand(10, 20)))
		to_chat(user, span_warning("[attacking_item] is full."))
		return
	user.visible_message(span_notice("[user] scoops some water from the [src] with [attacking_item]."), span_notice("You scoop out some water from the [src] using [attacking_item]."))

/turf/open/water/vintage/deep
	name = "deep water"
	desc = "Water that is both much too deep and with much too strong of a current to safely pass. If you had a ship of some kind however..."
	icon = 'icons/turf/fantasystation/deep_water.dmi'
	icon_state = "deep_water-255"
	base_icon_state = "deep_water"
	smoothing_groups = SMOOTH_GROUP_TURF_OPEN + SGROUP_DEEP_WATER
	canSmoothWith = SGROUP_DEEP_WATER
	baseturfs = /turf/open/water/vintage/deep
	immerse_overlay_color = "#247296"

/turf/open/water/vintage/deep/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	// If the thing is a projectile, for the love of god leave it alone
	if(isprojectile(arrived))
		return
	// If the thing is an effect then also leave it the hell alone
	if(iseffect(arrived))
		return
	// If the thing is an abstract object, do we really need to worry about it?
	if(arrived.invisibility == INVISIBILITY_ABSTRACT)
		return
	// If they are buckled to something, then they are either on a boat or buckled to a mob, which will get repelled anyways
	if(ismob(arrived))
		var/mob/arriving_mob = arrived
		if(arriving_mob.buckled)
			return
	// If the arrived thing is allowed to pass water, then we're not worried about throwing them away
	if(HAS_TRAIT(arrived, TRAIT_DEEP_WATER_PASSER))
		return
	// If they fail the above, however....
	var/atom/throw_target = get_edge_target_turf(arrived, get_dir(src, old_loc))
	if(isliving(arrived))
		to_chat(arrived, span_userdanger("The fierce currents wash you away!"))
	playsound(src, 'sound/effects/submerge.ogg', 50, TRUE)
	arrived.throw_at(throw_target, 1, 2)
	arrived.forceMove(old_loc) // Safety measure (DIAGONAL MOVEMENT!!!)

/turf/open/water/vintage/swamp
	name = "murky water"
	desc = "Gnarly green water that you can barely see through. It's likely there's a million different bugs and parasites in this, but you'd win, right?"
	icon = 'icons/turf/fantasystation/swamp_water.dmi'
	icon_state = "swamp_water-255"
	base_icon_state = "swamp_water"
	smoothing_groups = SMOOTH_GROUP_TURF_OPEN + SGROUP_SWAMP_WATER
	canSmoothWith = SGROUP_SWAMP_WATER
	baseturfs = /turf/open/water/vintage/swamp
	immerse_overlay_color = "#547e64"
