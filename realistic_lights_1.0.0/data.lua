--Settings
local enable_vehicle_light_halo=0
--Character
local character_picture={
	filename='__realistic_lights__/graphics/lightcone_enhanced.png',
	priority='extra-high',
	flags={'light'},
	scale=2,
	width=350,
	height=370
}
local flashlight={
	type='oriented',
	minimum_darkness=.1,
	picture=character_picture,
	shift={0,-24},
	size=2,
	intensity=.9,
	color={r=1,g=1,b=1}
}
local character=data.raw.player and data.raw.player.player or data.raw.character and data.raw.character.character
if character then
	character.light={flashlight}
end
--Vehicles
local vehicle_picture={
	filename='__realistic_lights__/graphics/lightcone_enhanced-vehicle.png',
	priority='extra-high',
	flags={'light'},
	scale=2,
	width=350,
	height=370
}
local vehicle_halo={
	minimum_darkness=.1,
	intensity=.2,
	size=30,
}
local vehicle_headlights={
	type='oriented',
	minimum_darkness=.1,
	picture=vehicle_picture,
	shift={0,-25},
	size=2,
	intensity=1,
	color={r=1,g=1,b=1}
}
--Car and tank
for _,vehicle in pairs(data.raw['car']) do
	if vehicle then
		vehicle.light={vehicle_headlights}
	end
end
--Spidertron
for _,spider in pairs(data.raw['spider-vehicle']) do
	if spider then
		spider.graphics_set.light={vehicle_headlights}
	end
end
--Locomotive
for _,loco in pairs(data.raw['locomotive']) do
	if loco then
		loco.front_light={vehicle_headlights}
		loco.stand_by_light={
			{
				color={b=1},
				shift={-.6,-3.5},
				size=2,
				intensity=.6
			}
		}
	end
end