local function do_deconstruction(player)
	for _,deconstructable in pairs(global.todo.deconstructables)do
		player.mine_entity(deconstructable)
	end
end
local function do_reconstruction(player)
	for _,reconstructable in pairs(global.todo.reconstructables)do
		upgrade_target=reconstructable.get_upgrade_target()
		if player.get_item_count(upgrade_target.name)>0 then
			player.remove_item{name=upgrade_target.name,count=1}
			if player.can_insert({name=reconstructable.name,count=1})then
				player.insert({name=reconstructable.name,count=1})
			else
				player.surface.spill_item_stack(player.position,{name=reconstructable.name,count=1},1,player.force,0)
			end
			local underground_type
			if reconstructable.type=="underground-belt" then
				underground_type=reconstructable.belt_to_ground_type
			end
			local entity_upgrade=player.surface.create_entity{
				name=upgrade_target.name,
				position={reconstructable.position.x,reconstructable.position.y},
				direction=reconstructable.direction,
				force=player.force,
				fast_replace=true,
				spill=false,
				type=underground_type}
		end
	end
end
local function do_construction(player)
	for _,constructable in pairs(global.todo.constructables)do
		if player.get_item_count(constructable.ghost_name)>0 then
			player.remove_item{name=constructable.ghost_name,count=1}
			constructable.revive()
		end
	end
end
local function prepare_build(player)
	if not global.todo then
		global.todo={}
	end
	global.todo.deconstructables=game.surfaces[1].find_entities_filtered{to_be_deconstructed=1}
	do_deconstruction(player)
	global.todo.reconstructables=game.surfaces[1].find_entities_filtered{to_be_upgraded=1}
	do_reconstruction(player)
	global.todo.constructables=game.surfaces[1].find_entities_filtered{type='entity-ghost'}
	do_construction(player)
end
script.on_event(defines.events.on_player_deconstructed_area,function(event)
	local player=game.players[event.player_index]
	prepare_build(player)
end)
script.on_event(defines.events.on_marked_for_upgrade,function(event)
	local player=game.players[event.player_index]
	prepare_build(player)
end)
script.on_event(defines.events.on_built_entity,function(event)
	local player=game.players[event.player_index]
	prepare_build(player)
end,{{filter='type',type='entity-ghost'}})
script.on_event(defines.events.on_player_main_inventory_changed,function(event)
	local player=game.players[event.player_index]
	prepare_build(player)
end)