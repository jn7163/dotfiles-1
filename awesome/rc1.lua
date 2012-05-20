-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Widget Lib
require("vicious")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/home/danny/.config/awesome/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
browser = "firefox"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,            --1
    awful.layout.suit.tile.left,       --2
    awful.layout.suit.tile.bottom,     --3
    awful.layout.suit.tile.top,        --4
    awful.layout.suit.fair,            --5
    awful.layout.suit.fair.horizontal, --6
    awful.layout.suit.spiral,          --7
    awful.layout.suit.spiral.dwindle,  --8
    awful.layout.suit.max,             --9
    awful.layout.suit.max.fullscreen,  --10
    awful.layout.suit.magnifier,       --11
    awful.layout.suit.floating         --12
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {
  names = { "Term", "Internet", "Mail", "Documents", "Media", "Virtual", "Misc",
  },
  layout = {
    layouts[5], layouts[9], layouts[9], layouts[9], layouts[12], layouts[12], layouts[12],
}}

for s = 1, screen.count() do
    tags[s] = awful.tag(tags.names, s, tags.layout)
end

-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymisc = {
   { "Rxvt-unicode", "urxvt" },
   { "Xterm", "xterm" },
   { "Pcmanfm", "pcmanfm" },
   { "AlsaMixer", "urxvt -e alsamixer" },
   { "VirtualBox", "VirtualBox" }
}

myinternet = {
    { "Mozilla Firefox", "firefox" },
    { "Chromium", "chromium" },
    { "Opera", "opera" },
    { "Irssi", "urxvt -e screen irssi" },
    { "Mutt", "urxvt -e mutt" },
    { "Gtmess", "urxvt -e gtmess" },
}

myoffice = {
    { "Leafpad", "leafpad" },
    { "Xpdf", "xpdf" },
    { "Abiword", "abiword" },
    { "Gnumeric", "gnumeric" }
}

mymedia = {
    { "Cheese", "cheese" },
    { "Deadbeef", "deadbeef" },
    { "Moc", "urxvt -e mocp" },
}

mygames = {
    { "Chromium B.S.U", "chromium-bsu" },
    { "Llk_linux", "llk_linux" }
}

