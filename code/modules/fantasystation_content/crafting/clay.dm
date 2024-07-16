/// Clay that can be dug up from clay turfs in the ground

/obj/item/fantasy_clay
	name = "fire clay"
	desc = "Some fire clay dug up from the floor, can be made into a variety of useful pottery implements."
	icon = 'icons/obj/fantasystation_obj/clay.dmi'
	icon_state = "clay"
	lefthand_file = 'icons/mob/fantasystation_onmobs/inhands/lefthand.dmi'
	righthand_file = 'icons/mob/fantasystation_onmobs/inhands/righthand.dmi'
	inhand_icon_state = "rawclay"
	w_class = WEIGHT_CLASS_NORMAL
	/// What are the slapcraft recipes for this item?
	var/list/slapcraft_recipe_list = list(
		/datum/crafting_recipe/fantasystation/clay_cooking_pot,
		/datum/crafting_recipe/fantasystation/clay_bowl,
		/datum/crafting_recipe/fantasystation/clay_crock,
	)

/obj/item/fantasy_clay/Initialize(mapload)
	. = ..()
	if(length(slapcraft_recipe_list))
		AddElement(
			/datum/element/slapcrafting,\
			slapcraft_recipes = slapcraft_recipe_list,\
		)

/// Crafting recipe and related items for slapcraft stuff involving clay

/// Clay pots and unfired clay thing basetype item

/obj/item/fantasy_clay_unfired
	name = "unfired cooking pot"
	desc = "Clay shaped into the form of a cooking pot, needs to be fired in an oven before use."
	icon = 'icons/obj/fantasystation_obj/clay.dmi'
	icon_state = "pot_unfired"
	lefthand_file = 'icons/mob/fantasystation_onmobs/inhands/lefthand.dmi'
	righthand_file = 'icons/mob/fantasystation_onmobs/inhands/righthand.dmi'
	inhand_icon_state = "rawclay"
	w_class = WEIGHT_CLASS_BULKY
	/// What does this turn into when we cook it to fire it
	var/obj/baking_result = /obj/item/reagent_containers/cup/soup_pot/clayware
	/// Firing time minimum
	var/minimum_firing_time = 16 MINUTES
	/// Firing time maximum
	var/maximum_firing_time = 22 MINUTES

/obj/item/fantasy_clay_unfired/Initialize(mapload)
	. = ..()
	add_baking_recipe()

/obj/item/fantasy_clay_unfired/examine(mob/user)
	. = ..()
	. += span_notice("Earthenware needs to be fired on a <b>campfire</b> for an extraordinarily long amount of time.")
	. += span_notice("This piece will likely take between [DisplayTimeText(minimum_firing_time)] and [DisplayTimeText(maximum_firing_time)]")

/// Adds the bakeable element? compoonent? whichever it is (im not updating this comment ever)
/obj/item/fantasy_clay_unfired/proc/add_baking_recipe()
	AddComponent(/datum/component/grillable, baking_result, rand(minimum_firing_time, maximum_firing_time), TRUE, TRUE)

/// Unfired clay pot crafting recipe

/datum/crafting_recipe/fantasystation/clay_cooking_pot
	name = "unfired cooking pot"
	desc = "Molding clay into the shape of a cooking pot, which will need to be fired over a campfire before use."
	reqs = list(
		/obj/item/fantasy_clay = 3,
	)
	result = /obj/item/fantasy_clay_unfired
	time = 5 SECONDS
	category = CAT_CONTAINERS

/// Bowls

/obj/item/fantasy_clay_unfired/bowl
	name = "unfired bowl"
	desc = "Clay shaped into the form of a bowl, needs to be fired in an oven before use."
	icon_state = "bowl_unfired"
	w_class = WEIGHT_CLASS_NORMAL
	baking_result = /obj/item/reagent_containers/cup/bowl/clayware
	minimum_firing_time = 12 MINUTES
	maximum_firing_time = 18 MINUTES

/// Unfired bowl crafting recipe

/datum/crafting_recipe/fantasystation/clay_bowl
	name = "unfired bowl"
	desc = "Molding clay into the shape of a bowl, which will need to be fired over a campfire before use."
	reqs = list(
		/obj/item/fantasy_clay = 2,
	)
	result = /obj/item/fantasy_clay_unfired/bowl
	result_amount = 2
	time = 5 SECONDS
	category = CAT_CONTAINERS

/// Crocks

/obj/item/fantasy_clay_unfired/crock
	name = "unfired crock"
	desc = "Clay shaped into the form of a crock, needs to be fired in an oven before use."
	icon_state = "crock_unfired"
	w_class = WEIGHT_CLASS_NORMAL
	baking_result = /obj/item/reagent_containers/cup/bowl/clayware/crock
	minimum_firing_time = 12 MINUTES
	maximum_firing_time = 18 MINUTES

/// Unfired crock crafting recipe

/datum/crafting_recipe/fantasystation/clay_crock
	name = "unfired crock"
	desc = "Molding clay into the shape of a crock, which will need to be fired over a campfire before use."
	reqs = list(
		/obj/item/fantasy_clay = 2,
	)
	result = /obj/item/fantasy_clay_unfired/crock
	result_amount = 2
	time = 5 SECONDS
	category = CAT_CONTAINERS

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
	fill_icon_state = "fullbowl"
	fill_icon = 'icons/obj/fantasystation_obj/clay.dmi'

/obj/item/reagent_containers/cup/bowl/clayware/Initialize(mapload, vol)
	. = ..()
	AddElement(/datum/element/can_shatter, number_of_shards = 0)

/// Crock for transporting food around

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
