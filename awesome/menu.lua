-- Create a laucher widget and a main menu
myawesomemenu = {
	{ "manual", terminal .. " -e man awesome" },
	{ "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
	{ "restart", awesome.restart },
	{ "quit", awesome.quit },
	{ "shutdown", "gksudo shutdown -h now" }
}
mymainmenu = awful.menu({ 
	items = { 
		{ "awesome", myawesomemenu, beautiful.awesome_icon },
		{ "&chromium", "chromium --enable-plugins" },
		{ "thu&nderbird", "thunderbird" },
		{ "&blogbridge", "blogbridge-6.7/blogbridge.sh" },
		{ "&tweetdeck", "tweetdeck" },-- Chromium version: "chromium-browser --app-id=hbdpomandigafcibbmofojjchbcdagbl" },
		{ "&pidgin", "pidgin" },
		{ "&skype", "skype" },
		{ "b&anshee", "banshee" },
		{ "&minecraft", "minecraft" },
		{ "open terminal", terminal }
	}
})

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon), menu = mymainmenu })


