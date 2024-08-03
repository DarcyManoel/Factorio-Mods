script.on_event(defines.events.on_player_repaired_entity,function(event)
	event.entity.health=event.entity.prototype.max_health
end)