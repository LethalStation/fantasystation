/// Nuts of the wetland groundnut plant

/obj/item/food/fantasy_grown/groundnut
	name = "groundnuts"
	desc = "A collection of groundnuts, which make for good eating either raw or roasted."
	icon_state = "groundnuts"
	foodtypes = VEGETABLES
	turfs_we_plant_on = list(
		/turf/open/misc/regular_soil,
		/turf/open/misc/muck_slop,
	)
	plant_to_make = /obj/structure/flora/fantasy_regrowing/groundnut/ungrown
	tastes = list(
		"tree nut" = 3,
	)
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	distill_reagent = /datum/reagent/consumable/ethanol/groundnut
	grind_results = list(
		/datum.reagent/medicine/c2/probital = 3,
	)

/obj/item/food/fantasy_grown/groundnut/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/fantasy_grown/groundnut/cooked, rand(45 SECONDS, 90 SECONDS), TRUE, TRUE)

/obj/item/food/fantasy_grown/groundnut/cooked
	name = "roasted groundnuts"
	desc = "A collection of groundnuts that have been roasted over a fire. The shells turn a stark white color when exposed to high heat, giving them their distinctive look."
	icon_state = "groundnuts_cooked"
	turfs_we_plant_on = list()
	plant_to_make = null
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	distill_reagent = /datum/reagent/consumable/ethanol/groundnut/cooked
	grind_results = list(
		/datum.reagent/medicine/c2/libital = 3,
	)

/obj/item/food/fantasy_grown/groundnut/cooked/make_grillable()
	return
