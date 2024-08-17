script.on_event(defines.events.on_built_entity,function(event)
	local player=game.get_player(event.player_index)
	local ghost=event.created_entity
	if ghost.valid and ghost.name=="entity-ghost"then
		local item_name=ghost.ghost_name
		if player.get_item_count(item_name)>0 then
			if ghost.valid then
				local position=ghost.position
				local direction=ghost.direction
				local force=ghost.force
				ghost.destroy()
				local placed_entity=player.surface.create_entity{
					name=item_name,
					position=position,
					direction=direction,
					force=force
				}
				if placed_entity and placed_entity.valid then
					player.remove_item{name=item_name,count=1}
				else
					player.print("Failed to place the entity.")
				end
			end
		else
			player.print("You don't have the item to place this ghost.")
		end
	end
end)
