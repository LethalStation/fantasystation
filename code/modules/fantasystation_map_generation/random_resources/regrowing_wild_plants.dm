/obj/structure/flora/fantasy_regrowing
	name = "tall grass"
	desc = "Tall grass, can be cut and used for many things."
	harvested_name = "growing grass"
	harvested_desc = "Some cut grass, you feel like it used to stand much taller."
	icon = 'icons/obj/fantasystation_obj/tall_plants.dmi'
	icon_state = "tall_grass"
	base_icon_state = "tall_grass"
	gender = PLURAL
	layer = OBJ_LAYER - 0.01
	product_types = list(/obj/item/fantasy_cut_grass = 1)
	harvest_amount_low = 1
	harvest_amount_high = 3
	harvest_with_hands = FALSE
	harvest_message_low = "You cut the grass, managing to collect only a little of it."
	harvest_message_med = "You cut the grass, managing to collect a fair amount of it."
	harvest_message_high = "You cut the grass, collecting almost all of it."
	harvest_message_true_thresholds = TRUE
	harvest_verb = "cut"
	flora_flags = FLORA_HERBAL
	resistance_flags = FLAMMABLE
	/// The icon state of the plant when it is harvested
	var/harvest_icon_state = "grass_cut"
	/// If this takes a knife tool to harvest
	var/knife_harvest = TRUE
	/// Does this spawn harvested and do we need to wait to grow?
	var/spawns_harvested = FALSE

/obj/structure/flora/fantasy_regrowing/Initialize(mapload)
	. = ..()
	if(spawns_harvested)
		set_harvested_on_spawn()

/obj/structure/flora/fantasy_regrowing/cattail/atom_deconstruct(disassembled)
	new /obj/item/fantasy_cut_grass(drop_location())

/// Sets the plant to look and act harvested when its placed, good for things planted from seeds
/obj/structure/flora/fantasy_regrowing/proc/set_harvested_on_spawn()
	name = harvested_name
	desc = harvested_desc
	icon_state = harvest_icon_state
	update_appearance()
	harvested = TRUE
	addtimer(CALLBACK(src, PROC_REF(regrow)), rand(regrowth_time_low, regrowth_time_high))

/obj/structure/flora/fantasy_regrowing/harvest(user, product_amount_multiplier)
	if(!..())
		return FALSE
	icon_state = harvest_icon_state
	update_appearance()
	return TRUE

/obj/structure/flora/fantasy_regrowing/can_harvest(mob/user, obj/item/harvesting_item)

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
		// Check and see if we need a knife to harvest this
		if(knife_harvest && (harvesting_item.tool_behaviour == TOOL_KNIFE))
			return TRUE
		//We checked all item interactions and could not harvest, lets return
		return FALSE

	//If there was no harvesting item supplied, check if it is hand harvestable
	if(harvest_with_hands)
		return TRUE

	return FALSE

/obj/structure/flora/fantasy_regrowing/regrow()
	..()
	icon_state = base_icon_state

/// Cut grass

/obj/item/fantasy_cut_grass
	name = "cut grass"
	desc = "A pile of cut grass."
	icon = 'icons/obj/fantasystation_obj/harvested_plants.dmi'
	icon_state = "grass"
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL
	campfire_fuel_value = 30 SECONDS
	/// Type of turf we place when used on another open turf
	var/turf/place_turf_type = /turf/open/floor/fantasy_organic

/obj/item/fantasy_cut_grass/examine(mob/user)
	. = ..()
	. += span_notice("Using this on <b>bare terrain</b> will make flooring.")
	return .

/obj/item/fantasy_cut_grass/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isturf(interacting_with))
		return NONE
	if(istype(interacting_with, /turf/open/floor))
		return NONE
	place_floor_mat(interacting_with, user)
	return ITEM_INTERACT_SUCCESS

