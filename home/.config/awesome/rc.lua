require("awful")
require("awful.autofocus")
require("awful.rules")
require("beautiful")
require("naughty")
require("vicious")
require('calendar2')

beautiful.init(awful.util.getdir("config") .. "/theme.lua")

terminal = "xterm"
browser = "firefox"
screenshot = "deepin-screenshot"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"
altkey = "Mod1"

layouts =
{
    awful.layout.suit.tile,             --1
    awful.layout.suit.tile.left,        --2
    awful.layout.suit.tile.bottom,      --3
    awful.layout.suit.tile.top,         --4
    awful.layout.suit.fair,             --5
    awful.layout.suit.fair.horizontal,  --6
    awful.layout.suit.spiral,           --7
    awful.layout.suit.spiral.dwindle,   --8
    awful.layout.suit.max,              --9
    awful.layout.suit.max.fullscreen,   --10
    awful.layout.suit.magnifier,        --11
    awful.layout.suit.floating          --12
}

tags = {
  names = { "Terminal", "Internet", "Program", "Documents", "Media", "Virtual", "Misc",
  },
  layout = {
    layouts[5], layouts[9], layouts[9], layouts[9], layouts[12], layouts[12], layouts[12],
}}

for s = 1, screen.count() do
    tags[s] = awful.tag(tags.names, s, tags.layout)
end

awesomemenu = {
   { "Manual", terminal .. " -e man awesome" },
   { "Edit Config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
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
    { "Chromium","chromium" },
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
    { "Leafpad", "leafpad" },
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
                                    { "Awesome", awesomemenu, beautiful.awesome_icon }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })

spacer    = widget({ type = "textbox" })
spacer.text     = " "
separator = widget({ type = "textbox" })
separator.text  = "|"

-- {{{ MPD
mpdwidget = widget({ type = "textbox" })
vicious.register(mpdwidget, vicious.widgets.mpd,
    function (widget, args)
        if args["{state}"] == ("Stop" or "N/A") then
            return ""
        else
            return ' <span color="gold">MPD Play: '.. args["{Artist}"]..' - '.. args["{Title}"] ..'</span>'
        end
    end, 2)
-- }}}

-- {{{ Wifi
wifiwidget = widget({ type = "textbox" })
vicious.register(wifiwidget, vicious.widgets.wifi,
    function (widget, args)
        if args["{ssid}"] == "N/A" then
            return ""
        else
            return "<span color='moccasin'>" .. args["{ssid}"] .. ": </span>"
        end
    end, 5, "wlan0")
-- }}}

-- {{{ ip
--ipwidget = widget({ type = "textbox" })
--vicious.register(ipwidget, vicious.widgets.wifi,
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
netwidget = widget({ type = "textbox", name = "mynetwidget" })
    function netspeed(format)
        args = vicious.widgets.net(format)
        netspeed_tab = {}
        netspeed_tab['{down_kb}'] = args['{eth0 down_kb}'] + args['{wlan0 down_kb}']
        netspeed_tab['{up_kb}'] = args['{eth0 up_kb}'] + args['{wlan0 up_kb}']
        return netspeed_tab
    end
vicious.register(netwidget, netspeed, "${up_kb}KiB/s↑ ${down_kb}KiB/s↓", 2)
-- }}}

-- {{{ GMAIL
-- touch ~/.netrc file with [machine mail.google.com login user password pass], returns a table with string keys: {count} and {subject}
--mygmail = widget({ type = "textbox" })
--vicious.register(mygmail, vicious.widgets.gmail, "<span color='moccasin'>GMail:</span> <span color='gold'>${count}</span> New", 61)
-- }}}

-- {{{ CPU
cpu = widget({ type = 'textbox', name='cpu' })
cpu.text = 'CPU:'
cpugraph = awful.widget.graph()
cpugraph:set_width (20):set_height (14)
cpugraph:set_background_color ("#494B4F"):set_color ("#FF5656")
cpugraph:set_gradient_colors ({ "#AECF96", "#88A175", "#FF5656" })
cpugraph:set_gradient_angle (180):set_scale (true)
vicious.register(cpugraph, vicious.widgets.cpu, "$1", 2)
cputempwidget = widget({ type = "textbox", name = "thermalwidget", align = 'right' })
vicious.register(cputempwidget, vicious.widgets.thermal, "$1℃", 5, "thermal_zone0")
cpugraph.widget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("xterm -e htop", true) end)
))
-- }}}

