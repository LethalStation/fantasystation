/datum/crafting_recipe
	non_craftable = TRUE
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED

/datum/crafting_recipe/fantasystation
	non_craftable = FALSE
	crafting_flags = CRAFT_CHECK_DENSITY
	/// What sound we make when the recipe is finished, if any
	var/recipe_completion_sound

/datum/crafting_recipe/fantasystation/on_craft_completion(mob/user, atom/result)
	if(recipe_completion_sound)
		playsound(result, recipe_completion_sound, 50, TRUE, MEDIUM_RANGE_SOUND_EXTRARANGE)
