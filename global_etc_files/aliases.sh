
###############################################
###      My System-wide Bash aliases         ###
################################################



#####################
# Standard Aliases
alias du='nice -n 19 ionice -c2 -n7 du -h'
alias df='dfc -p -tmpfs,udev,rootfs' #'df -h --exclude-type=tmpfs  --exclude-type=rootfs --exclude-type=udev --exclude-type=dev'
alias ls='ls -h --color -F' #F=show indicator (*/=>@|)
alias sl='ls -h --color -F'
alias cp='nice -n 19 ionice -c2 -n7 cp -i'
alias mv='nice -n 19 ionice -c2 -n7 mv -i'
alias ll='ls -lh'

################
# Extra aliases
alias ccp='rsync --recursive --progress --partial --human-readable'
# alias mmv='rsync --recursive --progress --partial --human-readable --remove-source-files'
alias partitions='lsblk -o NAME,RM,SIZE,FSTYPE,MOUNTPOINT'


################
# Basic Applications

alias document.editor='lowriter'
alias spreadsheet.editor='localc'
alias image.viewer='geeqie'
alias mixer='alsamixer'
alias trash-restore='restore-trash'
alias disk.utility='palimpsest'
alias schematic.editor='Fritzing'

################
# Prefered apps
alias ffmpeg='/opt/ffmpeg-2.0.1/bin/ffmpeg'
alias ffprobe='/opt/ffmpeg-2.0.1/bin/ffprobe'

alias rm='/usr/bin/trash-put'
alias rmperm='/bin/rm -rf'

alias avidemux2='avidemux2_gtk'
alias unrar='nice -n 19 ionice -c2 -n7 7z x'
alias unzip='nice -n 19 ionice -c2 -n7 7z x'


################
# Improvments
alias mplayer='mplayer -alang en'
alias lynx='lynx -accept_all_cookies'
alias ps='ps x o pid,comm,args,pcpu,size,state' #prints really nice
#alias pss='ps o user,pid,comm,args,pcpu,size,state -C bash -N -C xterm |egrep "$USER|USER"|sed "s/^........//"'
alias nano='nano -w -m' #mouse && nowrap
# alias i686-w64-mingw32-g++='x86_64-w64-mingw32-g++'

#################
# quick shortcuts
alias mp='mplayer'
alias dvda='dvd -a'
alias dvd1='dvd -t 1'
alias dvd2='dvd -t 2'
alias dvd3='dvd -t 3'
alias dvd4='dvd -t 4'
alias dvd5='dvd -t 5'
alias fmplayer='mplayer -fs'
alias smplayer='mplayer -shuffle'
alias lmplayer='mplayer -softvol -softvol-max 300'
alias findtext='grep -lr'
# alias resolution_restore='xrandr -s 1280x1024@75'
alias sourceftpweb='lftp sftp://zymos000,openiconlibrary@frs.sourceforge.net -e "cd /home/groups/o/op/openiconlibrary/htdocs/"'
alias sourceftpfile='lftp sftp://zymos000,openiconlibrary@frs.sourceforge.net -e "cd /home/frs/project/o/op/openiconlibrary"'
alias pod='mount /mnt/ipod;gtkpod'
alias whatsmyip='echo `wget -q -O - http://www.whatismyip.org`'
alias boinc_percent_done="boinccmd --get_state|grep 'fraction done'|sed 's/^.*: //'|awk '{printf(\"%.1f\n\", 100 * \$1)}'"
	# run as: boinccmd --get_state|grep 'fraction done'|sed 's/^.*: //'|awk '{printf("%.1f\n", 100 * $1)}' 
# alias netflix='WINEPREFIX=/home/zymos/.wine-netflix-git /opt/wine-netflix-git/bin/wine C:\\Program\ Files\\Mozilla\ Firefox\\firefox.exe netflix.com'
# alias netflix='WINEDEBUG=-all WINEARCH=win32 \
# WINEPREFIX=~/.netflix-wine \
# wine ~/.netflix-wine/drive_c/Program\ Files/Mozilla\ Firefox/firefox.exe http://netflix.com/'

#################
# Multi-Command
alias vbox='sudo modprobe vboxdrv;(VBoxManage startvm 513602ae-0782-4bb7-9c8b-449df3a205c5 &)'
alias vboxmoduals='for m in vbox{drv,netadp,netflt}; do modprobe $m; done'

alias winekillall="wineserver -k; killall -9 wine wineserver; for i in `ps ax|egrep "*\.exe"|grep -v 'egrep'|awk '{print $1 }'`;do kill -9 $i;done"


