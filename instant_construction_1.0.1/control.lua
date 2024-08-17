script.on_event(defines.events.on_built_entity,function(event)
	local player=game.get_player(event.player_index)
	local ghost=event.created_entity
	if ghost.valid and ghost.name=='entity-ghost'then
		local item_name=ghost.ghost_name
		if player.get_item_count(item_name)>0 then
			if ghost.valid then
				player.remove_item{name=item_name,count=1}
				ghost.revive()
			end
		else
			player.print("You don't have the item to place a ghost.")
		end
	end
end)