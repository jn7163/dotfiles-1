local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local vicious = require("vicious")
require('calendar2')

if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end


beautiful.init(awful.util.getdir("config") .. "/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "xterm"
browser = "firefox"
screenshot = "deepin-screenshot"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"
altkey = "Mod1"
modkey = "Mod4"

local layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating
}

if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end

tags = {
  names = { "Terminal", "Internet", "Program", "Documents", "Media", "Virtual", "Misc",
  },
  layout = {
    layouts[5], layouts[9], layouts[9], layouts[9], layouts[12], layouts[12], layouts[12],
}}

for s = 1, screen.count() do
    tags[s] = awful.tag(tags.names, s, tags.layout)
end

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "Manual", terminal .. " -e man awesome" },
   { "Edit Config", editor_cmd .. " " .. awesome.conffile },
   { "Restart", awesome.restart },
   { "Quit", awesome.quit }
}

accessories = {
   { "Xterm", "xterm" },
   { "Pcmanfm", "pcmanfm" },
   { "Gpicview", "gpicview" },
   { "BC", "xterm -e bc" },
   { "Zim", "zim" }
}

internet = {
    { "Mozilla Firefox", "firefox" },
    { "Google Chrome","google-chrome-proxy" },
    { "Opera", "opera" },
    { "Canto", "xterm -e canto -u" },
    { "GtkQQ", "gtkqq" },
    { "Openfetion", "openfetion" },
    { "Irssi", "xterm -e screen irssi" },
    { "Mutt", "xterm -e mutt" },
    { "Gtmess", "xterm -e gtmess" }
}

editors = {
    { "Leafpad", "leafpad" },
    { "Python Shell", "idle3.2" },
    { "Emacs", "emacs" }
}

office = {
    { "WPS Writer", "wps" },
    { "WPS Presentation", "wpp" },
    { "Gnumeric", "gnumeric" }
}

media = {
    { "Gimp", "gimp" },
    { "Cheese", "cheese" },
    { "Deadbeef", "deadbeef" },
    { "Moc", "xterm -e mocp" }
}

games = {
    { "Chromium B.S.U", "chromium-bsu" },
}

systemtools = {
    { "VirtualBox", "VirtualBox" },
    { "AlsaMixer", "xterm -e alsamixer" },
    { "Htop", "xterm -e htop" },
    { "Fcitx Config", "fcitx-configtool" },
    { "Qt Configuration", "qtconfig" }
}

mymainmenu = awful.menu({ items = { { "Accessories", accessories, beautiful.awesome_icon },
                                    { "Internet", internet, beautiful.awesome_icon },
                                    { "Editors", editors, beautiful.awesome_icon },
                                    { "Office", office, beautiful.awesome_icon },
                                    { "Games", games, beautiful.awesome_icon },
                                    { "Media", media, beautiful.awesome_icon },
                                    { "System Tools", systemtools, beautiful.awesome_icon },
                                    { "Awesome", myawesomemenu, beautiful.awesome_icon }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

separator = wibox.widget.textbox()
separator:set_markup(" | ")
space = wibox.widget.textbox()
space:set_markup(" ")

-- {{{ MPD
mpd = wibox.widget.textbox()
vicious.register(mpd, vicious.widgets.mpd,
    function (widget, args)
        if args["{state}"] == ("Stop" or "N/A") then
            return ""
        else
            return ' <span color="gold">MPD Play: '.. args["{Artist}"]..' - '.. args["{Title}"] ..'</span>'
        end
    end, 2)
-- }}}

-- {{{ Wifi
wifi = wibox.widget.textbox()
vicious.register(wifi, vicious.widgets.wifi,
    function (widget, args)
        if args["{ssid}"] == "N/A" then
            return ""
        else
            return "<span color='moccasin'>" .. args["{ssid}"] .. ": </span>"
        end
    end, 5, "wlan0")
-- }}}

-- {{{ ip
--ip = wibox.widget.textbox()
--vicious.register(ip, vicious.widgets.wifi,
--    function (widget, args)
--        function ip_addr()
--            local ip = io.popen("ip addr show wlan0 | grep 'inet '")
--            local addr = ip:read("*a")
--            ip:close()
--            addr = string.match(addr, "%d+.%d+.%d+.%d+")
--            return addr
--            end
--    end, 5, "wlan0")
-- }}}

-- {{{ Net
net = wibox.widget.textbox()
    function netspeed(format)
        args = vicious.widgets.net(format)
        netspeed_tab = {}
        netspeed_tab['{down_kb}'] = args['{eth0 down_kb}'] + args['{wlan0 down_kb}']
        netspeed_tab['{up_kb}'] = args['{eth0 up_kb}'] + args['{wlan0 up_kb}']
        return netspeed_tab
    end
vicious.register(net, netspeed, "${up_kb}KiB/s↑ ${down_kb}KiB/s↓", 2)
-- }}}

-- {{{ GMAIL
--[[ touch ~/.netrc file with [machine mail.google.com login user password pass], returns a table with string keys: {count} and {subject}
mygmail = wibox.widget.textbox()
vicious.register(mygmail, vicious.widgets.gmail, "<span color='moccasin'>GMail:</span> <span color='gold'>${count}</span> New", 61)
--]]
-- }}}

-- {{{ CPU
cpu = wibox.widget.textbox()
cpu:set_markup("CPU:")
cpugraph = awful.widget.graph()
cpugraph:set_width (20):set_height (14)
cpugraph:set_background_color ("#494B4F"):set_color ("#FF5656")
--cpugraph:set_gradient_colors ({ "#AECF96", "#88A175", "#FF5656" })
--cpugraph:set_gradient_angle (180):set_scale (true)
vicious.register(cpugraph, vicious.widgets.cpu, "$1", 2)
cputemp = wibox.widget.textbox({ name = "thermalwidget", align = 'right' })
vicious.register(cputemp, vicious.widgets.thermal, "$1℃", 5, "thermal_zone0")
cpugraph:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("xterm -e htop", true) end)
))
-- }}}

