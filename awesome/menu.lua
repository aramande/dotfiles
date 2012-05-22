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
		{ "&firefox", "firefox" },
		{ "&chromium", "chromium-browser --enable-plugins" },
		{ "thu&nderbird", "thunderbird" },
		-- { "&blogbridge", "javaws -localfile /home/aramande/.java/deployment/cache/6.0/8/11ce99c8-2427ca6d" },
		-- { "&blogbridge", "/usr/lib/jvm/java-6-sun-1.6.0.26/jre/bin/javaws -localfile /home/aramande/.java/deployment/cache/6.0/8/11ce99c8-2427ca6d" },
		{ "&blogbridge", "blogbridge-6.7/blogbridge.sh" },
		{ "&tweetdeck", "tweetdeck" },-- Chromium version: "chromium-browser --app-id=hbdpomandigafcibbmofojjchbcdagbl" },
		{ "&pidgin", "pidgin" },
		{ "&skype", "skype" },
		{ "b&anshee", "banshee" },
		{ "&minecraft", "minecraft" },
		{ "debian", debian.menu.Debian_menu.Debian },
		{ "open terminal", terminal }
	}
})

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon), menu = mymainmenu })


