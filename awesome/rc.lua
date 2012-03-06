-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")

-- Load Debian menu entries
require("debian.menu")
--if screen.count() == 1 then
--	require("rc1")
--elseif screen.count() == 2 then
--	require("rc2")
--else -- incase of multiple screens

	-- {{{ Variable definitions
	require("variables")
	-- }}}

	-- {{{ Tags
	require("tags")
	-- }}}

	-- {{{ Menu
	require("menu")
	-- }}}

	-- {{{ Wibox
	require("awibox")
	-- }}}

	-- {{{ Bindings
	require("bindings")
	-- }}}

	-- {{{ Rules
	require("rules")
	-- }}}

	-- {{{ Signals
	require("signals")
	-- }}}

	-- {{{ Autostart stuff
	require("autostart")
	-- }}}
--end
