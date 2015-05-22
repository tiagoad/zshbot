#!/usr/bin/env zsh

# info
VERSION="0.0.1"
SOURCE="https://github.com/legfloss/zshbot"

# load modules
zmodload zsh/net/tcp
zmodload zsh/regex

# load colors
autoload -U colors && colors

function reloadModules {
	# load configurations
	source config.zsh

	# load utility functions
	source util.zsh

	# load hook system
	source hooks.zsh

	# load handlers
	source handlers.zsh

	# load special character constants
	source chars.zsh

	# load all plugins
	for file in plugins/*; do
	    source "$file"
	done

	# set reload time
	LAST_RELOAD=$(date +%s)
}
reloadModules

# connect to IRC server
ztcp $HOST $PORT
fd=$REPLY

# initialize connection
sendLine "NICK $NICK"
sendLine "USER $USER 8 * : $NAME"

# main loop
while read -r line <&$fd; do
	# remove carriage return
	line=${line//$'\r'/}

	# reload the modules every 10 seconds
	delta_t="$(($(date +%s) - $LAST_RELOAD))"
	if [[ $delta_t -gt $RELOAD_INTERVAL ]]; then
		reloadModules
	fi

	# debug output
	echo "$fg[red]< $line$reset_color"

	# split the string by spaces
	args=("${(@s/ /)line}")

	# filter commands
	if [[ $args[1] == "PING" ]]; then
		sendLine "PONG $args[2,-1]"
	else
		# parse the hostname
		parseHost "$args[1]"

		# trigger the hooks
		triggerIrcHook $args[2] $args
	fi
done