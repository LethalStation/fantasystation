/// Ratweed seeds

/obj/item/food/fantasy_grown/ratweed_seeds
	name = "ratweed seeds"
	desc = "The seeds of the ratweed plant, used for growing more, but also good for cracking open and eating raw."
	icon_state = "rat_weed_seeds"
	foodtypes = NUTS
	plant_to_make = /obj/structure/flora/fantasy_regrowing/ratweed/ungrown
	turfs_we_plant_on = list(
		/turf/open/water/vintage/swamp,
	)
	tastes = list(
		"dried seeds" = 2,
	)
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	can_distill = FALSE
	grind_results = list(
		/datum/reagent/medicine/coagulant = 2,
	)
