/datum/biome/fantasy_water_pond
	turf_type = /turf/open/water/vintage

	flora_types = list(
		/obj/structure/flora/fantasy_regrowing/cattail = 1,
	)
	feature_types = list(
		/obj/item/vintage_stick = 3,
		/obj/effect/spawner/random/rock_and_roll = 3,
		/obj/effect/spawner/random/rock_and_roll/super = 2,
		/obj/effect/spawner/random/rock_and_roll/lots_of_them = 1,
	)
	fauna_types = list()

	flora_density = 10
	feature_density = 10
	fauna_density = 0

/datum/biome/fantasy_water_pond_surroundings
	turf_type = /turf/open/misc/fire_clay

	flora_types = list(
		/obj/structure/flora/fantasy_regrowing = 1,
	)
	feature_types = list()
	fauna_types = list()

	flora_density = 40
	feature_density = 0
	fauna_density = 0

/datum/biome/fantasy_the_slop
	turf_type = /turf/open/misc/muck_slop

	flora_types = list(
		/obj/structure/flora/fantasy_regrowing = 2,
		/obj/structure/flora/fantasy_tree/pet_bush/random_icon = 1,
	)
	feature_types = list(
		/obj/item/vintage_stick = 1,
	)
	fauna_types = list()

	flora_density = 30
	feature_density = 5
	fauna_density = 0
