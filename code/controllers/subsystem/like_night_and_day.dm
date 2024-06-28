SUBSYSTEM_DEF(daynight)
	name = "Daynight"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_NIGHT_AND_DAY
	runlevels = RUNLEVELS_DEFAULT

	/// List of all areas we check for in the day/night cycle
	var/list/areas_influenced = list(
		/area/vintage/surface_generator,
		/area/vintage/surface_generator/swamp,
	)
	/// Color to use during day
	var/daytime_color = "#FFFFFF"
	/// Daytime alpha
	var/daytime_alpha = 255
	/// How long daytime lasts
	var/daytime_duration = 15 MINUTES
	/// Color to use transitioning from or to evening/morning
	var/day_transition_color = "#f6cd26"
	/// Alpha to use during transition
	var/day_transition_alpha = 200
	/// How long day transition lasts
	var/day_transition_duration = 5 MINUTES
	/// Color to use during evening/morning
	var/golden_hour_color = "#ee243d"
	/// Golden hour alpha
	var/golden_hour_alpha = 125
	/// How long golden (red) hour lasts
	var/golden_hour_duration = 5 MINUTES
	/// Color to use when reaching into night
	var/night_color = "#755f9c"
	/// Alpha for night time
	var/night_alpha = 50
	/// How long night lasts
	var/night_duration = 10 MINUTES

/datum/controller/subsystem/daynight/Initialize()
	addtimer(CALLBACK(src, PROC_REF(start_afternoon_transition)), daytime_duration)
	return SS_INIT_SUCCESS

/// Gets the areas the controller will need to edit
/datum/controller/subsystem/daynight/proc/get_areas_to_edit()
	var/list/areas_to_edit = list()
	for(var/area_to_check in areas_influenced)
		areas_to_edit += GLOB.areas_by_type[area_to_check]
	return areas_to_edit

/datum/controller/subsystem/daynight/proc/start_animation(color_to_trans, alpha_to_trans, time_to_trans)
	var/list/areas_to_transition = get_areas_to_edit()
	for(var/area/transition_area in areas_to_transition)
		animate(transition_area, transition_area.base_lighting_color = color_to_trans, transition_area.base_lighting_alpha = alpha_to_trans, time = time_to_trans)

/// Starts the transition to afternoon
/datum/controller/subsystem/daynight/proc/start_afternoon_transition()
	start_animation(day_transition_color,day_transition_alpha, day_transition_duration)
	addtimer(CALLBACK(src, PROC_REF(start_afternoon_golden_hour)), day_transition_duration + 10 SECONDS)

/// Starts the transition to afternoon golden hour
/datum/controller/subsystem/daynight/proc/start_afternoon_golden_hour()
	start_animation(golden_hour_color, golden_hour_alpha, golden_hour_duration)
	addtimer(CALLBACK(src, PROC_REF(start_end_of_day)), golden_hour_duration + 10 SECONDS)

/// Starts the transition to the end of the day
/datum/controller/subsystem/daynight/proc/start_end_of_day()
	start_animation(night_color, night_alpha, night_duration)
	addtimer(CALLBACK(src, PROC_REF(start_morning_golden_hour)), night_duration + 10 SECONDS)

/// Starts the transition to early morning
/datum/controller/subsystem/daynight/proc/start_morning_golden_hour()
	start_animation(golden_hour_color, golden_hour_alpha, golden_hour_duration)
	addtimer(CALLBACK(src, PROC_REF(start_morning_transition)), golden_hour_duration + 10 SECONDS)

/// Starts the transition to morning
/datum/controller/subsystem/daynight/proc/start_morning_transition()
	start_animation(day_transition_color, day_transition_alpha, day_transition_duration)
	addtimer(CALLBACK(src, PROC_REF(start_mid_day)), day_transition_duration + 10 SECONDS)

/// Starts mid-day
/datum/controller/subsystem/daynight/proc/start_mid_day()
	start_animation(daytime_color, daytime_alpha, daytime_duration / 3)
	addtimer(CALLBACK(src, PROC_REF(start_afternoon_transition)), daytime_duration)
