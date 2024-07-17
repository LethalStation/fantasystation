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
		/datum/crafting_recipe/fantasystation/clay_jug,
		/datum/crafting_recipe/fantasystation/clay_vessel,
		/datum/crafting_recipe/fantasystation/clay_fermentor,
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
	desc = "Clay shaped into the form of a cooking pot, needs to be fired over a fire before use."
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

/// Adds the bakeable element? component? whichever it is (im not updating this comment ever)
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
	desc = "Clay shaped into the form of a bowl, needs to be fired over a fire before use."
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
	time = 5 SECONDS
	category = CAT_CONTAINERS

/// Crocks

/obj/item/fantasy_clay_unfired/crock
	name = "unfired crock"
	desc = "Clay shaped into the form of a crock, needs to be fired over a fire before use."
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
	time = 5 SECONDS
	category = CAT_CONTAINERS

/// Jugs or just bottles, I'm just calling them bottles

/obj/item/fantasy_clay_unfired/jug
	name = "unfired jug"
	desc = "Clay shaped into the form of a jug, needs to be fired over a fire before use."
	icon_state = "jug_unfired"
	w_class = WEIGHT_CLASS_NORMAL
	baking_result = /obj/item/reagent_containers/cup/bottle/clayware
	minimum_firing_time = 14 MINUTES
	maximum_firing_time = 20 MINUTES

/// Unfired jug crafting recipe

/datum/crafting_recipe/fantasystation/clay_jug
	name = "unfired jug"
	desc = "Molding clay into the shape of a jug, which will need to be fired over a campfire before use."
	reqs = list(
		/obj/item/fantasy_clay = 3,
	)
	result = /obj/item/fantasy_clay_unfired/jug
	time = 5 SECONDS
	category = CAT_CONTAINERS

/// Large storage vessels to act like chests

/obj/item/fantasy_clay_unfired/vessel
	name = "unfired storage vessel"
	desc = "Clay shaped into the form of a large storage vessel, needs to be fired over a fire before use."
	icon_state = "storage_unfired"
	w_class = WEIGHT_CLASS_HUGE
	baking_result = /obj/structure/fantasy_storage_pot
	minimum_firing_time = 20 MINUTES
	maximum_firing_time = 28 MINUTES
	slowdown = 1

/obj/item/fantasy_clay_unfired/vessel/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands = TRUE, force_unwielded = force, force_wielded = force)

/// Unfired storage vessel crafting recipe

/datum/crafting_recipe/fantasystation/clay_vessel
	name = "unfired storage vessel"
	desc = "Molding clay into the shape of a large storage vessel, which will need to be fired over a campfire before use."
	reqs = list(
		/obj/item/fantasy_clay = 5,
	)
	result = /obj/item/fantasy_clay_unfired/vessel
	time = 5 SECONDS
	category = CAT_CONTAINERS

/// Large vessel for brewing alcohol inside of

/obj/item/fantasy_clay_unfired/fermenter
	name = "unfired fermenting vessel"
	desc = "Clay shaped into the form of a large fermenting vessel, needs to be fired over a fire before use."
	icon_state = "barrel_unfired"
	w_class = WEIGHT_CLASS_HUGE
	baking_result = /obj/structure/fermenting_barrel_fantasy/fantasy_ceramic
	minimum_firing_time = 20 MINUTES
	maximum_firing_time = 28 MINUTES
	slowdown = 1

/obj/item/fantasy_clay_unfired/fermenter/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands = TRUE, force_unwielded = force, force_wielded = force)

/// Unfired fermenting vessel recipe

/datum/crafting_recipe/fantasystation/clay_fermentor
	name = "unfired fermenting vessel"
	desc = "Molding clay into the shape of a large fermenting vessel, which will need to be fired over a campfire before use."
	reqs = list(
		/obj/item/fantasy_clay = 5,
	)
	result = /obj/item/fantasy_clay_unfired/fermenter
	time = 5 SECONDS
	category = CAT_CONTAINERS

/// Mortar and pestle

/obj/item/fantasy_clay_unfired/mortar
	name = "unfired mortar"
	desc = "Clay shaped into the form of a mortar, needs to be fired over a fire before use."
	icon_state = "mortar_unfired"
	w_class = WEIGHT_CLASS_NORMAL
	baking_result = /obj/item/reagent_containers/cup/mortar/fantasy_ceramic
	minimum_firing_time = 12 MINUTES
	maximum_firing_time = 18 MINUTES

/obj/item/fantasy_clay_unfired/pestle
	name = "unfired pestle"
	desc = "Clay shaped into the form of a pestle, needs to be fired over a fire before use."
	icon_state = "pestle_unfired"
	w_class = WEIGHT_CLASS_SMALL
	baking_result = /obj/item/pestle/fantasy_ceramic
	minimum_firing_time = 10 MINUTES
	maximum_firing_time = 16 MINUTES

/// Mortar and pestle recipe

/datum/crafting_recipe/fantasystation/clay_mortar
	name = "unfired mortar"
	desc = "Molding clay into the shape of a mortar, which will need to be fired over a campfire before use."
	reqs = list(
		/obj/item/fantasy_clay = 3,
	)
	result = /obj/item/fantasy_clay_unfired/mortar
	time = 5 SECONDS
	category = CAT_TOOLS

/datum/crafting_recipe/fantasystation/clay_pestle
	name = "unfired pestle"
	desc = "Molding clay into the shape of a pestle, which will need to be fired over a campfire before use."
	reqs = list(
		/obj/item/fantasy_clay = 2,
	)
	result = /obj/item/fantasy_clay_unfired/pestle
	time = 5 SECONDS
	category = CAT_TOOLS

/// Bricks

/obj/item/fantasy_clay_unfired/brick
	name = "unfired clay brick"
	desc = "Clay shaped into the form of a brick, needs to be fired over a fire before use."
	icon_state = "brick_unfired"
	w_class = WEIGHT_CLASS_SMALL
	baking_result = /obj/item/stack/fantasy_bricks
	minimum_firing_time = 8 MINUTES
	maximum_firing_time = 12 MINUTES

/// Recipe for making bricks

/datum/crafting_recipe/fantasystation/clay_brick
	name = "unfired clay brick"
	desc = "Molding clay into the shape of a brick, which will need to be fired over a campfire before use."
	reqs = list(
		/obj/item/fantasy_clay = 1,
	)
	result = /obj/item/fantasy_clay_unfired/brick
	time = 0.5 SECONDS
	category = CAT_STRUCTURE
