for index,lab in pairs(data.raw['lab'])do
	if lab.energy_source.type=='electric'then
		lab.energy_usage=((15*string.sub(lab.energy_usage,0,string.len(lab.energy_usage)-2))..'kW')
	end
end