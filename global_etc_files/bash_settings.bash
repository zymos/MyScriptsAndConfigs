#!/bin/bash

################################################
###      My System-wide Bash settings        ###
################################################


shopt -s no_empty_cmd_completion # can't tab on empty line
shopt -s cdspell # minor spell check
shopt -s dirspell # minor spell check
shopt -s globstar # **
shopt -s histappend 
export HISTIGNORE="&:ls:[bf]g:exit:shut:bed"
export HISTCONTROL=ignoreboth
