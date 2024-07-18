GLOBAL_LIST_INIT(clay_brick_recipes, list(
	new/datum/stack_recipe("wall", /turf/closed/wall/fantasystation/clay_brick, 2, time = 2.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
))

/obj/item/stack/fantasy_bricks
	name = "ceramic bricks"
	singular_name = "ceramic brick"
	desc = "Bricks made of fired clay."
	icon = 'icons/obj/fantasystation_obj/clay.dmi'
	icon_state = "brick"
	base_icon_state = "brick"
	lefthand_file = 'icons/mob/fantasystation_onmobs/inhands/lefthand.dmi'
	righthand_file = 'icons/mob/fantasystation_onmobs/inhands/righthand.dmi'
	inhand_icon_state = "clay"
	merge_type = /obj/item/stack/fantasy_bricks
	max_amount = 6
	resistance_flags = FIRE_PROOF
	w_class = WEIGHT_CLASS_NORMAL
	force = 15
	throwforce = 10
	throw_speed = 5
	throw_range = 3
	/// Type of turf we place when used on another open turf
	var/turf/place_turf_type = /turf/open/floor/fantasy_brick

/obj/item/stack/fantasy_bricks/Initialize(mapload, new_amount, merge, list/mat_override, mat_amt)
	. = ..()
	update_appearance()

/obj/item/stack/fantasy_bricks/get_main_recipes()
	. = ..()
	. = GLOB.clay_brick_recipes

/obj/item/stack/fantasy_bricks/update_icon_state()
	. = ..()
	icon_state = (amount == 1) ? "[base_icon_state]" : "[base_icon_state]_[min(amount, max_amount)]"

/obj/item/stack/fantasy_bricks/examine(mob/user)
	. = ..()
	. += span_notice("Using this on <b>bare terrain</b> will make flooring.")
	return .

/obj/item/stack/fantasy_bricks/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isturf(interacting_with))
		return NONE
	if(istype(interacting_with, /turf/open/floor))
		return NONE
	place_floor_mat(interacting_with, user)
	return ITEM_INTERACT_SUCCESS

/// Places the floor mat tile on the given turf if the do_after passes
/obj/item/stack/fantasy_bricks/proc/place_floor_mat(turf/mat_target, mob/living/user)
	if(!do_after(user, 2 SECONDS, mat_target))
		return
	if(QDELETED(src))
		return
	mat_target.place_on_top(place_turf_type, flags = CHANGETURF_INHERIT_AIR)
	use(1)