-- {{{ MEM
ramwidget = widget({ type = "textbox" })
vicious.register(ramwidget, vicious.widgets.mem, "Ram: $1%", 2)
rambar = awful.widget.progressbar()
rambar:set_width (8):set_height (14)
rambar:set_vertical(true)
rambar:set_background_color ("#494B4F"):set_color ("#AECF96")
rambar:set_border_color(nil)
rambar:set_gradient_colors ({ "#AECF96", "#88A175", "#FF5656" })
vicious.register(rambar, vicious.widgets.mem, "$1", 13)
rambar.widget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("xterm -e htop", true) end)
))
-- }}}

-- {{{ Filesystem info
fsroot = widget({ type = 'textbox', name='fsroot' })
fsroot.text = 'ROOT:'
fshome = widget({ type = 'textbox', name='fshome' })
fshome.text = 'HOME:'
fsmedia = widget({ type = 'textbox', name='fsmedia' })
fsmedia.text = 'Media:'
fs = {
    r = awful.widget.progressbar(), h = awful.widget.progressbar(),
    m = awful.widget.progressbar()
}
for _, w in pairs(fs) do
    w:set_width(4):set_height(14):set_vertical(true)
    w:set_background_color("#494B4F"):set_color("#AECF96")
    w:set_border_color(nil)
    w:set_gradient_colors({ "#AECF96", "#88A175", "#FF5656" })
    --w.widget:buttons(awful.util.table.join(
    --    awful.button({ }, 1, function () awful.util.spawn("pcmanfm", false) end)
    --))
end
vicious.register(fs.r, vicious.widgets.fs, "${/ used_p}",             599)
vicious.register(fs.h, vicious.widgets.fs, "${/home used_p}",         599)
vicious.register(fs.m, vicious.widgets.fs, "${/mnt/Media used_p}",    599)
-- }}}

-- {{{ Battery
batwidget = widget({ type = 'textbox', name = 'batwidget'})
vicious.register(batwidget, vicious.widgets.bat, "Bat: $1", 60, "BAT0")
batbar = awful.widget.progressbar()
batbar:set_width(6):set_height(14):set_vertical(true)
batbar:set_background_color("#494B4F"):set_color("#AECF96")
batbar:set_border_color(nil)
batbar:set_gradient_colors({ "#AECF96", "#88A175", "#FF5656" })
vicious.register(batbar, vicious.widgets.bat, "$2", 61, "BAT0")
-- }}}

systray = widget({ type = "systray" })

-- {{{ Volume
volbar = awful.widget.progressbar()
volbar:set_width(8):set_height(14):set_vertical(true)
volbar:set_background_color("#494B4F"):set_color("#AECF96")
volbar:set_border_color(nil)
volbar:set_gradient_colors({ "#AECF96", "#88A175", "#FF5656" })
vicious.register(volbar, vicious.widgets.volume, "$1", 2, "Master")
volbar.widget:buttons(awful.util.table.join(
   awful.button({ }, 1, function () awful.util.spawn("amixer -q sset Master toggle") end),
   awful.button({ }, 4, function () awful.util.spawn("amixer -q sset Master 1dB+", false) end),
   awful.button({ }, 5, function () awful.util.spawn("amixer -q sset Master 1dB-", false) end)
))
volwidget = widget({ type = "textbox" })
vicious.register(volwidget, vicious.widgets.volume, "Vol: $2", 2, "Master")
-- }}}

-- {{{ UPTime
uptimewidget = widget({ type = "textbox"})
vicious.register(uptimewidget, vicious.widgets.uptime, "UpTime: $1d $2h:$3m", 60)
-- }}}

-- {{{ OS
--oswidget = widget({ type = "textbox" })
--vicious.register(oswidget, vicious.widgets.os, "$1 $2")
-- }}}