mymainmenu = awful.menu({ items = { { "Internet", myinternet, beautiful.awesome_icon },
                                    { "Office", myoffice, beautiful.awesome_icon },
                                    { "Games", mygames, beautiful.awesome_icon },
                                    { "Media", mymedia, beautiful.awesome_icon },
                                    { "Misc", mymisc, beautiful.awesome_icon },
                                    { "awesome", myawesomemenu, beautiful.awesome_icon }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- Separators
spacer    = widget({ type = "textbox" })
separator = widget({ type = "textbox" })
spacer.text     = " "
separator.text  = "|"

-- {{{ Wibox

-- Create a netwidget (usage)
--dnicon = widget({ type = "imagebox" })
--upicon = widget({ type = "imagebox" })
--dnicon.image = image("/home/darthlukan/.config/awesome/icons/down.png")
--upicon.image = image("/home/darthlukan/.config/awesome/icons/up.png")
-- Initialize widget
--netwidget = widget({ type = "textbox" })
-- Register widget
--vicious.register(netwidget, vicious.widgets.net, "wlan0: ${wlan0 up_kb}KiB/s / ${wlan0 down_kb}KiB/s", 1)

-- Create an fswidget (Eat your heart out Saethr!)
--fsicon = widget({ type = "imagebox" })
--fsicon.image = image("/home/darthlukan/.config/awesome/icons/disk.png")
-- Initialize widget
--fswidget = widget({ type = "textbox" })
-- Register widget
--vicious.register(fswidget, vicious.widgets.fs, "Root ${/ used}GB / ${/ avail}GB", 37)

-- Create a gmailwidget (inbox status)
--gmailicon = widget({ type = "imagebox" })
--gmailicon.image = image("/home/darthlukan/.config/awesome/icons/mail.png")
-- Initialize widget
--gmailwidget = widget({ type = "textbox" })
-- Register widget
--vicious.register(gmailwidget, vicious.widgets.gmail, "${count}", 260)

-- Create a batwidget (status chrg%)
--baticon = widget({ type = "imagebox" })
--baticon.image = image("/home/darthlukan/.config/awesome/icons/bat.png")
-- Initialize widget
--batwidget = widget({ type = "textbox" })
-- Register widget
--vicious.register(batwidget, vicious.widgets.bat, "Battery: $1 $2%", 31, "BAT0")

-- Create a memwidget (usage$ usedMB/TotalMB)
--memicon = widget({ type = "imagebox" })
--memicon.image = image("/home/darthlukan/.config/awesome/icons/mem.png")
-- Initialize widget
--memwidget = widget({ type = "textbox" })
-- Register widget
--vicious.register(memwidget, vicious.widgets.mem, "MEM: $1% ($2MiB/$3MiB)", 13)

-- Create a cpuwidget (usage%)
--cpuicon = widget({ type = "imagebox" })
--cpuicon.image = image("/home/darthlukan/.config/awesome/icons/cpu.png")
-- Initialize widget
--cpuwidget = widget({ type = "textbox" })
-- Register widget
--vicious.register(cpuwidget, vicious.widgets.cpu, "CPU: $1%:$2%", 2)

-- Create a wifiwidget
--wifiicon = widget({ type = "imagebox" })
--wifiicon.image = image("/home/darthlukan/.config/awesome/icons/wifi.png")
-- Initialize widget
--wifiwidget = widget({ type = "textbox" })
-- Register widget
--vicious.register(wifiwidget, vicious.widgets.wifi, "Wifi: ${ssid} ${link}% ${rate}MiB", 5, "wlan0")

-- Create a textclock widget
--clockicon = widget({ type = "imagebox" })
--clockicon.image = image("/home/darthlukan/.config/awesome/icons/time.png")
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
--mysystray = widget({ type = "systray" })

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
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", height = 14, screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s], 
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
--        mytextclock, spacer, clockicon, separator, batwidget, spacer, baticon, separator, upicon, netwidget, dnicon, separator, wifiwidget, spacer, wifiicon, separator, fswidget, spacer, fsicon, separator, memwidget, spacer, memicon, separator, cpuwidget, spacer, cpuicon, separator, gmailwidget, spacer, gmailicon, separator,
--        mytextclock, spacer, separator, spacer, batwidget, spacer, separator, spacer, netwidget, spacer, separator, spacer, wifiwidget, spacer, separator, spacer, memwidget, spacer, separator, spacer, cpuwidget, spacer, separator,
        mytextclock, spacer, separator,
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
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
    awful.key({ modkey,           }, "w", function () mymainmenu:show(true)        end),

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
    awful.key({ modkey,           }, "F2", function () awful.util.spawn(browser) end),
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
    awful.key({ modkey },            "F1",     function () mypromptbox[mouse.screen]:run() end),

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

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    -- Set Firefox to always map on tags number 2 of screen 1.
     { rule = { class = "Firefox" }, properties = { tag = tags[1][2] } },
     { rule = { class = "Opera" }, properties = { tag = tags[1][2] } },
     { rule = { class = "Chromium-browser" }, properties = { tag = tags[1][2] } },
     { rule = { class = "LibreOffice" }, properties = { tag = tags[1][4] } },
     { rule = { name = "LibreOffice" }, properties = { tag = tags[1][4] } },
     { rule = { class = "Xpdf" }, properties = { tag = tags[1][4] } },
     { rule = { class = "Abiword" }, properties = { tag = tags[1][4] } },
     { rule = { class = "Gnumeric" }, properties = { tag = tags[1][4] } },
     { rule = { class = "MPlayer" }, properties = { tag = tags[1][5] } },
     { rule = { class = "Deadbeef" }, properties = { tag = tags[1][5] } },
     { rule = { class = "Cheese" }, properties = { tag = tags[1][5] } },
     { rule = { class = "VirtualBox" }, properties = { tag = tags[1][6] } },
     { rule = { class = "Xephyr" }, properties = { tag = tags[1][6] } },
     { rule = { class = "Pcmanfm" }, properties = { tag = tags[1][7] } },
     { rule = { class = "chromium-bsu" }, properties = { tag = tags[1][7] } },
     { rule = { class = "Xarchiver" }, properties = { tag = tags[1][7] } },
     { rule = { class = "Openfetion" }, properties = { tag = tags[1][7] } },
     { rule = { class = "Llk_linux" }, properties = { tag = tags[1][7] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
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
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- Autostart my personal stuffs

--os.execute("tilda &")
os.execute("fcitx -d")
os.execute("xcompmgr -Ss -n -Cc -fF -I-10 -O-10 -D1 -t-3 -l-4 -r4 &")
os.execute("conky &")
