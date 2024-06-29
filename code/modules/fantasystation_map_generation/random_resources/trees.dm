/obj/structure/flora/fantasy_tree
	name = "tree"
	desc = "A large tree."
	icon = 'icons/obj/fantasystation_obj/trees.dmi'
	icon_state = "tree_1"
	density = TRUE
	pixel_x = -24
	layer = FLY_LAYER
	plane = GAME_PLANE
	drag_slowdown = 1.5
	product_types = list(
		/obj/item/stack/fantasy_logs = 1,
	)
	harvest_amount_low = 6
	harvest_amount_high = 10
	harvest_message_low = "You manage to gather a few logs from the tree."
	harvest_message_med = "You manage to gather some logs from the tree."
	harvest_message_high = "You manage to get most of the wood from the tree."
	harvest_verb = "chop"
	harvest_verb_suffix = "s down"
	delete_on_harvest = TRUE
	can_uproot = FALSE
	flora_flags = FLORA_HERBAL | FLORA_WOODEN
	resistance_flags = FLAMMABLE
	/// If this tree has a seethrough map
	var/seethrough = TRUE
	/// If this makes a stump when cut down
	var/makes_stumps = TRUE
	/// How many sticks this tree makes when cut down
	var/number_of_sticks = 3
	/// If the tree makes a dramatic sound when felled
	var/felling_sound = 'sound/fantasystation/nature/tree_fell.ogg'

/obj/structure/flora/fantasy_tree/Initialize(mapload)
	. = ..()
	if(seethrough)
		AddComponent(/datum/component/seethrough, get_seethrough_map())

/obj/structure/flora/fantasy_tree/can_harvest(mob/user, obj/item/harvesting_item)

	if(flags_1 & HOLOGRAM_1)
		return FALSE
	if(harvested || !harvestable)
		return null

	if(harvesting_item)
		//Check to see if wooden flora is being attacked by a saw item (letting the items on/off state control this is better than putting them in the list)
		if((flora_flags & FLORA_WOODEN) && (harvesting_item.tool_behaviour == TOOL_AXE))
			return TRUE
		//Check to see if stone flora is being attacked by a mining item (same reason as above)
		if((flora_flags & FLORA_STONE) && (harvesting_item.tool_behaviour == TOOL_MINING))
			return TRUE
		//We checked all item interactions and could not harvest, lets return
		return FALSE

	//If there was no harvesting item supplied, check if it is hand harvestable
	if(harvest_with_hands)
		return TRUE

	return FALSE

///Return a see_through_map, examples in seethrough.dm
/obj/structure/flora/fantasy_tree/proc/get_seethrough_map()
	return SEE_THROUGH_MAP_DEFAULT

/obj/structure/flora/fantasy_tree/harvest(mob/living/user, product_amount_multiplier)
	. = ..()
	if(!makes_stumps)
		return
	var/turf/my_turf = get_turf(src)
	if(felling_sound)
		playsound(my_turf, felling_sound, 50, TRUE)
	else
		playsound(my_turf, SFX_TREE_CHOP, 100 , TRUE)
	var/obj/structure/flora/fantasy_tree/stump/new_stump = new(my_turf)
	new_stump.name = "[name] stump"
	new_stump.icon_state = "[icon_state]_stump"
	var/list/nearby_turfs = list()
	for(var/turf/near_turf in range(1))
		nearby_turfs += near_turf
	for(var/new_stick in 1 to number_of_sticks)
		var/obj/new_stick_spawned = new /obj/item/vintage_stick(pick(nearby_turfs))
		new_stick_spawned.pixel_x = rand(-14, 14)
		new_stick_spawned.pixel_y = rand(-14, 14)

/obj/structure/flora/fantasy_tree/stump
	name = "stump"
	desc = "This represents our promise to the elves, and the world itself. To cut down as many trees as possible."
	icon_state = "tree_1_stump"
	harvest_amount_low = 0
	harvest_amount_high = 0
	density = FALSE
	delete_on_harvest = TRUE
	seethrough = FALSE
	makes_stumps = FALSE
	number_of_sticks = 0
	plane = GAME_PLANE
	felling_sound = null

/obj/structure/flora/fantasy_tree/stump/harvest(mob/living/user, product_amount_multiplier)
	to_chat(user, span_notice("You manage to remove [src]."))
	qdel(src)

