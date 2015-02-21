#!/bin/bash


######################
# Terminals
#

# xterm -geometry 80x24+0+174 &
# xterm -geometry 80x24+0+516 &
# xterm -geometry 80x24+0-0 &
# xterm -geometry 80x24+486-0 &

# gnome-terminal --geometry 161x43+6+521 -e screen &
# gnome-terminal --geometry 80x47+6+521 -e screen &
gnome-terminal --geometry 80x47+6+521  -e /usr/scripts/tmuxlayout.sh

# gnome-terminal --geometry 80x24+0+174 &
# gnome-terminal --geometry 80x24+0+516 &
gnome-terminal --geometry 80x24+0-0 &
# gnome-terminal --geometry 80x24+486-0 &


######################
# rtorrent stuff
# if [ -a ~/Desktop/torrents/sessions/rtorrent.lock ];then 
	#did it close prperly?
	# echo "Didn't close, fixing it -- `date`" >> ~/Desktop/torrents/sessions/log
	# rm -f ~/Desktop/torrents/sessions/rtorrent.lock
# fi
# rtorrentx #loading rtorrent in seperate rxvt 
#wmctrl -r rtorrent -t 1 #this is now done by .config/openbox/autostart.sh


# touch /tmp/rss.log
# touch /tmp/rss2.log
# xset +dpms

########################
# X-background

# (/usr/scripts/simple_rss_reader_loop.pl &)
# numlockx on
# conky -d >>/tmp/x-programs-error.log 2>&1 & # 1st conky on bottom left
# conky -d -c .conkyrc2 >>/tmp/x-programs-error.log 2>&1 & # 2nd conky bottom right
# conky -d -c .conkyrc.rss >>/tmp/x-programs-error.log 2>&1 & # 3rd conky
# xnots >>/tmp/x-programs-error.log 2>&1 & #desktop notes
# (sleep 1m && irexec >>/tmp/ir.log 2>&1 &) #LIRC




################################
# GUI Default programs
#
# qbittorrent >> /tmp/x-programs-error.log 2>&1 &
transmission-gtk >> /tmp/x-programs-error.log 2>&1 &


#this moves rtorrent window to the second desktop
# sleep 30 && wmctrl -r qBittorrent -t 1& 

# pidgin >> /tmp/x-programs-error.log 2>&1 &
firefox >> /tmp/x-programs-error.log 2>&1 &

keepass2 /mnt/tb2/online.storage/Dropbox/test.kdbx --keyfile:"/mnt/tb2/online.storage/copy.com/test.key" --pw:cracker >> /tmp/x-programs-error.log 2>&1 &



########################################
# Update online storage (once a month)
#  google drive, dropbox, copy.com
#
if [ `date +%d` -eq 25 ]
then
	# ( xterm -T "Google Drive Update" -hold -e "cd /mnt/500patato/online.storage/gdrive/;pwd;grive" & )
	( dropbox & )
	( /opt/copy.com/x86_64/CopyAgent & )
fi



############################
# Minimize and other macros
#
# xdotool windowminimize `xdotool search -name "qBittorrent v"`
# xdotool windowminimize `xdotool search -name " - KeePass Password Safe"`

###########################
# shove to desktop 2

sleep 20s
wmctrl -r KeePass -t 1
wmctrl -r Transmission -t 1