/// Places the floor mat tile on the given turf if the do_after passes
/obj/item/fantasy_cut_grass/proc/place_floor_mat(turf/mat_target, mob/living/user)
	if(!do_after(user, 2 SECONDS, mat_target))
		return
	if(QDELETED(src))
		return
	mat_target.place_on_top(place_turf_type, flags = CHANGETURF_INHERIT_AIR)
	qdel(src)

/// Cattails

/obj/structure/flora/fantasy_regrowing/cattail
	name = "river reeds"
	desc = "Tall reeds with densely-packed clusters of seeds adorning the top."
	harvested_name = "growing river reeds"
	harvested_desc = "Some cut river reeds, in time they will grow to full size."
	icon_state = "cattail"
	base_icon_state = "cattail"
	product_types = list(/obj/item/fantasy_cut_cattail = 1)
	harvest_message_low = "You cut the river reeds, managing to collect only a little of it."
	harvest_message_med = "You cut the river reeds, managing to collect a fair amount of it."
	harvest_message_high = "You cut the river reeds, collecting almost all of it."
	harvest_icon_state = "cattail_cut"
	regrowth_time_low = 10 MINUTES
	regrowth_time_high = 20 MINUTES

/obj/structure/flora/fantasy_regrowing/cattail/atom_deconstruct(disassembled)
	new /obj/item/food/fantasy_grown/river_reed_root(drop_location())

/obj/structure/flora/fantasy_regrowing/cattail/ungrown
	spawns_harvested = TRUE

/// Cut cattails

/obj/item/fantasy_cut_cattail
	name = "cut river reeds"
	desc = "A pile of cut river reeds."
	icon = 'icons/obj/fantasystation_obj/harvested_plants.dmi'
	icon_state = "cattails"
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL
	/// Type of turf we place when used on another open turf
	var/turf/place_turf_type = /turf/open/floor/fantasy_organic/reed

/obj/item/fantasy_cut_cattail/examine(mob/user)
	. = ..()
	. += span_notice("Using this on <b>bare terrain</b> will make flooring.")
	return .

/obj/item/fantasy_cut_cattail/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isturf(interacting_with))
		return NONE
	if(!ismiscturf(interacting_with))
		return NONE
	place_floor_mat(interacting_with, user)
	return ITEM_INTERACT_SUCCESS

/// Places the floor mat tile on the given turf if the do_after passes
/obj/item/fantasy_cut_cattail/proc/place_floor_mat(turf/mat_target, mob/living/user)
	if(!do_after(user, 2 SECONDS, mat_target))
		return
	if(QDELETED(src))
		return
	mat_target.place_on_top(place_turf_type, flags = CHANGETURF_INHERIT_AIR)
	qdel(src)

/// Crafting recipes with river reeds

/datum/crafting_recipe/fantasystation/reed_backsket
	name = "reed pack-basket"
	desc = "A large basket made of river reeds that you can wear on your back."
	reqs = list(
		/obj/item/fantasy_cut_cattail = 5,
	)
	result = /obj/item/storage/backpack/fantasy
	time = 15 SECONDS
	recipe_completion_sound = 'sound/items/hammering_wood.ogg'
	category = CAT_EQUIPMENT

/// Muckroot

/obj/structure/flora/fantasy_regrowing/muckroot
	name = "muckroot sprout"
	desc = "A winding wood-like plant with edible roots, common in swamps."
	harvested_name = "muckroot shoots"
	harvested_desc = "Some pointed shoots with wood-like tips, these will eventually grow into a full muckroot sprout."
	icon = 'icons/obj/fantasystation_obj/plants.dmi'
	icon_state = "muckroot"
	base_icon_state = "muckroot"
	product_types = list(/obj/item/food/fantasy_grown/fantasy_muckroot = 1)
	harvest_message_low = "You dig up the muckroot, managing to collect only a little of the roots."
	harvest_message_med = "You dig up the muckroot, managing to collect a fair amount of the roots."
	harvest_message_high = "You dig up the muckroot, collecting almost all of the roots."
	harvest_verb = "dig"
	harvest_verb_suffix = "s up"
	harvest_icon_state = "muckroot_growing"
	knife_harvest = FALSE
	harvest_with_hands = TRUE
	delete_on_harvest = TRUE

