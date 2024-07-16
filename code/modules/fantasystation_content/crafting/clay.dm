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

/// Actual clay items once they have been fired
/obj/item/reagent_containers/cup/soup_pot/clayware
	name = "cooking pot"
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
