script.on_event(defines.events.on_entity_damaged,function(event)
	queue_repairs(event.entity,game.tick)
end)
script.on_event(defines.events.on_tick,function(event)
	do_repairs()
end)
function queue_repairs(entity,tick)
	if(not global.repair_queue)then
		global.repair_queue={}
	end
	global.repair_queue[entity.unit_number]={
		entity=entity,
		tick=tick}
end
function do_repairs()
	for _,damaged in pairs(global.repair_queue)do
		local ticks_elapsed_since_damaged=game.tick-damaged.tick
		local entity=damaged.entity
		if(ticks_elapsed_since_damaged>300)then
			entity.health=entity.prototype.max_health
		end
	end
end