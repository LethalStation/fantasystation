#define BIOME_RANDOM_SQUARE_DRIFT 1

/datum/map_generator/cave_generator/fantasy_surface
	initial_closed_chance = 0
	perlin_zoom = 45
	possible_biomes = list(
		BIOME_LOW_HEAT = list(
			BIOME_LOW_HUMIDITY = /datum/biome/fantasy_the_slop,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/fantasy_water_pond_surroundings,
			BIOME_HIGH_HUMIDITY = /datum/biome/fantasy_water_pond,
		),
		BIOME_MEDIUM_HEAT = list(
			BIOME_LOW_HUMIDITY = /datum/biome/fantasy_regular_soil,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/fantasy_grassy,
			BIOME_HIGH_HUMIDITY = /datum/biome/fantasy_the_slop,
		),
		BIOME_HIGH_HEAT = list(
			BIOME_LOW_HUMIDITY = /datum/biome/fantasy_cracked_earth,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/fantasy_grassland,
			BIOME_HIGH_HUMIDITY = /datum/biome/fantasy_grassy,
		)
	)

/datum/map_generator/cave_generator/fantasy_surface/generate_terrain_with_biomes(list/turfs, area/generate_in)
	var/humidity_seed = rand(0, 50000)
	var/heat_seed = rand(0, 50000)

	var/start_time = REALTIMEOFDAY
	string_gen = rustg_cnoise_generate("[initial_closed_chance]", "[smoothing_iterations]", "[birth_limit]", "[death_limit]", "[world.maxx]", "[world.maxy]") //Generate the raw CA data

	var/humidity_gen = list()
	humidity_gen[BIOME_HIGH_HUMIDITY] = rustg_dbp_generate("[humidity_seed]", "60", "[perlin_zoom]", "[world.maxx]", "-0.1", "1.1")
	humidity_gen[BIOME_MEDIUM_HUMIDITY] = rustg_dbp_generate("[humidity_seed]", "60", "[perlin_zoom]", "[world.maxx]", "-0.3", "-0.1")

	var/heat_gen = list()
	heat_gen[BIOME_HIGH_HEAT] = rustg_dbp_generate("[heat_seed]", "60", "[perlin_zoom]", "[world.maxx]", "-0.1", "1.1")
	heat_gen[BIOME_MEDIUM_HEAT] = rustg_dbp_generate("[heat_seed]", "60", "[perlin_zoom]", "[world.maxx]", "-0.3", "-0.1")

	var/list/expanded_closed_turfs = src.closed_turf_types
	var/list/expanded_open_turfs = src.open_turf_types

	spawn_rivers_by_marker_id(2, /area/vintage)

	for(var/turf/gen_turf as anything in turfs) //Go through all the turfs and generate them
		if(!istype(gen_turf, /turf/open/genturf))
			continue
		var/closed = string_gen[world.maxx * (gen_turf.y - 1) + gen_turf.x] != "0"
		var/new_turf_type = pick(closed ? expanded_closed_turfs : expanded_open_turfs)

		var/datum/biome/selected_biome

		// Here comes the meat of the biome code.
		var/drift_x = clamp((gen_turf.x + rand(-BIOME_RANDOM_SQUARE_DRIFT, BIOME_RANDOM_SQUARE_DRIFT)), 1, world.maxx) // / perlin_zoom
		var/drift_y = clamp((gen_turf.y + rand(-BIOME_RANDOM_SQUARE_DRIFT, BIOME_RANDOM_SQUARE_DRIFT)), 2, world.maxy) // / perlin_zoom

		// Where we go in the generated string (generated outside of the loop for s p e e d)
		var/coordinate = world.maxx * (drift_y - 1) + drift_x

		// Type of humidity zone we're in (LOW-MEDIUM-HIGH)
		var/humidity_level = text2num(humidity_gen[BIOME_HIGH_HUMIDITY][coordinate]) ? \
			BIOME_HIGH_HUMIDITY : text2num(humidity_gen[BIOME_MEDIUM_HUMIDITY][coordinate]) ? BIOME_MEDIUM_HUMIDITY : BIOME_LOW_HUMIDITY
		// Type of heat zone we're in (LOW-MEDIUM-HIGH)
		var/heat_level = text2num(heat_gen[BIOME_HIGH_HEAT][coordinate]) ? \
			BIOME_HIGH_HEAT : text2num(heat_gen[BIOME_MEDIUM_HEAT][coordinate]) ? BIOME_MEDIUM_HEAT : BIOME_LOW_HEAT

		selected_biome = possible_biomes[heat_level][humidity_level]

		// Currently, we only affect open turfs, because biomes don't currently
		// have a definition for biome-specific closed turfs.
		if((!length(biome_accepted_turfs) && !closed) || biome_accepted_turfs[new_turf_type])
			LAZYADD(generated_turfs_per_biome[selected_biome], gen_turf)

		else
			// The assumption is this will be faster then changeturf, and changeturf isn't required since by this point
			// The old tile hasn't got the chance to init yet
			var/turf/new_turf = new new_turf_type(gen_turf)

			if(gen_turf.turf_flags & NO_RUINS)
				new_turf.turf_flags |= NO_RUINS

		CHECK_TICK

	for(var/biome in generated_turfs_per_biome)
		var/datum/biome/generating_biome = SSmapping.biomes[biome]

		var/list/turf/generated_turfs = generating_biome.generate_turfs_for_terrain(generated_turfs_per_biome[biome])

		generated_turfs_per_biome[biome] = generated_turfs

	var/message = "[name] terrain generation finished in [(REALTIMEOFDAY - start_time)/10]s!"
	to_chat(world, span_boldannounce("[message]"))
	log_world(message)

#undef BIOME_RANDOM_SQUARE_DRIFT

/datum/map_generator/cave_generator/fantasy_surface/swamp
	perlin_zoom = 20
	possible_biomes = list(
		BIOME_LOW_HEAT = list(
			BIOME_LOW_HUMIDITY = /datum/biome/fantasy_the_slop_swamp,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/fantasy_swamp_water_surroundings,
			BIOME_HIGH_HUMIDITY = /datum/biome/fantasy_swamp_water,
		),
		BIOME_MEDIUM_HEAT = list(
			BIOME_LOW_HUMIDITY = /datum/biome/fantasy_grassy_swamp,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/fantasy_swamp_water_surroundings,
			BIOME_HIGH_HUMIDITY = /datum/biome/fantasy_swamp_water,
		),
		BIOME_HIGH_HEAT = list(
			BIOME_LOW_HUMIDITY = /datum/biome/fantasy_grassy_swamp,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/fantasy_regular_soil/swamp,
			BIOME_HIGH_HUMIDITY = /datum/biome/fantasy_the_slop_swamp,
		)
	)
