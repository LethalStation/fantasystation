GLOBAL_LIST_INIT(log_recipes, list(
	new/datum/stack_recipe("palisade", /obj/structure/railing/fantasy_palisade, 2, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_CHECK_DIRECTION | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("wall", /turf/closed/wall/fantasystation/log, 3, time = 2.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("firepit", /obj/structure/fantasy_campfire, 3, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
))

GLOBAL_LIST_INIT(swamp_log_recipes, list(
	new/datum/stack_recipe("palisade", /obj/structure/railing/fantasy_palisade/swamp, 2, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_CHECK_DIRECTION | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("wall", /turf/closed/wall/fantasystation/log/swamp, 3, time = 2.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("firepit", /obj/structure/fantasy_campfire/swamp, 3, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
))

/obj/item/stack/fantasy_logs
	name = "logs"
	singular_name = "log"
	desc = "The trunks of trees cut into workable segments."
	icon = 'icons/obj/fantasystation_obj/harvested_plants_tall.dmi'
	icon_state = "log"
	base_icon_state = "log"
	lefthand_file = 'icons/mob/fantasystation_onmobs/inhands/lefthand.dmi'
	righthand_file = 'icons/mob/fantasystation_onmobs/inhands/righthand.dmi'
	inhand_icon_state = "stick"
	merge_type = /obj/item/stack/fantasy_logs
	max_amount = 6
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_NORMAL
	force = 15
	throwforce = 10
	throw_speed = 5
	throw_range = 3
	campfire_fuel_value = 5 MINUTES

/obj/item/stack/fantasy_logs/Initialize(mapload, new_amount, merge, list/mat_override, mat_amt)
	. = ..()
	update_appearance()

/obj/item/stack/fantasy_logs/get_main_recipes()
	. = ..()
	. = GLOB.log_recipes

/obj/item/stack/fantasy_logs/update_icon_state()
	. = ..()
	icon_state = (amount == 1) ? "[base_icon_state]" : "[base_icon_state]_[min(amount, max_amount)]"

/// Swamp version

/obj/item/stack/fantasy_logs/swamp
	name = "swamp logs"
	singular_name = "swamp log"
	icon_state = "log_swamp"
	base_icon_state = "log_swamp"
	merge_type = /obj/item/stack/fantasy_logs/swamp

/obj/item/stack/fantasy_logs/swamp/get_main_recipes()
	. = ..()
	. = GLOB.swamp_log_recipes
