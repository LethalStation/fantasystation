/obj/structure/flora/fantasy_tree
	name = "tree"
	desc = "A large tree."
	icon = 'icons/obj/fantasystation_obj/trees.dmi'
	icon_state = "tree_1"
	density = TRUE
	pixel_x = -24
	layer = FLY_LAYER
	plane = ABOVE_GAME_PLANE
	drag_slowdown = 1.5
	product_types = list(/obj/item/grown/log/tree = 1)
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
	/// If this tree has a seethrough map
	var/seethrough = TRUE

/obj/structure/flora/fantasy_tree/Initialize(mapload)
	. = ..()
	if(seethrough)
		AddComponent(/datum/component/seethrough, get_seethrough_map())

///Return a see_through_map, examples in seethrough.dm
/obj/structure/flora/fantasy_tree/proc/get_seethrough_map()
	return SEE_THROUGH_MAP_DEFAULT

/obj/structure/flora/fantasy_tree/harvest(mob/living/user, product_amount_multiplier)
	. = ..()
	var/turf/my_turf = get_turf(src)
	playsound(my_turf, 'sound/effects/meteorimpact.ogg', 100 , FALSE, FALSE)
	var/obj/structure/flora/fantasy_tree/stump/new_stump = new(my_turf)
	new_stump.name = "[name] stump"
	new_stump.icon_state = "[icon_state]_stump"

/obj/structure/flora/fantasy_tree/stump
	name = "stump"
	desc = "This represents our promise to the elves, and the world itself. To cut down as many trees as possible."
	icon_state = "tree_1_stump"
	density = FALSE
	delete_on_harvest = TRUE
	seethrough = FALSE

/obj/structure/flora/fantasy_tree/stump/harvest(mob/living/user, product_amount_multiplier)
	to_chat(user, span_notice("You manage to remove [src]."))
	qdel(src)

/obj/structure/flora/fantasy_tree/stump/uproot(mob/living/user)
	..()
	to_chat(user, span_notice("You manage to remove [src]."))
	qdel(src)

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
