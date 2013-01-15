	-- Define a tag table which hold all screen tags.
	tags = {}
	-- Singlescreen mode
	namelist = { "code",   "web",    "term",   "media", "chat",   "music",  "news",   "social" }
	layoutlist  = { layouts[2], layouts[8], layouts[6], layouts[8], layouts[3], layouts[8], layouts[2], layouts[8] }
	for s=1, screen.count() do
		start = (s-1)/screen.count()*#namelist+1
		stop = s/screen.count()*#namelist
		workspace = 1
		tag[s] = { 
			names = {}, 
			layout = {} 
		}
		for index = start, stop do
			tag[s].names[workspace] = workspace .. namelist[index]
			tag[s].layout[workspace] = layoutlist[index]
			workspace = workspace + 1
		end
		for index = workspace, 9 do
			tag[s].names[index] = index
			tag[s].layout[index] = layouts[1]
		end

		tags[s] = awful.tag(tag[s].names, s, tag[s].layout)

		workspace = 1
		for index = start, stop do
			tags[namelist[index]] = tags[s][workspace]
			workspace = workspace + 1
		end
	end

	awful.tag.setproperty(tags["chat"], "mwfact", 0.75)
	awful.tag.setproperty(tags["chat"], "nmaster", 3)
	awful.tag.setproperty(tags["code"], "mwfact", 0.70)
