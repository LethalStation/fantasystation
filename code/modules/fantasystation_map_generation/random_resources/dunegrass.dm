/obj/structure/flora/dunegrass
	name = "dunegrass"
	desc = "A tall-growing species of grass, one of the few plants that can actually grow in this environment."
	icon = 'icons/obj/fantasystation_obj/dunegrass.dmi'
	icon_state = "dunegrass-255"
	base_icon_state = "dunegrass"
	layer = ABOVE_MOB_LAYER
	product_types = list(
		/obj/item/dunegrass,
	)
	harvest_with_hands = TRUE
	harvest_amount_high = 3
	harvest_amount_low = 1
	harvest_verb = "cut"
	opacity = TRUE
	can_uproot = FALSE
	delete_on_harvest = TRUE
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_HEDGE_FLUFF
	canSmoothWith = SMOOTH_GROUP_HEDGE_FLUFF

/obj/structure/flora/dunegrass/Initialize(mapload)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)
	AddComponent(/datum/component/seethrough, get_seethrough_map())

///Return a see_through_map, examples in seethrough.dm
/obj/structure/flora/dunegrass/proc/get_seethrough_map()
	return SEE_THROUGH_MAP_DEFAULT_TWO_TALL

/obj/structure/flora/dunegrass/proc/on_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	if(!ismob(AM))
		return
	Shake(1, 1, 1 SECONDS)

// Harvestable dunegrass item

/obj/item/dunegrass
	name = "cut dunegrass"
	desc = "A clump of cut dunegrass, ready to be used for all sorts of activities."
	icon = 'icons/obj/fantasystation_obj/harvested_plants.dmi'
	icon_state = "dunegrass_clump"
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL
