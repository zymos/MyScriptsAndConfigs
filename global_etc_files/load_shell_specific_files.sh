# This will source files for its shell
# Puts files in /etc/profile.d/
#   *.bash for bash
#   *.zsh for zshell

if [ "$SHELL" = '/bin/zsh' ]; then
	for sh in /etc/profile.d/*.zsh ; do
		if [ -r "$sh" ]; then
			. "$sh"
		fi
	done
elif [ "$SHELL" = '/bin/bash' ]; then
	for sh in /etc/profile.d/*.bash ; do
		if [ -r "$sh" ]; then
			. "$sh"
		fi	
	done
fi
unset sh
