/obj/structure/railing/fantasy_palisade
	name = "palisade"
	desc = "A tall fence made of logs driven into the ground."
	icon = 'icons/obj/fantasystation_obj/fences.dmi'
	icon_state = "palisade"
	item_deconstruct = /obj/item/stack/fantasy_logs
	layer = OBJ_LAYER - 0.02
	climbable = FALSE
	max_integrity = 200
	resistance_flags = FLAMMABLE
	obj_flags = CAN_BE_HIT | BLOCKS_CONSTRUCTION_DIR | IGNORE_DENSITY

/obj/structure/railing/fantasy_palisade/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_DIR_CHANGE, PROC_REF(on_change_layer))
	adjust_dir_layer(dir)

/obj/structure/railing/fantasy_palisade/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	playsound(src, SFX_TREE_CHOP, 50, vary = TRUE)

/// Kicks the adjust_dir_layer proc into gear when the direction of the palisade changes
/obj/structure/railing/fantasy_palisade/proc/on_change_layer(datum/source, old_dir, new_dir)
	SIGNAL_HANDLER
	adjust_dir_layer(new_dir)

/// Adjusts the layer of the palisade based on which direction the palisade is facing
/obj/structure/railing/fantasy_palisade/proc/adjust_dir_layer(direction)
	layer = (direction & NORTH) ? (MOB_LAYER + 0.1) : initial(layer)
	plane = (direction & NORTH) ? GAME_PLANE : initial(plane)

/// Swamp wood edition

/obj/structure/railing/fantasy_palisade/swamp
	icon_state = "palisade_swamp"
	item_deconstruct = /obj/item/stack/fantasy_logs/swamp
