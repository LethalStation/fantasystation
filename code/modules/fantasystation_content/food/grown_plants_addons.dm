/obj/item/food/fantasy_grown
	icon = 'icons/obj/fantasystation_obj/harvested_plants.dmi'
	icon_state = "muckroot"
	/// List of what types of turfs this can be planted on
	var/list/turfs_we_plant_on = list()
	/// What type of plant we make when we're planted down
	var/plant_to_make = null

/obj/item/food/fantasy_grown/examine(mob/user)
	. = ..()
	if(length(turfs_we_plant_on) && plant_to_make)
		. += span_notice("This can be planted in:")
		for(var/turf/plantable_turf in turfs_we_plant_on)
			. += span_notice("- [plantable_turf.name]")

/obj/item/food/fantasy_grown/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(length(turfs_we_plant_on) && plant_to_make)
		try_planting_grown(interacting_with, user)

/// Tries to plant a thing from the variables above using the food as a seed
/obj/item/food/fantasy_grown/proc/try_planting_grown(turf/interacting_turf, mob/living/user)
	if(!istype(interacting_turf))
		return
	if(!is_type_in_list(interacting_turf, turfs_we_plant_on))
		balloon_alert(user, "cannot plant here")
		return
	if(!do_after(user, 5 SECONDS, interacting_turf))
		return
	new plant_to_make(interacting_turf)
	balloon_alert(user, "planted")
	qdel(src)
