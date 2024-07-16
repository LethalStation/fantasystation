/// Wooden sticks that spawn around and come from strees when cut

/obj/item/vintage_stick
	name = "stick"
	desc = "Now all you need is some stones, then you can get to breaking some real bones."
	icon = 'icons/obj/fantasystation_obj/harvested_plants.dmi'
	icon_state = "stick_1"
	base_icon_state = "stick"
	lefthand_file = 'icons/mob/fantasystation_onmobs/inhands/lefthand.dmi'
	righthand_file = 'icons/mob/fantasystation_onmobs/inhands/righthand.dmi'
	inhand_icon_state = "stick"
	w_class = WEIGHT_CLASS_NORMAL
	force = 15
	throwforce = 10
	resistance_flags = FLAMMABLE
	campfire_fuel_value = 30 SECONDS
	/// How many variations of sprite does this have?
	var/icon_variations = 2
	/// What are the slapcraft recipes for this item?
	var/list/slapcraft_recipe_list = list(
		/datum/crafting_recipe/fantasystation/stick_firestarter,
	)

/obj/item/vintage_stick/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state]_[rand(1, icon_variations)]"
	if(length(slapcraft_recipe_list))
		AddElement(
			/datum/element/slapcrafting,\
			slapcraft_recipes = slapcraft_recipe_list,\
		)

/// Crafting recipe for slapcraft stuff involving sticks

/datum/crafting_recipe/fantasystation/stick_firestarter
	name = "firestarter"
	desc = "Rubbing sticks together quite a lot makes them hot enough to start fires in the right conditions."
	reqs = list(
		/obj/item/vintage_stick = 2,
		/obj/item/fantasy_cut_grass = 1,
	)
	result = /obj/item/fantasy_firestarter
	time = 5 SECONDS
	recipe_completion_sound = 'sound/items/hammering_wood.ogg'
	category = CAT_TOOLS

/// Stick recipes that aren't slapcraft

/datum/crafting_recipe/fantasystation/stick_backsket
	name = "stick pack-basket"
	desc = "A large basket made of woven sticks that you can wear on your back."
	reqs = list(
		/obj/item/vintage_stick = 9,
	)
	result = /obj/item/storage/backpack/fantasy/sticks
	time = 15 SECONDS
	recipe_completion_sound = 'sound/items/hammering_wood.ogg'
	category = CAT_EQUIPMENT
