# Auto-generated by canto because you don't have one.
# Please copy to/create ~/.canto/conf.py

link_handler("w3m \"%u\"", text=True)
#link_handler("chromium \"%u\"")
image_handler("feh \"%u\"", fetch=True)
link_handler("mplayer -someoptions \"%u\"", ext="mp3")
link_handler("mupdf \"%u\"", ext="pdf", fetch=True)

never_discard("unread")

# Selected Feeds
default_rate(30)
#r = get_default_renderer()
#add_info(r, "Author", caption="by: ")
default_keep(50)
#add("http://www.archlinux.org/feeds/news/", tags=[None, "Linux"])
add("http://www.linuxsir.org/bbs/servlet/Rss?forumid=96", tags=[None, "Linux"])
add("http://www.linuxsir.org/bbs/servlet/Rss?forumid=59", tags=[None, "Linux"])
#add("http://www.cnbeta.com/backend.php", keep=200, tags=[None, "News"])
#add("http://bbs.operachina.com/rss.php?f=72&mode=topics", tags=[None, "Browser"])
#...

colors[0] = (2, -1)
colors[1] = (5, -1)
colors[2] = (6, -1)

#def resize_hook (cfg):
#    cfg.reader_orientation = "left"
#    cfg.reader_lines = cfg.width
#    cfg.columns = (cfg.width / 2) / 65
