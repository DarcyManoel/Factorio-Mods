script.on_event(defines.events.on_player_deconstructed_area,function(event)
	local player=game.players[event.player_index]
	local marked_entities=game.surfaces[1].find_entities_filtered{to_be_deconstructed=1}
	for _,entity in pairs(marked_entities)do
		player.mine_entity(entity)
	end
end)