-- Create a textclock widget
mytextclock = awful.widget.textclock()

mystatusbar = awful.wibox({ position = "bottom", screen = second, ontop = false, width = 1, height = 70 })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- Create a textclock widget
--textclock = awful.widget.textclock({ align = "right" }, "%a %b %d, %H:%M:%S", 1)

-- Create a systray
--systray = wibox.widget.systray()
--statusbar = awful.wibox({ position = "bottom", screen = second, ontop = false, width = 1, height = 70 })

-- Create a wibox for each screen and add it
--wibox = {}
--promptbox = {}
--layoutbox = {}
--taglist = {}
--taglist.buttons = awful.util.table.join(
--      awful.button({ }, 1, awful.tag.viewonly),
--      awful.button({ modkey }, 1, awful.client.movetotag),
--      awful.button({ }, 3, awful.tag.viewtoggle),
--      awful.button({ modkey }, 3, awful.client.toggletag),
--      awful.button({ }, 4, awful.tag.viewnext),
--      awful.button({ }, 5, awful.tag.viewprev)
--tasklist = {}
--tasklist.buttons = awful.util.table.join(

--awful.button({ }, 1, function (c)
--      if not c:isvisible() then
--      	awful.tag.viewonly(c:tags()[1])
--      end
--      client.focus = c
--      c:raise()
--end),
--awful.button({ }, 3, function ()
--      if instance then
--      	instance:hide()
--      	instance = nil
--      else
--      	instance = awful.menu.clients({ width=250 })
--      end
--end),
--awful.button({ }, 4, function ()
--      awful.client.focus.byidx(1)
--      if client.focus then client.focus:raise() end
--d),
--awful.button({ }, 5, function ()
--      awful.client.focus.byidx(-1)
--      if client.focus then client.focus:raise() end
--end))

--r s = 1, screen.count() do
--      -- Create a promptbox for each screen
--      mypromptbox[s] = awful.widget.prompt() --{ layout = awful.widget.layout.horizontal.leftright })
--      -- Create an imagebox widget which will contains an icon indicating which layout we're using.
--      -- We need one layoutbox per screen.
--      mylayoutbox[s] = awful.widget.layoutbox(s)
--      mylayoutbox[s]:buttons(awful.util.table.join(
--      awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
--      awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
--      awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
--      awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
--      -- Create a taglist widget
--      mytaglist[s] = awful.widget.taglist(s, mytaglist.buttons)

--      -- Create a tasklist widget
--      mytasklist[s] = awful.widget.tasklist(function(c)
--      	return awful.widget.tasklist.label.currenttags(c, s)
--      end, mytasklist.buttons)

--      -- Create the wibox
--      mywibox[s] = awful.wibox({ position = "top", screen = s })
--      -- Add widgets to the wibox - order matters
--      mywibox[s].widgets = {
--      	{
--      		mylauncher,
--      		mytaglist[s],
--      		mypromptbox[s],
--			layout = awful.widget.layout.horizontal.leftright
--      	},
--      	mylayoutbox[s],
--      	mytextclock,
--      	s == 1 and mysystray or nil,
--      	mytasklist[s],
--		layout = awful.widget.layout.horizontal.rightleft
--	}
--end