-- {{{ Date
datewidget = widget({ type = "textbox", align = "right" })
vicious.register(datewidget, vicious.widgets.date, "%a, %D, <span color='moccasin'>%R</span>", 60)
-- }}}

calendar2.addCalendarToWidget(datewidget, "<span color='moccasin'>%s</span>")

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
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
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
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    my_top_wibox[s] = awful.wibox({ position = "top", height = 14, screen = s })
    my_top_wibox[s].widgets = {
                                { mylauncher, mytaglist[s], mypromptbox[s], layout = awful.widget.layout.horizontal.leftright },
                                mylayoutbox[s],
                                spacer, separator, spacer,
                                datewidget,
                                spacer, separator, spacer,
                                batbar.widget, spacer, batwidget,
                                spacer, separator, spacer,
                                volbar.widget, spacer, vol, volwidget,
                                spacer, separator, spacer,
                                rambar.widget, spacer, ramwidget,
                                spacer, separator, spacer,
                                cputempwidget, spacer, cpugraph.widget, spacer, cpu,
                                spacer, separator, spacer,
                                s == 1 and systray or nil,
                                mytasklist[s],
                                layout = awful.widget.layout.horizontal.rightleft
                            }

    my_bottom_wibox[s] = awful.wibox({ position = "bottom", height = 14, screen = s })
    my_bottom_wibox[s].widgets = {
                                    { mpdwidget, layout = awful.widget.layout.horizontal.leftright },
                                    uptimewidget,
                                    spacer, separator, spacer,
                                    fs.r.widget, spacer, fsroot, spacer, fs.m.widget, spacer, fsmedia, spacer, fs.h.widget, spacer, fshome,
                                    spacer, separator, spacer,
                                    netwidget, spacer, wifiwidget,
                                    layout = awful.widget.layout.horizontal.rightleft
                                }

end

root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",                                awful.tag.viewprev  ),
    awful.key({ modkey,           }, "Right",                               awful.tag.viewnext  ),
    awful.key({ modkey,           }, "Escape",                              awful.tag.history.restore ),
    awful.key({ "Mod1", "Control" }, "a",                       function () awful.util.spawn(screenshot) end),
    awful.key({                   }, "F1",                      function () awful.util.spawn(terminal) end),
    awful.key({                   }, "F3",                      function () awful.util.spawn("emacs") end),
    awful.key({                   }, "F2",                      function () awful.util.spawn(browser) end),
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
    awful.key({ modkey,           }, "w",   function () mymainmenu:show(true)        end),

    awful.key({ modkey, "Shift"   }, "j",   function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k",   function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j",   function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k",   function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    awful.key({ modkey,           }, "Return",  function () awful.util.spawn(terminal) end),
    awful.key({ modkey,           }, "F2",      function () awful.util.spawn(browser) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",       function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",       function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",       function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",       function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",       function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",       function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space",   function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space",   function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey },"F1",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

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
root.keys(globalkeys)

awful.rules.rules = {
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
     { rule = { class = "Firefox" }, properties = { tag = tags[1][2] } },
     { rule = { class = "Opera" }, properties = { tag = tags[1][2] } },
     { rule = { class = "Chromium-browser" }, properties = { tag = tags[1][2] } },
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
     { rule = { class = "Display" }, properties = { tag = tags[1][5] } },
     { rule = { class = "Deadbeef" }, properties = { tag = tags[1][5] } },
     { rule = { class = "Cheese" }, properties = { tag = tags[1][5] } },
     { rule = { class = "MyPaint" }, properties = { tag = tags[1][5] } },
     { rule = { class = "Gimp" }, properties = { tag = tags[1][5] } },
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

client.add_signal("manage", function (c, startup)
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)


os.execute("fcitx -d")
os.execute("conky &")
os.execute("compton -S -Cc -fF -I-10 -O-10 -D1 -t-2 -l-3 -r4 &")
--os.execute("xcompmgr -Ss -n -Cc -fF -I-10 -O-10 -D1 -t-3 -l-4 -r4 &")
