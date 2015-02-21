#!/bin/zsh

# My zsh config

#Order: /etc/zshenv then ~/.zshenv, if login shell /etc/zprofile then ~/.zprofile, if interactive shell /etc/zshrc then ~/.zshrc, If login shell, /etc/zlogin and ~/.zlogin


#Color
if [[ -f /etc/DIR_COLORS ]]; then
        eval $(dircolors -b /etc/DIR_COLORS)
else
        eval $(dircolors)
fi
export ZLSCOLORS="${LS_COLORS}"


# Term title bar
#
#   precmd (before each prompt) 
#   	shows: username@host:directory
#   preexec (after a command)
#   	shows: "#> command" if root, ">> command" if not
#   chpwd (directory is changed)
#   	shows same as precmd
case $TERM in
	*xterm*|rxvt|(dt|k|E)term|screen*)
		precmd() { print -Pn "\e]0;%n@%m:%~\a" }
		preexec () { print -Pn "\e]0;%(!.#.>)> $1\a" }
		chpwd() {
			[[ -o interactive ]] || return
			print -Pn "\e]2;%n@%m:%~\a"
		}
	;;
	# screen|screen.*)
  # local a=${${1## *}[(w)1]}  # get the command
  # local b=${a##*\/}   # get the command basename
  # a="${b}${1#$a}"     # add back the parameters
  # a=${a//\%/\%\%}     # escape print specials
  # a=$(print -Pn "$a" | tr -d "\t\n\v\f\r")  # remove fancy whitespace
  # a=${(V)a//\%/\%\%}  # escape non-visibles and print specials
     # print -Pn "\ek%-3~ $a\e\\" # set screen title.  Fix vim: ".
      # print -Pn "\e]2;%-3~ $a\a" # set xterm title, via screen "Operating System Command"
      # ;;
esac

#History
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt hist_ignore_all_dups append_history hist_ignore_space
setopt share_history inc_append_history EXTENDED_HISTORY

# Prompt
autoload -U promptinit
promptinit
if [[ $USER == "root" ]]; then
	prompt adam2 red # changes prompt red to indicate root
else
	prompt adam2
fi


# Options
setopt beep
# setopt correctall
bindkey -e
# setopt extended_glob
zstyle :compinstall filename '/home/zymos/.zshrc'


# Key Bind - fix Delete/Home/End keys
bindkey "\e[3~" delete-char # Delete
bindkey "^[[H" beginning-of-line # Home
bindkey "^[[1~" beginning-of-line # Home
bindkey "\e[1~" beginning-of-line # Home
bindkey "^[[F"  end-of-line # End
bindkey "^[[4~" end-of-line # End
bindkey "\e[4~" end-of-line # End


#Completion
autoload -Uz compinit
compinit
setopt COMPLETE_ALIASES
setopt GLOB_COMPLETE # dont complete a *
setopt LIST_BEEP # beep on ambiguous
setopt NO_AUTO_MENU # don't cycle completions
setopt completeinword
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b' # output for not found
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' #Case insensitive
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} #Colored completion
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31" # kill completion colors
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd' # kill completion output format

zstyle ':completion:*:*:vi*:*' file-sort modification
zstyle ':completion:*:*:vi*:*' ignored-patterns '*.(o|class|tar|gz|xz|bz2|avi|mp3|mp4|jpg|png|gif|ogg|bin|iso|mkv|pdf|zip|tgz|rar|part|)' # vi completion ignore binary

# compdef '_files -g "*.rar *.RAR *.zip *.ZIP *.tgz *.tar.bz2 *.tar.gz *.tar.xz"' extract # my own little command

######################
# compressed files
#
compdef '_files -g "*.rar *.RAR"' unrar # unrar override
compdef '_files -g "*.tar *.tgz *.tar.bz2 *.tar.gz *.tar.xz"' untar.sh # my own little command for tars
compdef '_files -g "*.zip *.ZIP"' unzip # unzip

# compdef eix=emerge # alias for eix to emerge

# exec 2>>(while read line; do
#  print '\e[91m'${(q)line}'\e[0m' > /dev/tty; print -n $'\0'; done &) # coloriz sterr


autoload -U zcalc # simple usefull calc

# Mods
unsetopt equals # make emerge =<pkg>-<version> work


# End of lines added by compinstall
