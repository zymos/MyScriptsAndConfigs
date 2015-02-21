################################################
###      My System-wide Bash ENV VARS        ###
################################################


export EDITOR=vim
export BROWSER=firefox
export PAGER=less


#firefox
export MOZILLA_FIVE_HOME=/usr/lib/mozilla
export MOZ_PLUGIN_PATH="/usr/lib/mozilla/"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/mozilla

# export OPERA_KEEP_BLOCKED_PLUGIN="yes" 

# Wine
export WINEDEBUG=-all

export LINGUAS=en
# export LANG=en_US

#android
export PATH=$PATH:/usr/scripts:/usr/lib/android-sdk-linux/tools:/usr/lib/android-sdk-linux/platform-tools



# fix some color probs with vim->lightline(statusline)
export TERM=xterm-256color


# for some of my script
export FFMPEG_CMD="/opt/ffmpeg-2.0.1/bin/ffmpeg"
export NICENESS_CMD="nice -n 19 ionice -c2 -n7";

# export MPV_HOME="~/.config/mpv"

export ENV_VAR_SET="true"
