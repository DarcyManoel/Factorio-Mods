--sun starts to set at 0.25
--sun fully set at 0.45
--sun starts to rise at 0.55
--sun fully risen at 0.75
data.raw['utility-constants']['default'].daytime_color_lookup={
	{0.200,'identity'},
	{0.340,'__core__/graphics/color_luts/night.png'},
	{0.450,'__dark_nights__/graphics/black.png'},
	{0.550,'__dark_nights__/graphics/black.png'},
	{0.660,'__core__/graphics/color_luts/night.png'},
	{0.800,'identity'}
}
data.raw['utility-constants']['default'].zoom_to_world_daytime_color_lookup=data.raw['utility-constants']['default'].daytime_color_lookup
