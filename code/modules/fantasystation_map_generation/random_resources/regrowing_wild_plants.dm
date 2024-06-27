/obj/structure/flora/fantasy_regrowing
	name = "tall grass"
	desc = "Tall grass, can be cut and used for many things."
	icon = 'icons/obj/fantasystation_obj/tall_plants.dmi'
	icon_state = "tall_grass"
	base_icon_state = "tall_grass"
	gender = PLURAL
	layer = PROJECTILE_HIT_THRESHHOLD_LAYER //sporangiums up don't shoot
	product_types = list(/obj/item/food/grown/grass = 1)
	harvest_amount_low = 1
	harvest_amount_high = 3
	harvest_with_hands = TRUE
	harvested_name = "shortened mushrooms"
	harvested_desc = "Some quickly regrowing mushrooms, formerly known to be quite large."
	harvest_message_low = "You pick a mushroom, but fail to collect many shavings from its cap."
	harvest_message_med = "You pick a mushroom, carefully collecting the shavings from its cap."
	harvest_message_high = "You harvest and collect shavings from several mushroom caps."
	harvest_message_true_thresholds = TRUE
	harvest_verb = "cut"
	flora_flags = FLORA_HERBAL
	resistance_flags = FLAMMABLE
	var/harvest_icon_state = "grass_cut"

/obj/structure/flora/fantasy_regrowing/harvest(user, product_amount_multiplier)
	if(!..())
		return FALSE
	icon_state = harvest_icon_state
	update_appearance()
	return TRUE

/obj/structure/flora/fantasy_regrowing/regrow()
	..()
	icon_state = base_icon_state

/// Cut grass

/obj/item/dunegrass
	name = "cut grass"
	desc = "A pile of cut grass."
	icon = 'icons/obj/fantasystation_obj/harvested_plants.dmi'
	icon_state = "grass"
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL
