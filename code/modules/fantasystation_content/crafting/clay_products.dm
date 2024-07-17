/// Actual clay items once they have been fired

/// Cooking pot

/obj/item/reagent_containers/cup/soup_pot/clayware
	name = "ceramic cooking pot"
	desc = "A pot designed for making soups and other meals within."
	icon = 'icons/obj/fantasystation_obj/clay.dmi'
	icon_state = "pot"
	base_icon_state = "pot"
	lefthand_file = 'icons/mob/fantasystation_onmobs/inhands/lefthand.dmi'
	righthand_file = 'icons/mob/fantasystation_onmobs/inhands/righthand.dmi'
	inhand_icon_state = "clay"
	custom_materials = null
	resistance_flags = FIRE_PROOF

/obj/item/reagent_containers/cup/soup_pot/clayware/Initialize(mapload, vol)
	. = ..()
	AddElement(/datum/element/can_shatter, number_of_shards = 0)

/// Bowl

/obj/item/reagent_containers/cup/bowl/clayware
	name = "ceramic bowl"
	desc = "A simple bowl, used for holding liquid foods."
	icon = 'icons/obj/fantasystation_obj/clay.dmi'
	icon_state = "bowl"
	base_icon_state = "bowl"
	lefthand_file = 'icons/mob/fantasystation_onmobs/inhands/lefthand.dmi'
	righthand_file = 'icons/mob/fantasystation_onmobs/inhands/righthand.dmi'
	inhand_icon_state = "clay"
	custom_materials = null
	resistance_flags = FIRE_PROOF
	fill_icon_state = "fullbowl"
	fill_icon = 'icons/obj/fantasystation_obj/clay.dmi'

/obj/item/reagent_containers/cup/bowl/clayware/Initialize(mapload, vol)
	. = ..()
	AddElement(/datum/element/can_shatter, number_of_shards = 0)

/// Crock for storing soups and stews

/obj/item/reagent_containers/cup/bowl/clayware/crock
	name = "ceramic crock"
	desc = "A simple container with a lid for storing and transporting cooked soups and stews. Holds more than a bowl."
	icon_state = "crock"
	base_icon_state = "crock"
	fill_icon_state = "fullcrock"
	volume = (SOUP_SERVING_SIZE * 2) + 10
	/// If the lid is currently on the crock
	var/lid_on = TRUE
	/// The overlay for the lid of the crock
	var/mutable_appearance/lid_overlay

/obj/item/reagent_containers/cup/bowl/clayware/crock/Initialize(mapload)
	lid_overlay = mutable_appearance(icon, "[base_icon_state]_lid")
	. = ..()
	if(lid_on)
		spillable = FALSE
		update_appearance()

/obj/item/reagent_containers/cup/bowl/clayware/crock/update_overlays()
	. = ..()
	if(lid_on)
		. += lid_overlay

/obj/item/reagent_containers/cup/bowl/clayware/crock/examine(mob/user)
	. = ..()
	if(lid_on)
		. += span_notice("The lid is firmly sealed on. <b>Alt-Click</b> to remove the cap.")
	else
		. += span_notice("The lid has been taken off. <b>Alt-Click</b> to put a cap on.")

/obj/item/reagent_containers/cup/bowl/clayware/crock/click_alt(mob/user)
	if(lid_on)
		lid_on = FALSE
		spillable = TRUE
		to_chat(user, span_notice("You remove the lid from [src] with a satisfying pop."))
		playsound(loc, 'sound/effects/pop.ogg', 50, TRUE)
	else
		lid_on = TRUE
		spillable = FALSE
		to_chat(user, span_notice("You seal the lid onto [src]."))
	update_appearance()
	return CLICK_ACTION_SUCCESS

/obj/item/reagent_containers/cup/bowl/clayware/crock/is_refillable()
	if(lid_on)
		return FALSE
	return ..()

/obj/item/reagent_containers/cup/bowl/clayware/crock/is_drainable()
	if(lid_on)
		return FALSE
	return ..()

/obj/item/reagent_containers/cup/bowl/clayware/crock/attack(mob/target, mob/living/user, def_zone)
	if(!target)
		return
	if(lid_on && reagents.total_volume && istype(target))
		to_chat(user, span_warning("You must remove the lid before you can do that!"))
		return
	return ..()

/obj/item/reagent_containers/cup/bowl/clayware/crock/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	if(lid_on && (target.is_refillable() || target.is_drainable() || (reagents.total_volume && !user.combat_mode)))
		to_chat(user, span_warning("You must remove the lid before you can do that!"))
		return ITEM_INTERACT_BLOCKING
	return ..()

/// Ceramic bottle, works smilar to a bowl but with a bit more reagent storage, and also no overlay for what's in it

/obj/item/reagent_containers/cup/bottle/clayware
	name = "ceramic jug"
	desc = "More like a bottle, can hold a large amount of liquid within."
	icon = 'icons/obj/fantasystation_obj/clay.dmi'
	icon_state = "jug"
	base_icon_state = "jug"
	lefthand_file = 'icons/mob/fantasystation_onmobs/inhands/lefthand.dmi'
	righthand_file = 'icons/mob/fantasystation_onmobs/inhands/righthand.dmi'
	inhand_icon_state = "clay"
	fill_icon_thresholds = null
	custom_materials = null
	resistance_flags = FIRE_PROOF

