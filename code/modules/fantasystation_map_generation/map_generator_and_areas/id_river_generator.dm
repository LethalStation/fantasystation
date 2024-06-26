GLOBAL_LIST_EMPTY(tagged_river_nodes)

/proc/spawn_rivers_by_marker_id(target_z, whitelist_area)
	var/turf/open/edge_turf = /turf/open/misc/muck_slop
	var/turf/open/shallow_turf = /turf/open/water/vintage
	var/turf/open/deep_turf = /turf/open/water/vintage/deep

	var/list/turfs_to_mud = list()
	var/list/turfs_to_shallow = list()
	var/list/turfs_to_deep = list()

	var/list/river_nodes_south = list()
	var/list/river_nodes_east = list()

	for(var/obj/effect/landmark/river_waypoint/fantasystation/river_node_east in GLOB.tagged_river_nodes)
		if(river_node_east.id_tag == "east_river")
			river_nodes_east += river_node_east

	for(var/obj/effect/landmark/river_waypoint/fantasystation/river_node_south in GLOB.tagged_river_nodes)
		if(river_node_south.id_tag == "south_river")
			river_nodes_south += river_node_south

	for(var/obj/effect/landmark/river_waypoint/waypoints as anything in river_nodes_south)
		if (waypoints.z != target_z || waypoints.connected)
			continue
		waypoints.connected = TRUE
		var/turf/cur_turf = get_turf(waypoints)
		cur_turf = new edge_turf(cur_turf)
		var/turf/target_turf = get_turf(pick(river_nodes_south - waypoints))
		if(!target_turf)
			break
		var/detouring = FALSE
		var/cur_dir = get_dir(cur_turf, target_turf)
		var/turf/last_turf = cur_turf
		while(cur_turf != target_turf)
			if(detouring)
				if(prob(20))
					detouring = FALSE
					cur_dir = get_dir(cur_turf, target_turf)
			else if(prob(20))
				detouring = TRUE
				if(prob(50))
					cur_dir = turn(cur_dir, 45)
				else
					cur_dir = turn(cur_dir, -45)
			else
				cur_dir = get_dir(cur_turf, target_turf)

			cur_turf = get_step(cur_turf, cur_dir)
			if(isnull(cur_turf))
				cur_turf = last_turf
				continue
			turfs_to_mud += cur_turf

	for(var/obj/effect/landmark/river_waypoint/waypoints as anything in river_nodes_east)
		if (waypoints.z != target_z || waypoints.connected)
			continue
		waypoints.connected = TRUE
		var/turf/cur_turf = get_turf(waypoints)
		cur_turf = new edge_turf(cur_turf)
		var/turf/target_turf = get_turf(pick(river_nodes_east - waypoints))
		if(!target_turf)
			break
		var/detouring = FALSE
		var/cur_dir = get_dir(cur_turf, target_turf)
		var/turf/last_turf = cur_turf
		while(cur_turf != target_turf)

			if(detouring)
				if(prob(20))
					detouring = FALSE
					cur_dir = get_dir(cur_turf, target_turf)
			else if(prob(20))
				detouring = TRUE
				if(prob(50))
					cur_dir = turn(cur_dir, 45)
				else
					cur_dir = turn(cur_dir, -45)
			else
				cur_dir = get_dir(cur_turf, target_turf)

			cur_turf = get_step(cur_turf, cur_dir)
			if(isnull(cur_turf))
				cur_turf = last_turf
				continue
			turfs_to_mud += cur_turf

	for(var/turf/turf_to_generate_mud in turfs_to_mud)
		var/turf/mud_turf = new edge_turf(turf_to_generate_mud)
		turfs_to_shallow += mud_turf
		mud_turf.spread_better(30, 5, whitelist_area)

	for(var/turf/turf_to_generate_shallow in turfs_to_shallow)
		var/turf/river_turf = new shallow_turf(turf_to_generate_shallow)
		turfs_to_deep += river_turf
		river_turf.spread_better(25, 5, whitelist_area)

	for(var/turf/turf_to_generate_deep in turfs_to_deep)
		var/turf/deep_river_turf = new deep_turf(turf_to_generate_deep)
		deep_river_turf.spread_better(10, 5, whitelist_area)

	for(var/waypoints_spawned in river_nodes_east)
		for(var/turf/turf_near in range(1, waypoints_spawned))
			if(!istype(turf_near, /turf/open/water/vintage/deep))
				new /turf/open/water/vintage/deep(turf_near)

	for(var/waypoints_spawned in river_nodes_south)
		for(var/turf/turf_near in range(1, waypoints_spawned))
			if(!istype(turf_near, /turf/open/water/vintage/deep))
				new /turf/open/water/vintage/deep(turf_near)

/obj/effect/landmark/river_waypoint/fantasystation
	name = "fantasy river waypoint"

/obj/effect/landmark/river_waypoint/fantasystation/Initialize(mapload)
	. = ..()
	GLOB.tagged_river_nodes += src

/obj/effect/landmark/river_waypoint/fantasystation/Destroy()
	GLOB.tagged_river_nodes -= src
	return ..()

/turf/proc/spread_better(probability = 30, prob_loss = 25, whitelisted_area)
	if(probability <= 0)
		return
	var/list/cardinal_turfs = list()
	var/list/diagonal_turfs = list()
	var/logged_turf_type
	for(var/turf/canidate as anything in RANGE_TURFS(1, src) - src)
		if(istype(canidate, src.type))
			continue
		if(!canidate || (canidate.density && !ismineralturf(canidate)) || isindestructiblefloor(canidate))
			continue

		var/area/new_area = get_area(canidate)
		if((!istype(new_area, whitelisted_area) && whitelisted_area) || (canidate.turf_flags & NO_LAVA_GEN))
			continue

		if(!logged_turf_type && ismineralturf(canidate))
			var/turf/closed/mineral/mineral_canidate = canidate
			logged_turf_type = mineral_canidate.turf_type

		if(get_dir(src, canidate) in GLOB.cardinals)
			cardinal_turfs += canidate
		else
			diagonal_turfs += canidate

	for(var/turf/cardinal_canidate as anything in cardinal_turfs) //cardinal turfs are always changed but don't always spread
		// NOTE: WE ARE SKIPPING CHANGETURF HERE
		// The calls in this proc only serve to provide a satisfactory (if it's not ALREADY this) check. They do not actually call changeturf
		// This is safe because this proc can only be run during mapload, and nothing has initialized by now so there's nothing to inherit or delete
		if(!istype(cardinal_canidate, logged_turf_type) && cardinal_canidate.ChangeTurf(type, baseturfs, CHANGETURF_SKIP) && prob(probability))
			if(baseturfs)
				cardinal_canidate.baseturfs = baseturfs
			cardinal_canidate.Spread(probability - prob_loss, prob_loss, whitelisted_area)

	for(var/turf/diagonal_canidate as anything in diagonal_turfs) //diagonal turfs only sometimes change, but will always spread if changed
		// Important NOTE: SEE ABOVE
		if(!istype(diagonal_canidate, logged_turf_type) && prob(probability) && diagonal_canidate.ChangeTurf(type, baseturfs, CHANGETURF_SKIP))
			if(baseturfs)
				diagonal_canidate.baseturfs = baseturfs
			diagonal_canidate.Spread(probability - prob_loss, prob_loss, whitelisted_area)
		else if(ismineralturf(diagonal_canidate))
			var/turf/closed/mineral/diagonal_mineral = diagonal_canidate
			// SEE ABOVE, THIS IS ONLY VERY RARELY SAFE
			new diagonal_mineral.turf_type(diagonal_mineral)
