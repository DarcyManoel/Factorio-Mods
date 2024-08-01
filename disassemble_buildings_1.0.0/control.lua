script.on_event(defines.events.on_player_mined_entity,function(event)
	local entity=event.entity
	if entity.prototype.items_to_place_this==nil then
		return
	end
	local entity_name=entity.prototype.items_to_place_this[1].name
	local recipe=game.players[event.player_index].force.recipes[entity_name]
	local products=recipe.products or {}
	local entity_product_count=1--default count
	--Determine how many of the entity are produced by its recipe
	for _,product in pairs(products) do
		if product.name==entity_name then
			if product.amount then
				entity_product_count=product.amount
			else
				local avg_amount=(product.amount_min+product.amount_max)/2
				entity_product_count=avg_amount*(product.probability or 1)
			end
			break
		end
	end
	--Ensure the buffer contains the entity before trying to remove it
	local old_stack={name=entity_name,count=math.floor(entity_product_count)}
	if event.buffer.get_item_count(entity_name)>=old_stack.count then
		event.buffer.remove(old_stack)
	else
		return--Exit if the entity wasn't found in the buffer
	end
	local new_stack={}
	for _,item in pairs(recipe.ingredients) do
		if item.type~=1 and item.name~=nil then--1 is for fluids
			table.insert(new_stack,{count=item.amount,name=item.name})
		else
			return--Exit if an ingredient is a fluid or doesn't have a name
		end
	end
	--Add the ingredients to the buffer
	for _,thingy in pairs(new_stack) do
		event.buffer.insert(thingy)
	end
end)