/obj/item/reagent_containers/cup/bottle/clayware/Initialize(mapload, vol)
	. = ..()
	AddElement(/datum/element/can_shatter, number_of_shards = 0)

/// Storage vessel, holds items inside like a big box

/obj/structure/fantasy_storage_pot
	name = "ceramic storage vessel"
	desc = "A massive ceramic pot for storing stuff inside of. Has a handy lid to keep everything inside."
	icon = 'icons/obj/fantasystation_obj/clay.dmi'
	icon_state = "storage"
	base_icon_state = "storage"
	resistance_flags = FIRE_PROOF
	density = TRUE
	anchored = FALSE
	drag_slowdown = 1
	/// What storage datum do we use
	var/datum/storage/storage_datum_to_use = /datum/storage/fantasy_storage_pot
	/// If we should display a lid sprite
	var/display_lid_sprite = FALSE

/obj/structure/fantasy_storage_pot/Initialize(mapload)
	. = ..()
	create_storage(storage_type = storage_datum_to_use)
	AddElement(/datum/element/can_shatter, number_of_shards = 0)

/obj/structure/fantasy_storage_pot/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if(length(contents))
		icon_state = "[base_icon_state]_closed"
		update_appearance()

/obj/structure/fantasy_storage_pot/Exited(atom/movable/gone, direction)
	. = ..()
	if(!length(contents))
		icon_state = base_icon_state
		update_appearance()

/obj/structure/fantasy_storage_pot/attack_hand(mob/living/user)
	if(!user.can_perform_action(src, NEED_HANDS))
		return ..()
	atom_storage.open_storage(user)
	return TRUE

/datum/storage/fantasy_storage_pot
	max_slots = 9
	max_specific_storage = WEIGHT_CLASS_GIGANTIC
	max_total_storage = WEIGHT_CLASS_BULKY * 6
	numerical_stacking = FALSE
	rustle_sound = TRUE
	screen_max_columns = 3
	/// What sound this makes when the storage is opened
	var/opening_sound = 'sound/fantasystation/structure/ceramic_open.wav'

/datum/storage/fantasy_storage_pot/open_storage(mob/to_show)
	. = ..()
	if(!.)
		return
	playsound(parent, opening_sound, 50, TRUE)

/// Vessel for brewing beer inside of

/obj/structure/fermenting_barrel_fantasy/fantasy_ceramic
	name = "ceramic fermenting vessel"
	desc = "A ceramic vessel made for brewing alcohols inside of. Has a plug for the tap at the base, don't lose it!"
	icon = 'icons/obj/fantasystation_obj/clay.dmi'
	icon_state = "barrel"
	base_icon_state = "barrel"
	obj_flags = CAN_BE_HIT
	resistance_flags = FIRE_PROOF
	lid_open_sound = 'sound/fantasystation/structure/ceramic_open.wav'
	lid_close_sound = 'sound/fantasystation/structure/ceramic_open.wav'
	drag_slowdown = 1

/obj/structure/fermenting_barrel_fantasy/fantasy_ceramic/Initialize(mapload, vol)
	. = ..()
	AddElement(/datum/element/can_shatter, number_of_shards = 0)

/obj/structure/fermenting_barrel_fantasy/fantasy_ceramic/update_overlays()
	. = ..()
	if((reagents.total_volume <= 0) || !open)
		return
	var/mutable_appearance/filled_overlay = mutable_appearance(icon, "[base_icon_state]_filled")
	filled_overlay.color = mix_color_from_reagents(reagents.reagent_list)
	. += filled_overlay

/// Mortar and pestle but ceramic

/obj/item/reagent_containers/cup/mortar/fantasy_ceramic
	name = "ceramic mortar"
	desc = "A bowl special-made for use with a matching pestle to grind or juice things."
	icon = 'icons/obj/fantasystation_obj/clay.dmi'
	icon_state = "mortar"
	lefthand_file = 'icons/mob/fantasystation_onmobs/inhands/lefthand.dmi'
	righthand_file = 'icons/mob/fantasystation_onmobs/inhands/righthand.dmi'
	inhand_icon_state = "clay"
	possible_transfer_amounts = list(5, 10, 15, 20, 25, 30, 50)
	volume = 50
	custom_materials = null
	resistance_flags = FIRE_PROOF

/obj/item/reagent_containers/cup/mortar/fantasy_ceramic/Initialize(mapload, vol)
	. = ..()
	AddElement(/datum/element/can_shatter, number_of_shards = 0)

/obj/item/pestle/fantasy_ceramic
	name = "ceramic pestle"
	desc = "A simple ceramic tool for crushing things when combined with a matching mortar."
	icon = 'icons/obj/fantasystation_obj/clay.dmi'
	icon_state = "pestle"
	lefthand_file = 'icons/mob/fantasystation_onmobs/inhands/lefthand.dmi'
	righthand_file = 'icons/mob/fantasystation_onmobs/inhands/righthand.dmi'
	inhand_icon_state = "stick"
	resistance_flags = FIRE_PROOF

/obj/item/pestle/fantasy_ceramic/Initialize(mapload, vol)
	. = ..()
	AddElement(/datum/element/can_shatter, number_of_shards = 0)
