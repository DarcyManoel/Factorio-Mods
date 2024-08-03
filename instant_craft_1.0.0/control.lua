script.on_event(defines.events.on_pre_player_crafted_item,function(event)
	local player=game.players[event.player_index]
	instant_crafting_init_global()
	instant_crafting_cancel_craft(player)
	instant_crafting_remove_ingredients(player)
	instant_crafting_add_products(player)
end)
script.on_event(defines.events.on_player_cancelled_crafting,function(event)
	local player=game.players[event.player_index]
	instant_crafting_remember_products(event.recipe,event.cancel_count)
	instant_crafting_remember_ingredients(event.items)
end)
function instant_crafting_init_global()
	global.instant_crafting=global.instant_crafting or{}
	global.instant_crafting.products={}
	global.instant_crafting.ingredients={}
end
function instant_crafting_cancel_craft(player)
	local craft_to_cancel={index=#player.crafting_queue}
	if #player.crafting_queue>0 then
		craft_to_cancel.count=player.crafting_queue[craft_to_cancel.index].count
		player.cancel_crafting(craft_to_cancel)
	end
end
function instant_crafting_remember_products(recipe, count)
	for _,product in pairs(recipe.products)do
		local product_to_insert={name=product.name}
		product_to_insert.count=(product.amount or 1)*count
		table.insert(global.instant_crafting.products,product_to_insert)
	end
end
function instant_crafting_add_products(player)
	for _,product in pairs(global.instant_crafting.products)do
		player.insert(product)
	end
end
function instant_crafting_remember_ingredients(items)
	global.instant_crafting.ingredients={}
	for item,count in pairs(items.get_contents())do
		local stack={
			name=item,
			count=count}
		table.insert(global.instant_crafting.ingredients,stack)
	end
end
function instant_crafting_remove_ingredients(player)
	for _,ingredient in pairs(global.instant_crafting.ingredients)do
		player.remove_item(ingredient)
	end
end