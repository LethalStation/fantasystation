/obj/item/food/grown
	/// List of what types of turfs this can be planted on
	var/list/turfs_we_plant_on = list()
	/// What type of plant we make when we're planted down
	var/plant_to_make = null

/obj/item/food/grown/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(length(turfs_we_plant_on) && plant_to_make)
		try_planting_grown(interacting_with, user)

/obj/item/food/grown/try_planting_grown(turf/interacting_turf, mob/living/user)
	if(!istype(interacting_turf))
		return
	if(!is_type_in_list(interacting_turf, turfs_we_plant_on))
		balloon_alert(user, "cannot plant here")
		return
	if(!do_after(user, 5 SECONDS, interacting_turf))
		return

