/obj/structure/flora/fantasy_regrowing
	name = "tall grass"
	desc = "Tall grass, can be cut and used for many things."
	harvested_name = "growing grass"
	harvested_desc = "Some cut grass, you feel like it used to stand much taller."
	icon = 'icons/obj/fantasystation_obj/tall_plants.dmi'
	icon_state = "tall_grass"
	base_icon_state = "tall_grass"
	gender = PLURAL
	layer = MOB_LAYER
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
	new /obj/item/food/grown/river_reed_root(drop_location())

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

/// Muckroot

/obj/structure/flora/fantasy_regrowing/muckroot
	name = "muckroot sprout"
	desc = "A winding wood-like plant with edible roots, common in swamps."
	harvested_name = "muckroot shoots"
	harvested_desc = "Some pointed shoots with wood-like tips, these will eventually grow into a full muckroot sprout."
	icon = 'icons/obj/fantasystation_obj/plants.dmi'
	icon_state = "muckroot"
	base_icon_state = "muckroot"
	product_types = list(/obj/item/food/grown/fantasy_muckroot = 1)
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
