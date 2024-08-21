script.on_event(defines.events.on_player_main_inventory_changed,function(event)
	local player=game.players[event.player_index]
	local inventory=player.get_main_inventory()
	local slots_occupied=0
	for i1=#inventory,1,-1 do
		local slot=inventory[i1]
		if slot.count>0 then
			slots_occupied=slots_occupied+1
		end
	end
	player.character_inventory_slots_bonus=slots_occupied
end)