/datum/crafting_recipe/fantasystation
	/// What sound we make when the recipe is finished, if any
	var/recipe_completion_sound

/datum/crafting_recipe/fantasystation/on_craft_completion(mob/user, atom/result)
	if(recipe_completion_sound)
		playsound(result, recipe_completion_sound, 50, TRUE, MEDIUM_RANGE_SOUND_EXTRARANGE)
