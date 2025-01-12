-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
awful.button({ }, 3, function () mymainmenu:toggle() end),
awful.button({ }, 4, awful.tag.viewnext),
awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

awful.key({ modkey,           }, "j",
function ()
	awful.client.focus.byidx( 1)
	if client.focus then client.focus:raise() end
end),
awful.key({ modkey,           }, "k",
function ()
	awful.client.focus.byidx(-1)
	if client.focus then client.focus:raise() end
end),
awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

-- Layout manipulation
awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
--awful.key({ modkey,           }, "Tab",
--function ()
--	awful.client.focus.history.previous()
--	if client.focus then
--		client.focus:raise()
--	end
--end),

-- Standard program
awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
awful.key({ modkey, "Control" }, "r", awesome.restart),
awful.key({ modkey, "Shift"   }, "q", awesome.quit),

awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

-- Prompt
awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

awful.key({ modkey }, "x",
function ()
	awful.prompt.run({ prompt = "Run Lua code: " },
	mypromptbox[mouse.screen].widget,
	awful.util.eval, nil,
	awful.util.getdir("cache") .. "/history_eval")
end),

-- Custom commands
-- Important programs
awful.key({ altkey,	 }, "grave",	function() awful.util.spawn(terminal)								end),
awful.key({ altkey,	 }, "dollar",	function() awful.util.spawn(terminal)								end),
awful.key({ modkey,	 }, "i",		function() awful.util.spawn("setxkbmap -layout us -variant dvp")	end),



-- Window/screen managing
awful.key({ altkey,  }, "Tab",
function ()
	awful.client.focus.byidx(1)
	if client.focus then client.focus:raise() end
end),
awful.key({ altkey, "Shift"   }, "Tab",
function ()
	awful.client.focus.byidx(-1)
	if client.focus then client.focus:raise() end
end),
awful.key({ modkey,			 }, "Tab", function () awful.screen.focus_relative( 1) end),
awful.key({ modkey, "Shift"	 }, "Tab", function () awful.screen.focus_relative(-1) end),
awful.key({ modkey,          }, "e",   function () awful.util.spawn("nautilus")    end),

-- Media button bindings
awful.key({ }, "XF86AudioPlay", 	function () awful.util.spawn("mpc -p 6601 toggle")		end),
awful.key({ }, "XF86AudioNext", 	function () awful.util.spawn("mpc -p 6601 next")		end),
awful.key({ }, "XF86AudioPrev", 	function () awful.util.spawn("mpc -p 6601 prev")		end),
awful.key({ }, "XF86AudioStop", 	function () awful.util.spawn("mpc -p 6601 stop")		end),
awful.key({ }, "XF86AudioRaiseVolume",	function() awful.util.spawn("amixer set Master 5%+")	end),
awful.key({ }, "XF86AudioLowerVolume",	function() awful.util.spawn("amixer set Master 5%-")	end),
awful.key({ }, "XF86AudioMute",		function() awful.util.spawn("amixer set Master toggle") end)
)

-- Window control keys
clientkeys = awful.util.table.join(
awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
awful.key({ altkey,			  }, "F4",     function (c) c:kill()                         end),
awful.key({ modkey,			  }, "c",      function (c) c:kill()                         end),
awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
awful.key({ modkey,			  }, "o",	   awful.client.movetoscreen						),
awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
awful.key({ modkey,           }, "Down",   function (c) c.minimized = not c.minimized    end),
awful.key({ modkey,           }, "Up",
function (c)
	c.maximized_horizontal = not c.maximized_horizontal
	c.maximized_vertical   = not c.maximized_vertical
end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
	keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
	globalkeys = awful.util.table.join(globalkeys,
	awful.key({ modkey }, "#" .. i + 9,
	function ()
		local screen = mouse.screen
		if tags[screen][i] then
			awful.tag.viewonly(tags[screen][i])
		end
	end),
	awful.key({ modkey, "Control" }, "#" .. i + 9,
	function ()
		local screen = mouse.screen
		if tags[screen][i] then
			awful.tag.viewtoggle(tags[screen][i])
		end
	end),
	awful.key({ modkey, "Shift" }, "#" .. i + 9,
	function ()
		if client.focus and tags[client.focus.screen][i] then
			awful.client.movetotag(tags[client.focus.screen][i])
		end
	end),
	awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
	function ()
		if client.focus and tags[client.focus.screen][i] then
			awful.client.toggletag(tags[client.focus.screen][i])
		end
	end))
end

clientbuttons = awful.util.table.join(
awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
awful.button({ modkey }, 1, awful.mouse.client.move),
awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}
