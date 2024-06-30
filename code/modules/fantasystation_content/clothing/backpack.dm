/obj/item/storage/backpack/fantasy
	name = "reed pack-basket"
	desc = "A large basket made of river reeds that you can wear on your back."
	icon = 'icons/obj/fantasystation_obj/equippable/back.dmi'
	icon_state = "reedpack"
	worn_icon = 'icons/mob/fantasystation_onmobs/clothing/back.dmi'
	worn_icon_state = "reedpack"
	lefthand_file = 'icons/mob/fantasystation_onmobs/inhands/lefthand.dmi'
	righthand_file = 'icons/mob/fantasystation_onmobs/inhands/righthand.dmi'
	inhand_icon_state = "reedpack"
	resistance_flags = FLAMMABLE

/obj/item/storage/backpack/fantasy/Initialize(mapload)
	. = ..()
	atom_storage.max_total_storage = (WEIGHT_CLASS_NORMAL * 5) + (WEIGHT_CLASS_SMALL * 2)
	atom_storage.max_slots = 7

/// The above backpack but made of sticks instead

/obj/item/storage/backpack/fantasy/sticks
	name = "stick pack-basket"
	desc = "A large basket made of woven sticks that you can wear on your back."
	icon_state = "stickpack"
	worn_icon_state = "stickpack"
	inhand_icon_state = "stickpack"
