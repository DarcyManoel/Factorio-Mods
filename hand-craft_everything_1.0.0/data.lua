for name,recipe in pairs(data.raw.recipe) do
	local can_craft_by_hand=true
	local ingredients=recipe.ingredients or (recipe.normal and recipe.normal.ingredients) or (recipe.expensive and recipe.expensive.ingredients)
	if ingredients then
		for _,ingredient in pairs(ingredients) do
			if (ingredient.type and ingredient.type~='item') or (not ingredient.type and data.raw.fluid[ingredient.name]) then
				can_craft_by_hand=false
				break
			end
		end
	end
	if can_craft_by_hand then
		recipe.category='crafting'
	end
end
