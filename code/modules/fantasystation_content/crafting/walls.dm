/turf/closed/wall/fantasystation
	name = "wall"
	desc = "A huge chunk of { SPACE INTENTIONALLY LEFT BLANK } used to separate rooms."
	icon = 'icons/obj/fantasystation_obj/walls/swamp_log.dmi'
	icon_state = "swamp_log-0"
	base_icon_state = "swamp_log"
	rust_resistance = RUST_RESISTANCE_ORGANIC

	baseturfs = /turf/baseturf_bottom

	flags_ricochet = RICOCHET_HARD

	can_engrave = TRUE
	sheet_type = /obj/item/stack/fantasy_logs/swamp
	sheet_amount = 1
	girder_type = null
	slicing_duration = 7 SECONDS
	/// What sound the wall makes when dismantled
	var/dismantle_sound = SFX_TREE_CHOP
	/// What tool behavior we need to deconstruct
	var/deconstruct_tool = TOOL_AXE

/turf/closed/wall/fantasystation/deconstruction_hints(mob/user)
	return span_notice("The logs could probably be <b>hacked apart</b> with an <b>axe</b>.")

/turf/closed/wall/fantasystation/dismantle_wall(devastated = FALSE, explode = FALSE)
	if(devastated)
		devastate_wall()
	else
		playsound(src, dismantle_sound, 100, TRUE)
		var/newgirder = break_wall()
		if(newgirder) //maybe we don't /want/ a girder!
			transfer_fingerprints_to(newgirder)

	for(var/obj/O in src.contents) //Eject contents!
		if(istype(O, /obj/structure/sign/poster))
			var/obj/structure/sign/poster/P = O
			INVOKE_ASYNC(P, TYPE_PROC_REF(/obj/structure/sign/poster, roll_and_drop), src)
	if(decon_type)
		ChangeTurf(decon_type, flags = CHANGETURF_INHERIT_AIR)
	else
		ScrapeAway()
	QUEUE_SMOOTH_NEIGHBORS(src)

/turf/closed/wall/fantasystation/try_decon(obj/item/attacking_item, mob/user)
	if(attacking_item.tool_behaviour != deconstruct_tool)
		return FALSE

	to_chat(user, span_notice("You begin hacking through the logs..."))
	if(attacking_item.use_tool(src, user, slicing_duration, volume=100))
		if(iswallturf(src))
			to_chat(user, span_notice("You break through the stacked logs."))
			dismantle_wall()
		return TRUE

	return FALSE

/// Now for the actual walls, starting with logs

/turf/closed/wall/fantasystation/log
	name = "log wall"
	desc = "A stack of logs set in the ground to keep the outside out, and the inside in."
	icon = 'icons/obj/fantasystation_obj/walls/log.dmi'
	icon_state = "log-0"
	base_icon_state = "log"
	sheet_type = /obj/item/stack/fantasy_logs

/turf/closed/wall/fantasystation/log/swamp
	name = "swamp log wall"
	icon = 'icons/obj/fantasystation_obj/walls/swamp_log.dmi'
	icon_state = "swamp_log-0"
	base_icon_state = "swamp_log"
	sheet_type = /obj/item/stack/fantasy_logs/swamp

/// Clay brick wall

/turf/closed/wall/fantasystation/clay_brick
	name = "ceramic brick wall"
	desc = "A stack of ceramic bricks set in the ground to keep the outside out, and the inside in."
	icon = 'icons/obj/fantasystation_obj/walls/mud.dmi'
	icon_state = "mud-0"
	base_icon_state = "mud"
	sheet_type = /obj/item/stack/fantasy_bricks
	dismantle_sound = SFX_ROCK_TAP

/turf/closed/wall/fantasystation/clay_brick/deconstruction_hints(mob/user)
	return span_notice("The bricks could probably be smashed apart with an <b>axe</b>.")