/obj/structure/flora/fantasy_regrowing/muckroot/ungrown
	spawns_harvested = TRUE

/// Ratweed

/obj/structure/flora/fantasy_regrowing/ratweed
	name = "ratweed"
	desc = "A diminutive leafy green that grows in damp and shaded conditions, which tend to be where rats are also present, thus the name. \
		Both it's seeds and leaves are edible."
	harvested_name = "ratweed sprout"
	harvested_desc = "A still-growing stem of the ratweed plant."
	icon = 'icons/obj/fantasystation_obj/plants.dmi'
	icon_state = "rat_weed"
	base_icon_state = "rat_weed"
	harvest_icon_state = "rat_weed_growing"
	product_types = list(
		/obj/item/food/fantasy_grown/ratweed_leaf = 1,
		/obj/item/food/fantasy_grown/ratweed_seeds = 1,
	)
	harvest_amount_low = 3
	harvest_amount_high = 5
	harvest_message_low = "You pull up the ratweed."
	harvest_message_med = "You pull up the ratweed."
	harvest_message_high = "You pull up the ratweed."
	harvest_verb = "pull"
	harvest_verb_suffix = "s up"
	knife_harvest = FALSE
	harvest_with_hands = TRUE
	delete_on_harvest = TRUE

/obj/structure/flora/fantasy_regrowing/ratweed/ungrown
	spawns_harvested = TRUE

/// Groundnuts

/obj/structure/flora/fantasy_regrowing/groundnut
	name = "wetland groundnut"
	desc = "A plant common to wetlands that hangs low to the ground, producing edible nuts that make for good roasting."
	harvested_name = "harvested wetland groundnut"
	harvested_desc = "A plant common to wetlands that hangs low to the ground, producing edible nuts that make for good roasting. This one has recently been picked or is still growing."
	icon = 'icons/obj/fantasystation_obj/plants.dmi'
	icon_state = "groundnuts"
	base_icon_state = "groundnuts"
	harvest_icon_state = "groundnuts_growing"
	product_types = list(
		/obj/item/food/fantasy_grown/groundnut = 1,
	)
	harvest_amount_low = 2
	harvest_amount_high = 4
	harvest_message_low = "You pick some of the groundnuts."
	harvest_message_med = "You pick some of the groundnuts."
	harvest_message_high = "You pick some of the groundnuts."
	harvest_verb = "pick"
	harvest_verb_suffix = "s"
	knife_harvest = FALSE
	harvest_with_hands = TRUE
	delete_on_harvest = FALSE
	regrowth_time_low = 18 MINUTES
	regrowth_time_high = 25 MINUTES

/obj/structure/flora/fantasy_regrowing/groundnut/ungrown
	spawns_harvested = TRUE

/// Hideroot

/obj/structure/flora/fantasy_regrowing/hideroot
	name = "hideroot growth"
	desc = "A leafy plant with thick roots wrapped in a tough bark-like material, like a strong animal's hide."
	harvested_name = "hideroot sprout"
	harvested_desc = "A leafy plant with thick roots wrapped in a tough bark-like material, like a strong animal's hide. This one looks short and is likely still growing"
	icon = 'icons/obj/fantasystation_obj/plants.dmi'
	icon_state = "hideroot"
	base_icon_state = "hideroot"
	harvest_icon_state = "hideroot_growing"
	product_types = list(
		/obj/item/food/fantasy_grown/hideroot = 1,
	)
	harvest_message_low = "You pull up the hideroot."
	harvest_message_med = "You pull up the hideroot."
	harvest_message_high = "You pull up the hideroot."
	harvest_verb = "pull"
	harvest_verb_suffix = "s up"
	knife_harvest = FALSE
	harvest_with_hands = TRUE
	delete_on_harvest = TRUE

/obj/structure/flora/fantasy_regrowing/hideroot/ungrown
	spawns_harvested = TRUE
