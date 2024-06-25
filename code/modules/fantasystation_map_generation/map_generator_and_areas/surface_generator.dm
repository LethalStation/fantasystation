/datum/map_generator/cave_generator/fantasy_surface
	initial_closed_chance = 0
	possible_biomes = list(
		BIOME_LOW_HEAT = list(
			BIOME_LOW_HUMIDITY = /datum/biome/fantasy_the_slop,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/fantasy_water_pond_surroundings,
			BIOME_HIGH_HUMIDITY = /datum/biome/fantasy_water_pond,
		),
		BIOME_MEDIUM_HEAT = list(
			BIOME_LOW_HUMIDITY = /datum/biome/fantasy_regular_soil,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/fantasy_grassy,
			BIOME_HIGH_HUMIDITY = /datum/biome/fantasy_regular_soil,
		),
		BIOME_HIGH_HEAT = list(
			BIOME_LOW_HUMIDITY = /datum/biome/fantasy_desert,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/fantasy_cracked_earth,
			BIOME_HIGH_HUMIDITY = /datum/biome/fantasy_grassy,
		)
	)
