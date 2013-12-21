#################################
# My Fuctions
#################################

# Command line calcualtor
calc () {
	echo "$*" | bc
}


#bash only functions
#if [[ $SHELL = "/bin/bash" ]]; then

	# change xterm title when exiting root
	#if [[ $TERM = "xterm" && $USER = "root" ]]; then
	#	function exit () {
	#		echo -ne "\033]0;xterm\007"
	#		builtin exit
	#	}
	#fi
#fi