#################
# Audiobook
alias m4b2mp3='for m4b in $(ls -1 *.m4b); do ffmpeg -i "$m4b" -acodec libmp3lame -ar 22050 -ab 64k "${m4b}.mp3"; done;id3v2 --TCON "audiobook" *.mp3'
alias m4a2mp3='for m4a in $(ls -1 *.m4a); do ffmpeg -i "$m4a" -acodec libmp3lame -ar 22050 -ab 64k "${m4a}.mp3"; done;id3v2 --TCON "audiobook" *.mp3'
alias id3audiobook='id3v2 --TCON "audiobook" *.mp3'
alias audiobook_improve_voice='mkdir mod;for mp3 in $(ls -1 --color=none *.mp3); do sox -S "${mp3}" -b 16 -c 1 -C 64 "mod/${mp3}_mod.mp3" bandpass 1200 1600h rate 22050 norm; done'


##################
# mounts
alias android-connect="mtpfs -o allow_other /mnt/android"
alias android-disconnect="fusermount -u /mnt/android"

##################
# pipe
alias nocolor="sed -r \"s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g\""

#################
# Shutdown
# alias shut='xfce4-session-logout --halt --fast'
# alias unshut='sudo /sbin/shutdown -c'
# alias ushut='sudo /sbin/shutdown -c'
alias z='bed 1h'


####################
# Run out of shell
# alias rtorrentx='(rxvt -e "rtorrent" &)'
function gimp {	command gimp "$@" & }
function inkscape {	command inkscape "$@">>/tmp/x-programs-error.log 2>&1& }
function geeqie {	command geeqie "$@" >>/tmp/x-programs-error.log 2>&1 & }
function gvim {	command gvim "$@" >>/tmp/x-programs-error.log 2>&1 & }
function localc {	command localc "$@" >>/tmp/x-programs-error.log 2>&1 & }
function lowriter {	command lowriter "$@" >>/tmp/x-programs-error.log 2>&1 & }
# function arduino {	command /opt/arduino/arduino "$@" >>/tmp/x-programs-error.log 2>&1 & }
# alias transmission='(transmission-gtk&)'
# alias azureus='(azureus &> /tmp/azureus.log &)'



####################
# Other
function rpmextract { command rpm2cpio "$@" | cpio -idmv; }
# function df { /bin/df -h --exclude-type=tmpfs  --exclude-type=rootfs "$@" | perl -pi -e 's/\s*//;s/192.168.0.222:\/mnt\/HD/nfs:/;s/(_.2\/)\n/vol\1           /'; }


################
# NOT-ROOT Aliases
if [[ $USER != root ]];then
	alias clamscan='echo "Log -> /tmp/clamav-scan.log"; clamscan -r -l /tmp/clamav-scan.log'
	alias boincstart='sudo /etc/init.d/boinc start'
	alias boincstop='sudo /etc/init.d/boinc stop'
# 	alias lsusb='/usr/sbin/lsusb'
	alias lspci='/usr/sbin/lspci'
	alias nethogs='sudo /usr/sbin/nethogs'
#	alias sacred='boincstop;cd /home/zymos/.wine/drive_c/Program\ Files/Ascaron\ Entertainment/Sacred\ Underworld/; wine sacred.exe >> /tmp/wine.log ;boincstart '
#	alias wow='wine "C:Program Files/World of Warcraft2/Wow.exe" -opengl'
#	alias wow='wine /home/zymos/.wine/drive_c/Program\ Files/AutoIt3/AutoIt3.exe C:/wow_auto_login.au3 -opengl'
#	alias diablo='wine /mnt/oracle/installs/Program\ Files/Diabloi\ II/D2Loader-1.11b.exe'
#	alias zangband='/usr/games/bin/zangband -mgcu -w'
#	alias sacredalign='wmctrl -r "Wine desktop" -e 0,0,0,1024,768'
	alias nwn='wine ~/.wine/drive_c/NeverwinterNights/NWN/nwn.exe'
	alias icewind='cd /home/zymos/.wine/drive_c/Program\ Files/Black\ Isle/Icewind\ Dale/;wine IDMain.exe'
fi



#################
# ROOT Aliases
if [[ $USER == root ]];then
	alias grub2-update-conf-j='grub2-mkconfig -o /boot/grub/grub.cfg'
	alias clamscan='clamscan -r -l /var/log/clamav/scan.log'
	alias eworld='emerge -u world'
	alias ereminder_for_cleanup='echo emerge --update --deep --newuse world; echo emerge --depclean; echo revdep-rebuild'
	alias esync='eix-sync'
	alias enews='eselect news read new'
	alias restartNet0='/etc/init.d/net.eth0 stop ; /etc/init.d/net.lo stop ; /etc/init.d/net.lo start; /etc/init.d/net.eth0 start'
	alias restartNet1='/etc/init.d/net.eth1 stop ; /etc/init.d/net.lo stop ; /etc/init.d/net.lo start; /etc/init.d/net.eth1 start'
	alias boincstart='/etc/init.d/boinc start'
	alias boincstop='/etc/init.d/boinc stop'
	alias perl_cpan_sh='perl -MCPAN -e shell'
fi

export ALIASES_SET="true"
