/datum/job/dweller
	title = "Dweller"
	description = "I attacka you with a rock."
	faction = FACTION_STATION
	total_positions = -1
	spawn_positions = -1
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "DWELLER"

	outfit = /datum/outfit/dweller

	paycheck = PAYCHECK_ZERO

	liver_traits = list()

	display_order = JOB_DISPLAY_ORDER_ASSISTANT
	bounty_types = CIV_JOB_BASIC
	department_for_prefs = /datum/job_department/assistant
	departments_list = list(
		/datum/job_department/assistant,
	)

	family_heirlooms = list(/obj/item/vintage_tool_head/knife)

	rpg_title = "Peasant"
	job_flags = STATION_JOB_FLAGS

/datum/job/dweller/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	ADD_TRAIT(spawned, TRAIT_VIRUSIMMUNE, JOB_TRAIT)

/datum/outfit/dweller
	name = "Dweller"
