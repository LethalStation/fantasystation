/obj/structure/flora/fantasy_regrowing
	name = "tall grass"
	desc = "Tall grass, can be cut and used for many things."
	harvested_name = "cut grass"
	harvested_desc = "Some cut grass, you feel like it used to stand much taller."
	icon = 'icons/obj/fantasystation_obj/tall_plants.dmi'
	icon_state = "tall_grass"
	base_icon_state = "tall_grass"
	gender = PLURAL
	layer = PROJECTILE_HIT_THRESHHOLD_LAYER
	product_types = list(/obj/item/fantasy_cut_grass = 1)
	harvest_amount_low = 1
	harvest_amount_high = 3
	harvest_with_hands = TRUE
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
		if((flora_flags & FLORA_WOODEN) && (harvesting_item.tool_behaviour == TOOL_SAW))
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
