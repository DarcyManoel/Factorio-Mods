damaged_entities={}--create a global table to store the time since each entity was last damaged
script.on_event(defines.events.on_entity_damaged,function(event)
	if event.entity and event.entity.valid then
		table.insert(damaged_entities,{
			entity=event.entity,
			last_damaged_tick=game.tick})
	end
end)
script.on_event(defines.events.on_tick,function(event)
	for index,damaged in pairs(damaged_entities)do
		if damaged.entity and damaged.entity.valid then
			if(game.tick-damaged.last_damaged_tick)>=3600 then--60 seconds
				if(damaged.entity.health<damaged.entity.prototype.max_health)then
					damaged.entity.health=damaged.entity.prototype.max_health
				end
				damaged_entities[index]=nil--stop tracking restored entity
			end
		else damaged_entities[index]=nil--stop tracking invalid entities
		end
	end
end)