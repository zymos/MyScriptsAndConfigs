#!/bin/zsh

# My zsh config

#Order: /etc/zshenv then ~/.zshenv, if login shell /etc/zprofile then ~/.zprofile, if interactive shell /etc/zshrc then ~/.zshrc, If login shell, /etc/zlogin and ~/.zlogin


#Color
[ -f /etc/DIR_COLORS ] && eval $(dircolors -b /etc/DIR_COLORS)
export ZLSCOLORS="${LS_COLORS}"


# Term title bar
#   precmd (before each prompt) 
#   preexec (after a command)
#   chpwd (directory is changed)
case $TERM in
	*xterm*|rxvt|(dt|k|E)term)
		precmd() { print -Pn "\e]0;%n@%m:%~\a" }
		preexec () { print -Pn "\e]0;--> $1\a" }
		chpwd() {
			[[ -o interactive ]] || return
			print -Pn "\e]2;%n@%m:%~\a"
		}
	;;
esac

#History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt hist_ignore_all_dups appendhistory 

# Prompt
autoload -U promptinit
promptinit
prompt adam2

# Options
setopt beep
# setopt correctall
bindkey -e
# setopt extended_glob
zstyle :compinstall filename '/home/zymos/.zshrc'


# Key Bind
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
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' #Case insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} #Color
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31" # Kill colors
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


compdef '_files -g "*.rar *.RAR"' unrar # unrar override

compdef '_files -g "*.rar *.RAR *.zip *.ZIP *.tgz *.tar.bz2 *.tar.gz *.tar.xz"' extract # my own little command
compdef '_files -g *.tar *.tgz *.tar.bz2 *.tar.gz *.tar.xz"' extract # my own little command
# compdef eix=emerge # alias for eix to emerge

# exec 2>>(while read line; do
#  print '\e[91m'${(q)line}'\e[0m' > /dev/tty; print -n $'\0'; done &) # coloriz sterr




# Mods
unsetopt equals # make emerge =<pkg>-<version> work


# End of lines added by compinstall
