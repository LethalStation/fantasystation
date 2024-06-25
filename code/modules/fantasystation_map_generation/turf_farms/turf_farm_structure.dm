/obj/machinery/hydroponics/turf_farm
	name = "farmable land"
	desc = "A pile of the floor that happens to be prepared for farming on."
	icon = 'icons/obj/fantasystation_obj/farm_turf_overlay.dmi'
	icon_state = "farm_overlay_horizontal"
	gender = PLURAL
	circuit = null
	density = FALSE
	use_power = NO_POWER_USE
	obj_flags = parent_type::obj_flags | NO_DECONSTRUCTION
	unwrenchable = TRUE
	self_sustaining_overlay_icon_state = null
	maxnutri = 30
	self_sustaining = TRUE
	pixel_z = 0

/obj/machinery/hydroponics/turf_farm/update_status_light_overlays()
	return

/obj/machinery/hydroponics/turf_farm/CtrlClick(mob/user)
	return

/obj/machinery/hydroponics/turf_farm/on_deconstruction(disassembled)
	return

/obj/machinery/hydroponics/turf_farm/set_seed(obj/item/seeds/new_seed, delete_old_seed)
	. = ..()
	if(isnull(myseed))
		qdel(src)
