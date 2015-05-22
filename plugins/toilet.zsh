#!/usr/bin/env zsh
# Toilet spam

# > .toilet <channel>
function ircCmdToilet {
	if isLineUserLoggedIn; then
		local IFS=''
		echo "$@[2,-1]" | toilet --gay --irc -f future | while read -r line; do
			echo "$line"
			sendPrivMsg "$target" "$line"
		done
	fi
}
addIrcHook CMD_TOILET ircCmdToilet