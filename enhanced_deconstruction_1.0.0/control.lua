local function pickup_marked(player)
	local entities=player.surface.find_entities_filtered{
		position=player.position,
		radius=5,
		to_be_deconstructed=true}
	for _,entity in ipairs(entities) do
		player.mine_entity(entity)
	end
end
script.on_event(defines.events.on_player_changed_position,function(e)
	local player=game.players[e.player_index]
	if player.picking_state then
		pickup_marked(player)
	end
end)