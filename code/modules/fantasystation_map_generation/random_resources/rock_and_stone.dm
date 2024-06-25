/obj/item/vintage_stone
	name = "rock"
	desc = "I attacka you with a rock."
	icon = 'icons/obj/fantasystation_obj/rocks.dmi'
	icon_state = "rock_1"
	base_icon_state = "rock"
	w_class = WEIGHT_CLASS_NORMAL
	force = 15
	throwforce = 10
	/// How many variations of sprite does this have?
	var/icon_variations = 3

/obj/item/vintage_stone/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state]_[rand(1, icon_variations)]"

/obj/item/vintage_stone/flint
	name = "flint"
	desc = "The cooler rock."
	icon_state = "flint_1"
	base_icon_state = "flint"
