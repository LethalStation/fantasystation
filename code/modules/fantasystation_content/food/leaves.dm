/// Ratweed leaves

/obj/item/food/fantasy_grown/ratweed_leaf
	name = "ratweed leaves"
	desc = "The edible leaves from the ratweed plant. Surprisingly neutral in taste given the name and place of origin."
	icon_state = "rat_weed"
	foodtypes = VEGETABLES
	turfs_we_plant_on = list()
	plant_to_make = null
	tastes = list(
		"watery greens" = 1,
	)
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
	)
	distill_reagent = /datum/reagent/consumable/ethanol/ratweed
	grind_results = list(
		/datum/reagent/medicine/omnizine = 2
	)
