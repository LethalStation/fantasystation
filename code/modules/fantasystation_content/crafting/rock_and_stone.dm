/// Chunks of stone that spawn around the world

/obj/item/vintage_stone
	name = "rock"
	desc = "I attacka you with a rock."
	icon = 'icons/obj/fantasystation_obj/rocks.dmi'
	icon_state = "rock_1"
	base_icon_state = "rock"
	lefthand_file = 'icons/mob/fantasystation_onmobs/inhands/lefthand.dmi'
	righthand_file = 'icons/mob/fantasystation_onmobs/inhands/righthand.dmi'
	inhand_icon_state = "stone"
	w_class = WEIGHT_CLASS_NORMAL
	force = 15
	throwforce = 10
	/// How many variations of sprite does this have?
	var/icon_variations = 3
	/// What are the slapcraft recipes for this chunk of stone?
	var/list/slapcraft_recipe_list = list(
		/datum/crafting_recipe/fantasystation/stone_knife_head,
		/datum/crafting_recipe/fantasystation/stone_axe_head,
		/datum/crafting_recipe/fantasystation/stone_spear_head,
	)

/obj/item/vintage_stone/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state]_[rand(1, icon_variations)]"
	if(length(slapcraft_recipe_list))
		AddElement(
			/datum/element/slapcrafting,\
			slapcraft_recipes = slapcraft_recipe_list,\
		)

/obj/item/vintage_stone/flint
	name = "flint"
	desc = "The cooler rock."
	icon_state = "flint_1"
	base_icon_state = "flint"
	inhand_icon_state = "flint"
	slapcraft_recipe_list = list(
		/datum/crafting_recipe/fantasystation/stone_knife_head/flint,
		/datum/crafting_recipe/fantasystation/stone_axe_head/flint,
		/datum/crafting_recipe/fantasystation/stone_spear_head/flint,
	)

/// Crafting recipes for chunks of stone

/datum/crafting_recipe/fantasystation/stone_knife_head
	name = "stone knife blade"
	desc = "Hit rocks together until you get something vaguely shaped like a knife."
	reqs = list(
		/obj/item/vintage_stone = 2,
	)
	blacklist = list(
		/obj/item/vintage_stone/flint,
	)
	result = /obj/item/vintage_tool_head/knife
	time = 5 SECONDS
	recipe_completion_sound = 'sound/effects/break_stone.ogg'
	category = CAT_TOOLS

/datum/crafting_recipe/fantasystation/stone_knife_head/flint
	name = "flint knife blade"
	reqs = list(
		/obj/item/vintage_stone/flint = 2,
	)
	blacklist = list()
	result = /obj/item/vintage_tool_head/knife/flint

/datum/crafting_recipe/fantasystation/stone_axe_head
	name = "stone axe head"
	desc = "Hit rocks together until you get something vaguely shaped like an axe."
	reqs = list(
		/obj/item/vintage_stone = 2,
	)
	blacklist = list(
		/obj/item/vintage_stone/flint,
	)
	result = /obj/item/vintage_tool_head/axe
	time = 5 SECONDS
	recipe_completion_sound = 'sound/effects/break_stone.ogg'
	category = CAT_TOOLS

/datum/crafting_recipe/fantasystation/stone_axe_head/flint
	name = "flint axe head"
	reqs = list(
		/obj/item/vintage_stone/flint = 2,
	)
	blacklist = list()
	result = /obj/item/vintage_tool_head/axe/flint

/datum/crafting_recipe/fantasystation/stone_spear_head
	name = "stone spear head"
	desc = "Hit rocks together until you get something vaguely shaped like the tip of a spear."
	reqs = list(
		/obj/item/vintage_stone = 2,
	)
	blacklist = list(
		/obj/item/vintage_stone/flint,
	)
	result = /obj/item/vintage_tool_head/knife/spear
	time = 5 SECONDS
	recipe_completion_sound = 'sound/effects/break_stone.ogg'
	category = CAT_WEAPON_MELEE

/datum/crafting_recipe/fantasystation/stone_spear_head/flint
	name = "flint spear head"
	reqs = list(
		/obj/item/vintage_stone/flint = 2,
	)
	blacklist = list()
	result = /obj/item/vintage_tool_head/knife/flint/spear

/// Tool heads made of stone and flint

/obj/item/vintage_tool_head
	name = "debug tool head"
	desc = "The head of some form of tool, you probably shouldnt be seeing this."
	icon = 'icons/obj/fantasystation_obj/tools.dmi'
	icon_state = "stone_knifehead"
	lefthand_file = 'icons/mob/fantasystation_onmobs/inhands/lefthand.dmi'
	righthand_file = 'icons/mob/fantasystation_onmobs/inhands/righthand.dmi'
	inhand_icon_state = "stone_knife"
	worn_icon = 'icons/mob/fantasystation_onmobs/worn_items/worn.dmi'
	worn_icon_state = "stone_knife"
	/// What are the slapcraft recipes for this chunk of stone?
	var/list/slapcraft_recipe_list = list()

/obj/item/vintage_tool_head/Initialize(mapload)
	. = ..()
	if(length(slapcraft_recipe_list))
		AddElement(
			/datum/element/slapcrafting,\
			slapcraft_recipes = slapcraft_recipe_list,\
		)

// Knife heads

