/// River reed roots

/obj/item/food/fantasy_grown/river_reed_root
	name = "river reed root"
	desc = "The root of a river reed, not the tastiest thing around but it'll work for food. You can use these on water to plant them."
	icon_state = "cattail_root"
	foodtypes = VEGETABLES
	plant_to_make = /obj/structure/flora/fantasy_regrowing/cattail/ungrown
	turfs_we_plant_on = list(
		/turf/open/water/vintage,
	)
	tastes = list(
		"starch" = 3,
		"dirt" = 2,
		"sugary water" = 1,
	)
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/sugar = 1,
	)
	distill_reagent = /datum/reagent/consumable/ethanol/river_reed_root
	grind_results = list(
		/datum/reagent/medicine/potass_iodide = 3,
	)

/obj/item/food/fantasy_grown/river_reed_root/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/fantasy_grown/river_reed_root/cooked, rand(60 SECONDS, 90 SECONDS), TRUE, TRUE)

/obj/item/food/fantasy_grown/river_reed_root/cooked
	name = "baked river reed root"
	desc = "The root of a river reed, this one appears to have been cooked over a fire or in an oven to make it more palatable."
	icon_state = "cattail_root_cooked"
	plant_to_make = null
	turfs_we_plant_on = list()
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/sugar = 2,
	)
	distill_reagent = /datum/reagent/consumable/ethanol/river_reed_root/cooked
	grind_results = list(
		/datum/reagent/medicine/pen_acid = 3,
	)

/obj/item/food/fantasy_grown/river_reed_root/cooked/make_grillable()
	return

/// Muckroot

/obj/item/food/fantasy_grown/fantasy_muckroot
	name = "muckroot"
	desc = "The root of the aptly named muckroot plant, not the most appetizing meal in the world but its better than rocks."
	icon_state = "muckroot"
	foodtypes = VEGETABLES
	turfs_we_plant_on = list(
		/turf/open/misc/muck_slop,
		/turf/open/misc/fire_clay,
	)
	plant_to_make = /obj/structure/flora/fantasy_regrowing/muckroot/ungrown
	tastes = list(
		"starch" = 3,
		"dirt" = 2,
		"sugary water" = 1,
	)
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/sugar = 2,
	)
	distill_reagent = /datum/reagent/consumable/ethanol/muckroot
	grind_results = list(
		/datum/reagent/medicine/c2/hercuri = 3,
		/datum/reagent/medicine/atropine = 2,
	)

/obj/item/food/fantasy_grown/fantasy_muckroot/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/fantasy_grown/fantasy_muckroot/cooked, rand(60 SECONDS, 90 SECONDS), TRUE, TRUE)

/obj/item/food/fantasy_grown/fantasy_muckroot/cooked
	name = "baked muckroot"
	desc = "The root of the aptly named muckroot plant, this one has been baked in an oven or over a fire to make it more palatable."
	icon_state = "muckroot_cooked"
	turfs_we_plant_on = list()
	plant_to_make = null
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/sugar = 3,
	)
	distill_reagent = /datum/reagent/consumable/ethanol/muckroot/cooked
	grind_results = list(
		/datum/reagent/medicine/c2/aiuri = 3,
		/datum/reagent/medicine/salbutamol = 2,
	)

/obj/item/food/fantasy_grown/fantasy_muckroot/cooked/make_grillable()
	return

/// Hideroot

/obj/item/food/fantasy_grown/hideroot
	name = "hideroot"
	desc = "The root of the similarly named hideroot plant, edible but toxic until cooked extensively."
	icon_state = "hideroot"
	foodtypes = VEGETABLES
	turfs_we_plant_on = list(
		/turf/open/misc/regular_soil,
		/turf/open/misc/muck_slop,
	)
	plant_to_make = /obj/structure/flora/fantasy_regrowing/hideroot/ungrown
	tastes = list(
		"starch" = 3,
		"dirt" = 2,
		"bitterness" = 1,
	)
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/toxin = 4,
	)
	can_distill = FALSE
	grind_results = list(
		/datum/reagent/medicine/coagulant/seraka_extract = 1,
		/datum/reagent/toxin/histamine = 7
	)

/obj/item/food/fantasy_grown/hideroot/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/fantasy_grown/hideroot/cooked, rand(90 SECONDS, 140 SECONDS), TRUE, TRUE)

/obj/item/food/fantasy_grown/hideroot/cooked
	name = "cooked hideroot"
	desc = "The root of the similarly named hideroot plant, this one has been cooked extensively enough that the toxins within have been neutralized."
	icon_state = "hideroot_cooked"
	turfs_we_plant_on = list()
	plant_to_make = null
	tastes = list(
		"starch" = 3,
		"dirt" = 2,
	)
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	can_distill = TRUE
	distill_reagent = /datum/reagent/consumable/ethanol/hideroot
	grind_results = list(
		/datum/reagent/medicine/coagulant/seraka_extract = 3,
		/datum/reagent/toxin/histamine = 5
	)

/obj/item/food/fantasy_grown/hideroot/cooked/make_grillable()
	return