-- {{{ MEM
ram = wibox.widget.textbox()
vicious.register(ram, vicious.widgets.mem, "Ram: $1%", 2)
ram:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("xterm -e htop", true) end)
))
-- }}}

-- {{{ Battery
bat = wibox.widget.textbox()
vicious.register(bat, vicious.widgets.bat, "Bat: $2%", 60, "BAT0")
-- }}}

-- {{{ Volume
vol = wibox.widget.textbox()
vicious.register(vol, vicious.widgets.volume, "Vol: $2 $1%", 2, "Master")
vol:buttons(awful.util.table.join(
   awful.button({ }, 1, function () awful.util.spawn("amixer -q sset Master toggle") end),
   awful.button({ }, 4, function () awful.util.spawn("amixer -q sset Master 1dB+", false) end),
   awful.button({ }, 5, function () awful.util.spawn("amixer -q sset Master 1dB-", false) end)
))
-- }}}

-- {{{ UPTime
uptime = wibox.widget.textbox()
vicious.register(uptime, vicious.widgets.uptime, "UpTime: $1d $2h:$3m", 60)
-- }}}

-- {{{ OS
--os = wibox.widget.textbox()
--vicious.register(os, vicious.widgets.os, "$1 $2")
-- }}}

-- {{{ mytextclock
mytextclock = wibox.widget.textbox()
vicious.register(mytextclock, vicious.widgets.date, "%a, %D, <span color='moccasin'>%R:%S</span>", 1)
--calendar2.addCalendarToWidget(mytextclock, "<span color='moccasin'>%s</span>")
-- }}}


-- Create a wibox for each screen and add it
my_top_wibox = {}
my_bottom_wibox = {}
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
    my_top_wibox[s] = awful.wibox({ position = "top", height= 14, screen = s })
    my_bottom_wibox[s] = awful.wibox({ position = "bottom", height= 14, screen = s })

    -- Widgets that are aligned to the left
    local top_left_layout = wibox.layout.fixed.horizontal()
    top_left_layout:add(mylauncher)
    top_left_layout:add(mytaglist[s])
    top_left_layout:add(mypromptbox[s])
    local bottom_left_layout = wibox.layout.fixed.horizontal()
    bottom_left_layout:add(mpd)

    -- Widgets that are aligned to the right
    local top_right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then top_right_layout:add(wibox.widget.systray()) end
    top_right_layout:add(separator)
    top_right_layout:add(cpu)
    top_right_layout:add(cpugraph)
    top_right_layout:add(cputemp)
    top_right_layout:add(separator)
    top_right_layout:add(ram)
    top_right_layout:add(separator)
    top_right_layout:add(vol)
    top_right_layout:add(separator)
    top_right_layout:add(bat)
    top_right_layout:add(separator)
    top_right_layout:add(mytextclock)
    top_right_layout:add(separator)
    top_right_layout:add(mylayoutbox[s])
    local bottom_right_layout = wibox.layout.fixed.horizontal()
    bottom_right_layout:add(wifi)
    bottom_right_layout:add(net)
    bottom_right_layout:add(separator)
    bottom_right_layout:add(uptime)

    -- Now bring it all together (with the tasklist in the middle)
    local top_layout = wibox.layout.align.horizontal()
    top_layout:set_left(top_left_layout)
    top_layout:set_middle(mytasklist[s])
    top_layout:set_right(top_right_layout)
    local bottom_layout = wibox.layout.align.horizontal()
    bottom_layout:set_left(bottom_left_layout)
    bottom_layout:set_right(bottom_right_layout)

    my_top_wibox[s]:set_widget(top_layout)
    my_bottom_wibox[s]:set_widget(bottom_layout)
