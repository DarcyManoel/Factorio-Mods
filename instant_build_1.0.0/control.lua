local function do_deconstruction(player)
	local marked_entities=game.surfaces[1].find_entities_filtered{to_be_deconstructed=1}
	for _,entity in pairs(marked_entities)do
		player.mine_entity(entity)
	end
end
script.on_event(defines.events.on_player_deconstructed_area,function(event)
	local player=game.players[event.player_index]
	do_deconstruction(player)
end)
script.on_event(defines.events.on_built_entity,function(event)
	local player=game.players[event.player_index]
	do_deconstruction(player)
	local ghost=event.created_entity
	if ghost.valid and ghost.name=='entity-ghost'then
		local item_name=ghost.ghost_name
		if player.get_item_count(item_name)>0 then
			player.remove_item{name=item_name,count=1}
			ghost.revive()
		else
			player.print("You don't have the item to place a ghost.")
		end
	end
end)