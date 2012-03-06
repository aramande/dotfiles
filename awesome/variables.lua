-- Themes define colours, icons, and wallpapers
-- Default themes are located at /usr/share
beautiful.init("/home/aramande/.config/awesome/themes/mytheme/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
altkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
	awful.layout.suit.floating, 	-- 1
	awful.layout.suit.tile,			-- 2
	awful.layout.suit.tile.left,	-- 3
	awful.layout.suit.tile.bottom,	-- 4
	awful.layout.suit.tile.top,		-- 5
	awful.layout.suit.fair,			-- 6
	awful.layout.suit.fair.horizontal,	-- 7
	--	awful.layout.suit.spiral,
	--	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max,			-- 8
	--	awful.layout.suit.max.fullscreen,
	awful.layout.suit.magnifier		-- 9
}
