/// Gives all objects the potential for a fuel value
/obj/item
	/// How long this will last when added to a campfire as fuel
	var/campfire_fuel_value

/// Burns fuel and cooks food, simple as
/obj/structure/fantasy_campfire
	name = "firepit"
	desc = "A stack of wood or other burnable stuff that makes light and cooks food."
	icon = 'icons/obj/fantasystation_obj/fires.dmi'
	icon_state = "campfire"
	pass_flags_self = PASSTABLE | LETPASSTHROW
	light_color = LIGHT_COLOR_FIRE
	density = FALSE
	anchored = TRUE
	/// Is this fire working as a grill?
	var/grill = TRUE
	/// Is the fire lit?
	var/burning = FALSE
	/// How much fuel the campfire has left, as a time left
	var/fuel_remaining = 5 MINUTES
	/// The max amount of fuel this can hold in it, in time
	var/max_fuel_storage = 1 HOURS
	/// Firestacks to give to any poor man who walks onto the fire
	var/firestack_strength = 5
	/// Looping sound for the campfire crackling sound effect
	var/datum/looping_sound/burning/burning_loop

/obj/structure/fantasy_campfire/Initialize(mapload)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)
	burning_loop = new(src)

/obj/structure/fantasy_campfire/Destroy()
	STOP_PROCESSING(SSobj, src)
	QDEL_NULL(burning_loop)
	return ..()

/obj/structure/fantasy_campfire/examine(mob/user)
	. = ..()
	. += span_notice("It has roughly <b>[round(fuel_remaining / (1 MINUTES), 0.1)] minute(s)</b> of fuel left.")

/obj/structure/fantasy_campfire/attackby(obj/item/used_item, mob/living/user, params)
	if(used_item.get_temperature())
		start_burning()
	if(used_item.campfire_fuel_value)
		if((used_item.campfire_fuel_value + fuel_remaining) > max_fuel_storage)
			balloon_alert(user, "too much fuel")
			return
		if(isstack(used_item))
			var/obj/item/stack/used_stack = used_item
			fuel_remaining += used_stack.campfire_fuel_value
			used_stack.use(1)
			balloon_alert(user, "fuel added")
			return
		else
			fuel_remaining += used_item.campfire_fuel_value
			qdel(used_item)
			balloon_alert(user, "fuel added")
			return
	if(grill)
		if(!user.combat_mode && !(used_item.item_flags & ABSTRACT))
			if(user.temporarilyRemoveItemFromInventory(used_item))
				used_item.forceMove(get_turf(src))
				var/list/modifiers = params2list(params)
				//Center the icon where the user clicked.
				if(!LAZYACCESS(modifiers, ICON_X) || !LAZYACCESS(modifiers, ICON_Y))
					return
				//Clamp it so that the icon never moves more than 16 pixels in either direction (thus leaving the table turf)
				used_item.pixel_x = used_item.base_pixel_x + clamp(text2num(LAZYACCESS(modifiers, ICON_X)) - 16, -(world.icon_size/2), world.icon_size/2)
				used_item.pixel_y = used_item.base_pixel_y + clamp(text2num(LAZYACCESS(modifiers, ICON_Y)) - 16, -(world.icon_size/2), world.icon_size/2)
		else
			return ..()

/obj/structure/fantasy_campfire/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(burning)
		to_chat(user, span_warning("You need to extinguish [src] before taking it apart!"))
		return
	if(do_after(user, 5 SECONDS, target = src))
		qdel(src)

/// Makes the campfire start burning
/obj/structure/fantasy_campfire/proc/start_burning()
	if(!fuel_remaining)
		return
	if(burning)
		return

	burning_loop.start()
	burning = TRUE
	set_light(6)
	bonfire_burn()
	particles = new /particles/fantasy_campfire()
	START_PROCESSING(SSobj, src)

/obj/structure/fantasy_campfire/fire_act(exposed_temperature, exposed_volume)
	start_burning()

/// Checks what to do if something or someone enters the campfire's turf
/obj/structure/fantasy_campfire/proc/on_entered(datum/source, atom/movable/entered)
	SIGNAL_HANDLER
	if(burning)
		if(!grill)
			bonfire_burn()
		return

	//Not currently burning, let's see if we can ignite it.
	if(isliving(entered))
		var/mob/living/burning_body = entered
		if(burning_body.on_fire)
			start_burning()
			visible_message(span_notice("[entered] runs over [src], starting its fire!"))

	else if(entered.resistance_flags & ON_FIRE)
		start_burning()
		visible_message(span_notice("[entered]'s fire spreads to [src], setting it ablaze!"))

/// Checks what to do while the bonfire is burning
/obj/structure/fantasy_campfire/proc/bonfire_burn(seconds_per_tick = 2)
	var/turf/current_location = get_turf(src)
	if(!grill)
		current_location.hotspot_expose(1000, 250 * seconds_per_tick, 1)
	for(var/burn_target in current_location)
		if(burn_target == src)
			continue
		else if(isliving(burn_target))
			var/mob/living/burn_victim = burn_target
			burn_victim.adjust_fire_stacks(firestack_strength * 0.5 * seconds_per_tick)
			burn_victim.ignite_mob()
		else
			var/atom/movable/burned_movable = burn_target
			if(grill && isitem(burned_movable) && !is_reagent_container(burned_movable))
				var/obj/item/grilled_item = burned_movable
				SEND_SIGNAL(grilled_item, COMSIG_ITEM_GRILL_PROCESS, src, seconds_per_tick)
				continue
			if(grill && is_reagent_container(burned_movable))
				var/obj/item/reagent_containers/heated_item = burned_movable
				heated_item.reagents.expose_temperature(SOUP_BURN_TEMP + 80, 0.033)
				continue
			burned_movable.fire_act(1000, 250 * seconds_per_tick)

/obj/structure/fantasy_campfire/process(seconds_per_tick)
	if(!fuel_remaining)
		extinguish()
		return
	fuel_remaining -= seconds_per_tick SECONDS
	bonfire_burn(seconds_per_tick)

/obj/structure/fantasy_campfire/extinguish()
	. = ..()
	if(!burning)
		return

	burning_loop.stop()
	burning = FALSE
	set_light(0)
	QDEL_NULL(particles)
	STOP_PROCESSING(SSobj, src)

/// Campfire but it looks like swamp wood

/obj/structure/fantasy_campfire/swamp
	icon_state = "campfire_swamp"

/// Particle system used by these fires to look cooler (and I dont want to sprite fire)

/particles/fantasy_campfire
	icon = 'icons/effects/particles/bonfire.dmi'
	icon_state = "bonfire"
	width = 100
	height = 100
	count = 1000
	spawning = 6
	lifespan = 0.7 SECONDS
	fade = 1 SECONDS
	grow = -0.01
	velocity = list(0, 0)
	position = generator(GEN_CIRCLE, 0, 10, NORMAL_RAND)
	drift = generator(GEN_VECTOR, list(0, -0.2), list(0, 0.2))
	gravity = list(0, 0.95)
	scale = generator(GEN_VECTOR, list(0.3, 0.3), list(1.5,1.5), NORMAL_RAND)
	rotation = 30
	spin = generator(GEN_NUM, -20, 20)