/obj/structure/flora/fantasy_tree/stump/uproot(mob/living/user)
	..()
	to_chat(user, span_notice("You manage to remove [src]."))
	qdel(src)

/obj/structure/flora/fantasy_tree/swamp
	name = "swamp tree"
	desc = "A large tree. This one is commonly seen around swamps and bogs."
	icon_state = "swamp_tree_1"
	product_types = list(
		/obj/item/stack/fantasy_logs/swamp = 1,
	)

/obj/structure/flora/fantasy_tree/stump/swamp
	icon_state = "swamp_tree_1_stump"

/obj/structure/flora/fantasy_tree/pet_bush
	name = "bush"
	desc = "A large bush."
	icon = 'icons/obj/fantasystation_obj/tall_plants.dmi'
	icon_state = "bush_1"
	pixel_x = 0
	harvest_amount_low = 1
	harvest_amount_high = 2
	harvest_message_low = "You manage to gather a few logs from the bush."
	harvest_message_med = "You manage to gather some logs from the bush."
	harvest_message_high = "You manage to get most of the wood from the bush."
	density = FALSE
	makes_stumps = FALSE
	number_of_sticks = 2
	felling_sound = null

/obj/structure/flora/fantasy_tree/pet_bush/Initialize(mapload)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/flora/fantasy_tree/pet_bush/proc/on_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	if(!ismob(AM))
		return
	Shake(1, 1, 1 SECONDS)
	playsound(src, SFX_CRUNCHY_BUSH_WHACK, 50, vary = TRUE)

/obj/structure/flora/fantasy_tree/pet_bush/get_seethrough_map()
	return SEE_THROUGH_MAP_JUST_THE_OBJECT_TILE

/obj/structure/flora/fantasy_tree/pet_bush/swamp
	name = "swamp bush"
	desc = "A large bush. This one is commonly seen in swamps and bogs"
	icon_state = "swamp_bush_1"
	product_types = list(
		/obj/item/stack/fantasy_logs/swamp = 1,
	)

// Random icon versions of the above

/obj/structure/flora/fantasy_tree/random_icon

/obj/structure/flora/fantasy_tree/random_icon/Initialize(mapload)
	. = ..()
	var/list/random_states = list(
		"tree_1",
		"tree_2",
		"tree_3",
	)
	icon_state = pick(random_states)
	update_appearance()

/obj/structure/flora/fantasy_tree/stump/random_icon

/obj/structure/flora/fantasy_tree/stump/random_icon/Initialize(mapload)
	. = ..()
	var/list/random_states = list(
		"tree_1_stump",
		"tree_2_stump",
		"tree_3_stump",
	)
	icon_state = pick(random_states)
	update_appearance()

/obj/structure/flora/fantasy_tree/swamp/random_icon

/obj/structure/flora/fantasy_tree/swamp/random_icon/Initialize(mapload)
	. = ..()
	var/list/random_states = list(
		"swamp_tree_1",
		"swamp_tree_2",
		"swamp_tree_3",
	)
	icon_state = pick(random_states)
	update_appearance()

/obj/structure/flora/fantasy_tree/stump/swamp/random_icon

/obj/structure/flora/fantasy_tree/stump/swamp/random_icon/Initialize(mapload)
	. = ..()
	var/list/random_states = list(
		"swamp_tree_1_stump",
		"swamp_tree_2_stump",
		"swamp_tree_3_stump",
	)
	icon_state = pick(random_states)
	update_appearance()

/obj/structure/flora/fantasy_tree/pet_bush/random_icon

/obj/structure/flora/fantasy_tree/pet_bush/random_icon/Initialize(mapload)
	. = ..()
	var/list/random_states = list(
		"bush_1",
		"bush_2",
		"bush_3",
		"bush_4",
	)
	icon_state = pick(random_states)
	update_appearance()

/obj/structure/flora/fantasy_tree/pet_bush/swamp/random_icon

/obj/structure/flora/fantasy_tree/pet_bush/swamp/Initialize(mapload)
	. = ..()
	var/list/random_states = list(
		"swamp_bush_1",
		"swamp_bush_2",
		"swamp_bush_3",
	)
	icon_state = pick(random_states)
	update_appearance()
