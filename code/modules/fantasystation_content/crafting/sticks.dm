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
	/// How many variations of sprite does this have?
	var/icon_variations = 2

/obj/item/vintage_stick/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state]_[rand(1, icon_variations)]"
