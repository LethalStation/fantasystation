/obj/item/food/fantasy_grown
	icon = 'icons/obj/fantasystation_obj/harvested_plants.dmi'
	icon_state = "muckroot"
	/// List of what types of turfs this can be planted on
	var/list/turfs_we_plant_on = list()
	/// What type of plant we make when we're planted down
	var/plant_to_make = null
	/// If FALSE, this object cannot be distilled into an alcohol.
	var/can_distill = TRUE
	/// The reagent this plant distill to. If NULL, it uses a generic fruit_wine reagent and adjusts its variables.
	var/datum/reagent/distill_reagent
	/// Flavor of the plant's wine if NULL distll_reagent. If NULL, this is automatically set to the fruit's flavor.
	var/wine_flavor
	/// Boozepwr of the wine if NULL distill_reagent
	var/wine_power = 10

/obj/item/food/fantasy_grown/examine(mob/user)
	. = ..()
	if(length(turfs_we_plant_on) && plant_to_make)
		. += span_notice("This can be planted in:")
		for(var/turf/plantable_turf as anything in turfs_we_plant_on)
			. += span_notice("- [plantable_turf.name]")
	if(distill_reagent)
		. += span_notice("It can be brewed into [distill_reagent::name].")
	else
		. += span_notice("It cannot be brewed.")
	if(juice_typepath)
		. += span_notice("It can be juiced into [juice_typepath::name]")
	if(length(grind_results))
		. += span_notice("It can be ground into:")
		for(var/datum/reagent/grind_reagent as anything in grind_results)
			. += span_notice("- [grind_reagent::name]")

/obj/item/food/fantasy_grown/make_germ_sensitive(mapload)
	return

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

/// Copy of the ferment proc from regular grown tg plants
/obj/item/food/fantasy_grown/proc/ferment()
	var/reagent_purity = 1
	var/purity_above_base = clamp((reagent_purity - 0.5) * 2, 0, 1)
	var/quality_min = DRINK_NICE
	var/quality_max = DRINK_FANTASTIC
	var/quality = round(LERP(quality_min, quality_max, purity_above_base))
	for(var/datum/reagent/reagent in reagents.reagent_list)
		if(reagent.type != /datum/reagent/consumable/nutriment && reagent.type != /datum/reagent/consumable/nutriment/vitamin)
			continue
		if(distill_reagent)
			var/data = list()
			var/datum/reagent/consumable/ethanol/booze = distill_reagent
			data["quality"] = quality
			data["boozepwr"] = round(initial(booze.boozepwr) * reagent_purity * 2) // default boozepwr at 50% purity
			reagents.add_reagent(distill_reagent, reagent.volume, data, added_purity = reagent_purity)
		else
			var/data = list()
			data["names"] = list("[initial(name)]" = 1)
			data["color"] = reagent.color // filling_color is not guaranteed to be set for every plant. try to use it if we have it, otherwise use the reagent's color var
			data["boozepwr"] = round(wine_power * reagent_purity * 2) // default boozepwr at 50% purity
			data["quality"] = quality
			if(wine_flavor)
				data["tastes"] = list(wine_flavor = 1)
			else
				data["tastes"] = list(tastes[1] = 1)
			reagents.add_reagent(/datum/reagent/consumable/ethanol/fruit_wine, reagent.volume, data, added_purity = reagent_purity)
		reagents.del_reagent(reagent.type)