end
-- }}}

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
    awful.key({ "Mod1", "Control" }, "a", function () awful.util.spawn(screenshot) end),
    awful.key({                   }, "F1",function () awful.util.spawn(terminal) end),
    awful.key({                   }, "F2",function () awful.util.spawn(browser) end),
    awful.key({                   }, "F3",function () awful.util.spawn("emacs") end),
    awful.key({                   }, "XF86AudioLowerVolume",    function () awful.util.spawn( "amixer -q sset Master 1dB-" ) end),
    awful.key({                   }, "XF86AudioRaiseVolume",    function () awful.util.spawn( "amixer -q sset Master 1dB+" ) end),
    awful.key({                   }, "XF86AudioMute",           function () awful.util.spawn( "amixer -q sset Master toggle" ) end),
    awful.key({                   }, "XF86AudioNext",           function () awful.util.spawn( "mpc next" ) end),
    awful.key({                   }, "XF86AudioPrev",           function () awful.util.spawn( "mpc prev" ) end),
    awful.key({                   }, "XF86AudioPlay",           function () awful.util.spawn( "mpc play" ) end),
    awful.key({                   }, "XF86AudioStop",           function () awful.util.spawn( "mpc stop" ) end),

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
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

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

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber))
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

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons } },
     { rule = { class = "Firefox" }, properties = { tag = tags[1][2] } },
     { rule = { class = "Opera" }, properties = { tag = tags[1][2] } },
     { rule = { class = "Google-chrome" }, properties = { tag = tags[1][2] } },
     { rule = { name = "Python Shell" }, properties = { tag = tags[1][3] } },
     { rule = { class = "Emacs" }, properties = { tag = tags[1][3] } },
     { rule = { class = "Leafpad" }, properties = { tag = tags[1][4] } },
     { rule = { class = "Zim" }, properties = { tag = tags[1][4] } },
     { rule = { class = "MuPDF" }, properties = { tag = tags[1][4] } },
     { rule = { class = "Gnumeric" }, properties = { tag = tags[1][4] } },
     { rule = { class = "Gpicview" }, properties = { tag = tags[1][4] } },
     { rule = { class = "Wps" }, properties = { tag = tags[1][4] } },
     { rule = { class = "Wpp" }, properties = { tag = tags[1][4] } },
     { rule = { class = "Xchm" }, properties = { tag = tags[1][4] } },
     { rule = { class = "mplayer2" }, properties = { tag = tags[1][5] } },
     { rule = { class = "Gnome-mplayer" }, properties = { tag = tags[1][5] } },
     { rule = { class = "Display" }, properties = { tag = tags[1][5] } },
     { rule = { class = "Deadbeef" }, properties = { tag = tags[1][5] } },
     { rule = { class = "Cheese" }, properties = { tag = tags[1][5] } },
     { rule = { class = "MyPaint" }, properties = { tag = tags[1][5] } },
     { rule = { class = "Gimp" }, properties = { tag = tags[1][5] } },
     { rule = { class = "Rrip_gui" }, properties = { tag = tags[1][5] } },
     { rule = { class = "VirtualBox" }, properties = { tag = tags[1][6] } },
     { rule = { class = "Xephyr" }, properties = { tag = tags[1][6] } },
     { rule = { class = "Pcmanfm" }, properties = { tag = tags[1][7] } },
     { rule = { class = "chromium-bsu" }, properties = { tag = tags[1][7] } },
     { rule = { class = "Xarchiver" }, properties = { tag = tags[1][7] } },
     { rule = { class = "Openfetion" }, properties = { tag = tags[1][7] } },
     { rule = { class = "Gtkqq" }, properties = { tag = tags[1][7] } },
     { rule = { class = "Gtconfig" }, properties = { tag = tags[1][7] } },
     { rule = { class = "Abp" }, properties = { tag = tags[1][7] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local title = awful.titlebar.widget.titlewidget(c)
        title:buttons(awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                ))

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(title)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

os.execute("fcitx -d")
os.execute("conky &")
--os.execute("compton -S -Cc -fF -I-10 -O-10 -D1 -t-2 -l-3 -r4 &")
--os.execute("xcompmgr -Ss -n -Cc -fF -I-10 -O-10 -D1 -t-3 -l-4 -r4 &")

