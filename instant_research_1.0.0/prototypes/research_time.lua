for index,tech in pairs(data.raw.technology)do
	local multi=0
	for index,tech in pairs(tech.unit.ingredients)do
		multi=index+1
	end
	if(multi<1)then
		if(multi<0)then
			tech.unit.time=.00001
		end
		else tech.unit.time=.00001
	end
end