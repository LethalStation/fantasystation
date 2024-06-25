/turf/open/misc/fantasy_grass
	name = "grass"
	desc = "Dense grass, you can't even see the soil beneath it. This stuff has probably been growing here longer than your history has known, \
		though thankfully it seems to grow relatively short."
	gender = PLURAL

	icon = 'icons/turf/fantasystation/grass.dmi'
	icon_state = "grass-255"
	base_icon_state = "grass"
	tiled_dirt = FALSE

	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_TURF_OPEN + SGROUP_FANTASY_GRASS
	canSmoothWith = SMOOTH_GROUP_CLOSED_TURFS + SGROUP_FANTASY_GRASS
	layer = HIGH_TURF_LAYER

	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/misc/regular_soil

	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS
	clawfootstep = FOOTSTEP_GRASS
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/misc/fantasy_grass/Initialize(mapload)
	. = ..()
	if(smoothing_flags)
		var/matrix/translation = new
		translation.Translate(-8, -8)
		transform = translation

/turf/open/misc/desert_sand
	name = "sand"
	desc = "Dark desert sand, the most common type of ground around if you live somewhere dry. Completely devoid of water, \
		and prone to blowing up into large dust storms with devastating power. It's coarse and it gets everywhere."
	gender = PLURAL

	icon = 'icons/turf/fantasystation/sand.dmi'
	icon_state = "sand-255"
	base_icon_state = "sand"
	tiled_dirt = FALSE

	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_TURF_OPEN + SGROUP_DESERT_SAND
	canSmoothWith = SMOOTH_GROUP_CLOSED_TURFS + SGROUP_DESERT_SAND + SGROUP_FANTASY_GRASS
	layer = HIGH_TURF_LAYER

	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/misc/desert_sand

	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/misc/desert_sand/Initialize(mapload)
	. = ..()
	if(smoothing_flags)
		var/matrix/translation = new
		translation.Translate(-8, -8)
		transform = translation

/turf/open/misc/dry_soil
	name = "parched earth"
	desc = "While this may have been normal, vibrant earth in some time past, that time is certainly not the present. \
		This soil is extremely dry, with a wicked looking cracked surface. The only thing stopping it from becoming sand \
		is how tightly packed the material is."
	gender = PLURAL

	icon = 'icons/turf/fantasystation/dry_dirt.dmi'
	icon_state = "dry_dirt-255"
	base_icon_state = "dry_dirt"
	tiled_dirt = FALSE

	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_TURF_OPEN + SGROUP_CRACKED_EARTH
	canSmoothWith = SMOOTH_GROUP_CLOSED_TURFS + SGROUP_DESERT_SAND + SGROUP_CRACKED_EARTH + SGROUP_FANTASY_GRASS
	layer = HIGH_TURF_LAYER - 0.001

	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/misc/dry_soil

	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/misc/dry_soil/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/turf_farm, 0.5)
	if(smoothing_flags)
		var/matrix/translation = new
		translation.Translate(-8, -8)
		transform = translation

/turf/open/misc/regular_soil
	name = "rocky soil"
	desc = "Soil filled with larger stones that likely does not reach down very far into the ground. As a result, this makes it a passable \
		but less than optimal terrain for farming."
	gender = PLURAL

	icon = 'icons/turf/fantasystation/dirt.dmi'
	icon_state = "dirt-255"
	base_icon_state = "dirt"
	tiled_dirt = FALSE

	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_TURF_OPEN + SGROUP_ROCKY_SOIL
	canSmoothWith = SMOOTH_GROUP_CLOSED_TURFS + SGROUP_DESERT_SAND + SGROUP_CRACKED_EARTH + SGROUP_ROCKY_SOIL + SGROUP_FANTASY_GRASS
	layer = HIGH_TURF_LAYER - 0.002

	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/misc/regular_soil

	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/misc/regular_soil/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/turf_farm, 0.7)
	if(smoothing_flags)
		var/matrix/translation = new
		translation.Translate(-8, -8)
		transform = translation

/turf/open/misc/muck_slop
	name = "mud"
	desc = "Mud, or if it's not mud right now, it was or will be recently. Likely found near water."
	gender = PLURAL

	icon = 'icons/turf/fantasystation/mud.dmi'
	icon_state = "mud-255"
	base_icon_state = "mud"
	tiled_dirt = FALSE

	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_TURF_OPEN + SGROUP_FANTASY_DIRT
	canSmoothWith = SMOOTH_GROUP_CLOSED_TURFS + SGROUP_DESERT_SAND + SGROUP_CRACKED_EARTH + SGROUP_ROCKY_SOIL + SGROUP_FANTASY_DIRT + SGROUP_FANTASY_GRASS
	layer = HIGH_TURF_LAYER - 0.003

	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/misc/muck_slop

	footstep = FOOTSTEP_WATER
	barefootstep = FOOTSTEP_WATER
	clawfootstep = FOOTSTEP_WATER
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

	slowdown = 0.3

/turf/open/misc/muck_slop/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/turf_farm, 1)
	if(smoothing_flags)
		var/matrix/translation = new
		translation.Translate(-8, -8)
		transform = translation

/turf/open/misc/fire_clay
	name = "fire clay"
	desc = "On today's tier list of things to bring when starting civilization, fire clay such as this makes top five. \
		While no good for growing in, it has a much more important use, bricks and pottery."
	gender = PLURAL

	icon = 'icons/turf/fantasystation/clay.dmi'
	icon_state = "clay-255"
	base_icon_state = "clay"
	tiled_dirt = FALSE

	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_TURF_OPEN + SGROUP_FIRE_CLAY
	canSmoothWith = SMOOTH_GROUP_CLOSED_TURFS + SGROUP_DESERT_SAND + SGROUP_CRACKED_EARTH + SGROUP_ROCKY_SOIL + SGROUP_FANTASY_DIRT + SGROUP_FIRE_CLAY + SGROUP_FANTASY_GRASS
	layer = HIGH_TURF_LAYER - 0.004

	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/misc/fire_clay

	footstep = FOOTSTEP_WATER
	barefootstep = FOOTSTEP_WATER
	clawfootstep = FOOTSTEP_WATER
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/misc/fire_clay/Initialize(mapload)
	. = ..()
	if(smoothing_flags)
		var/matrix/translation = new
		translation.Translate(-8, -8)
		transform = translation
