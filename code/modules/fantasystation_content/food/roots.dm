/// River reed roots

/obj/item/seeds/fantasy_river_reed
	name = "debug river reed seeds"
	desc = "You're not supposed to be here. - Jesus, shortly after catching you time travelling."
	icon_state = "seed-kronkus"
	product = /obj/item/food/grown/river_reed_root
	reagents_add = list(
		/datum/reagent/consumable/nutriment/cloth_fibers = 0.04,
		/datum/reagent/consumable/nutriment = 0.1,
	)

/obj/item/food/grown/river_reed_root
	name = "river reed root"
	desc = "The root of a river reed, not the tastiest thing around but it'll work for food. You can use these on water to plant them."
	icon = 'icons/obj/fantasystation_obj/harvested_plants.dmi'
	icon_state = "cattail_root"
	seed = /obj/item/seeds/fantasy_river_reed
	foodtypes = VEGETABLES
	plant_to_make = /obj/structure/flora/fantasy_regrowing/cattail/ungrown
	tastes = list(
		"starch" = 3,
		"dirt" = 2,
		"sugary water" = 1,
	)

/// Muckroot

/obj/item/seeds/fantasy_muckroot_seed
	name = "debug muckroot seeds"
	desc = "You're not supposed to be here. - Jesus, shortly after catching you time travelling."
	icon_state = "seed-kronkus"
	product = /obj/item/food/grown/river_muckroot
	reagents_add = list(
		/datum/reagent/consumable/nutriment/cloth_fibers = 0.06
		/datum/reagent/consumable/nutriment/vitamin = 0.04,
		/datum/reagent/consumable/nutriment = 0.1,
	)

/obj/item/food/grown/fantasy_muckroot
	name = "muckroot"
	desc = "The root of the aptly named muckroot plant, not the most appetizing meal in the world but its better than rocks."
	icon = 'icons/obj/fantasystation_obj/harvested_plants.dmi'
	icon_state = "muckroot"
	seed = /obj/item/seeds/fantasy_muckroot_seed
	foodtypes = VEGETABLES
	plant_to_make = /obj/structure/flora/fantasy_regrowing/muckroot/ungrown
	tastes = list(
		"starch" = 3,
		"dirt" = 2,
		"sugary water" = 1,
	)
