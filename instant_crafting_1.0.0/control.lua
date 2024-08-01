script.on_event(defines.events.on_pre_player_crafted_item,function(event)
	local player=game.players[event.player_index]
	instantCrafting_initGlobal()
	instantCrafting_cancelCraft(player)
	instantCrafting_removeIngredients(player)
	instantCrafting_addProducts(player)
end)
script.on_event(defines.events.on_player_cancelled_crafting,function(event)
	local player=game.players[event.player_index]
	instantCrafting_rememberProducts(event.recipe,event.cancel_count)
	instantCrafting_rememberIngredients(event.items)
end)
function instantCrafting_initGlobal()
	global.instantCrafting=global.instantCrafting or {}
	global.instantCrafting.products={}
	global.instantCrafting.ingredients={}
end
function instantCrafting_cancelCraft(player)
	local craftToCancel={index=#player.crafting_queue}
	if #player.crafting_queue>0 then
		craftToCancel.count=player.crafting_queue[craftToCancel.index].count
		player.cancel_crafting(craftToCancel)
	end
end
function instantCrafting_rememberProducts(recipe,count)
	for _,product in pairs(recipe.products) do
		local productToInsert={name=product.name}
		productToInsert.count=(product.amount or 1)*count
		table.insert(global.instantCrafting.products,productToInsert)
	end
end
function instantCrafting_addProducts(player)
	for _, product in pairs(global.instantCrafting.products) do
		player.insert(product)
	end
end
function instantCrafting_rememberIngredients(items)
	global.instantCrafting.ingredients={}
	for item,count in pairs(items.get_contents()) do
		local stack={name=item,count=count}
		table.insert(global.instantCrafting.ingredients,stack)
	end
end
function instantCrafting_removeIngredients(player)
	for _,ingredient in pairs(global.instantCrafting.ingredients) do
		player.remove_item(ingredient)
	end
end