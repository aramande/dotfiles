-- Create a laucher widget and a main menu
myawesomemenu = {
	{ "manual", terminal .. " -e man awesome" },
	{ "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
	{ "restart", awesome.restart },
	{ "quit", awesome.quit },
	{ "reboot", "sudo shutdown -r now" },
	{ "shutdown", "sudo shutdown -h now" }
}

myskypemenu = {
	{ "&aramande", "skype" }, 
	{ "&starlit", "skype --dbpath=~/.Skype1" } 
}

--myminecraftmenu = {
--}

mykeybindings = {
		{ "dvp", "setxkbmap us dvp"},
		{ "dvorak", "setxkbmap us dvorak"},
		{ "sv",  "setxkbmap se"}
}

mymainmenu = awful.menu({ 
	items = { 
		{ "awesome", myawesomemenu, beautiful.awesome_icon },
		{ "&chromium", "chromium --enable-plugins" },
		{ "fi&refox", "env LD_PRELOAD=/home/aramande/fullscreenhack/libfshack-npapi.so firefox" },
		{ "thu&nderbird", "thunderbird" },
		{ "&blogbridge", "blogbridge-6.7/blogbridge.sh" },
		{ "&tweetdeck", "tweetdeck" },-- Chromium version: "chromium-browser --app-id=hbdpomandigafcibbmofojjchbcdagbl" },
		{ "&pidgin", "pidgin" },
		{ "&skype", myskypemenu },
		{ "b&anshee", "banshee" },
		{ "&gimp", "gimp" },
		{ "as&eprite", "aseprite" },
		{ "a&udacity", "audacity" },
		{ "&kdenlive", "kdenlive" },
		--{ "&minecraft", "minecraft" },
		{ "&mfeedthebeast", "java -jar /media/takara/Games/FTBClient/FTB_Launcher.jar" },
		{ "keybindings", mykeybindings },
		{ "open terminal", terminal }
	}
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })
-- mylauncher = awful.widget.launcher({ menu = mymainmenu })
-- mylauncher:set_image(beautiful.awesome_icon)