/obj/item/vintage_tool_head/knife
	name = "stone knife blade"
	desc = "The blade of a knife, missing a handle. Could be used as a knife regardless, but it may be uncomfortable."
	icon_state = "stone_knifehead"
	inhand_icon_state = "stone_knife"
	worn_icon_state = "stone_knife"
	w_class = WEIGHT_CLASS_SMALL
	force = 10
	throwforce = 15
	sharpness = SHARP_EDGED
	tool_behaviour = TOOL_KNIFE
	toolspeed = 2
	slapcraft_recipe_list = list(
		/datum/crafting_recipe/fantasystation/stone_knife,
	)

/obj/item/vintage_tool_head/knife/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering)

/obj/item/vintage_tool_head/knife/spear
	name = "stone spear head"
	desc = "The head of a spear, missing the shaft to actually make it anything more than a glorified knife."
	icon_state = "stone_spearhead"
	slapcraft_recipe_list = list(
		/datum/crafting_recipe/fantasystation/stone_spear,
	)

/obj/item/vintage_tool_head/knife/flint
	name = "flint knife blade"
	icon_state = "flint_knifehead"
	inhand_icon_state = "flint_knife"
	worn_icon = "flint_knife"
	force = 12
	throwforce = 17
	toolspeed = 1.75
	slapcraft_recipe_list = list(
		/datum/crafting_recipe/fantasystation/stone_knife/flint,
	)

/obj/item/vintage_tool_head/knife/flint/spear
	name = "flint spear head"
	desc = "The head of a spear, missing the shaft to actually make it anything more than a glorified knife."
	icon_state = "flint_spearhead"
	slapcraft_recipe_list = list(
		/datum/crafting_recipe/fantasystation/stone_spear/flint,
	)

/// Axe heads

/obj/item/vintage_tool_head/axe
	name = "stone axe head"
	desc = "The blade of a knife, missing a handle. Could be used as a knife regardless, but it may be uncomfortable."
	icon_state = "stone_axehead"
	inhand_icon_state = "stone_knife"
	worn_icon_state = "stone_knife"
	w_class = WEIGHT_CLASS_NORMAL
	force = 15
	throwforce = 10
	sharpness = SHARP_EDGED
	tool_behaviour = TOOL_AXE
	toolspeed = 2
	slapcraft_recipe_list = list(
		/datum/crafting_recipe/fantasystation/stone_axe,
	)

/obj/item/vintage_tool_head/axe/flint
	name = "flint axe head"
	icon_state = "flint_axehead"
	inhand_icon_state = "flint_knife"
	worn_icon = "flint_knife"
	force = 17
	toolspeed = 1.75
	slapcraft_recipe_list = list(
		/datum/crafting_recipe/fantasystation/stone_axe/flint,
	)

/// Crafting recipes for stone tool heads

/datum/crafting_recipe/fantasystation/stone_knife
	name = "stone knife"
	desc = "Tie your bashed rock to a stick to make a pretty workable cutting tool."
	reqs = list(
		/obj/item/vintage_tool_head/knife = 1,
		/obj/item/vintage_stick = 1,
	)
	blacklist = list(
		/obj/item/vintage_tool_head/knife/flint,
	)
	result = /obj/item/fantasy_knife
	time = 5 SECONDS
	recipe_completion_sound = 'sound/items/hammering_wood.ogg'
	category = CAT_TOOLS

/datum/crafting_recipe/fantasystation/stone_knife/flint
	name = "flint knife"
	reqs = list(
		/obj/item/vintage_tool_head/knife/flint = 1,
		/obj/item/vintage_stick = 1,
	)
	blacklist = list()
	result = /obj/item/fantasy_knife/flint

/datum/crafting_recipe/fantasystation/stone_axe
	name = "stone axe"
	desc = "Tie your bashed rock to a stick to make a pretty workable axe."
	reqs = list(
		/obj/item/vintage_tool_head/axe = 1,
		/obj/item/vintage_stick = 1,
	)
	blacklist = list(
		/obj/item/vintage_tool_head/axe/flint,
	)
	result = /obj/item/fantasy_axe
	time = 5 SECONDS
	recipe_completion_sound = 'sound/items/hammering_wood.ogg'
	category = CAT_TOOLS

/datum/crafting_recipe/fantasystation/stone_axe/flint
	name = "flint axe"
	reqs = list(
		/obj/item/vintage_tool_head/axe/flint = 1,
		/obj/item/vintage_stick = 1,
	)
	blacklist = list()
	result = /obj/item/fantasy_axe/flint

/datum/crafting_recipe/fantasystation/stone_spear
	name = "stone spear"
	desc = "Tie your bashed rock to a long stick to make a pretty workable poking tool."
	reqs = list(
		/obj/item/vintage_tool_head/knife/spear = 1,
		/obj/item/vintage_stick = 1,
	)
	blacklist = list()
	result = /obj/item/fantasy_spear
	time = 5 SECONDS
	recipe_completion_sound = 'sound/items/hammering_wood.ogg'
	category = CAT_WEAPON_MELEE

/datum/crafting_recipe/fantasystation/stone_spear/flint
	name = "flint spear"
	reqs = list(
		/obj/item/vintage_tool_head/knife/flint/spear = 1,
		/obj/item/vintage_stick = 1,
	)
	blacklist = list()
	result = /obj/item/fantasy_spear/flint
