#!/usr/bin/env zsh

# info
VERSION="0.0.1"
SOURCE="https://github.com/legfloss/zshbot"

# load modules
zmodload zsh/net/tcp
zmodload zsh/regex

# load colors
autoload -U colors && colors

function zshbot.core.reloadModules {
	# load configurations
	source config.zsh

	# load utility functions
	source util.zsh

	# load hook system
	source hooks.zsh

	# load all modules
	for file in plugins/*; do
		zshbot.util.logLine "Loaded $file"
	    source "$file"
	done
}
zshbot.core.reloadModules

# connect to IRC server
ztcp $HOST $PORT
fd=$REPLY

# initialize connection
zshbot.util.sendLine "NICK $NICK"
zshbot.util.sendLine "USER $USER 8 * : $NAME"

# main loop
while read -r line <&$fd; do
	# remove carriage return
	line=${line//$'\r'/}

	# debug output
	echo "$fg[red]> $line$reset_color"

	# split the string by spaces
	args=("${(@s/ /)line}")

	# filter commands
	if [[ $args[1] == "PING" ]]; then
		zshbot.util.sendLine "PONG $args[2,-1]"
	else
		# parse the hostname
		zshbot.util.parseHost "$args[1]"

		# trigger the hooks
		zshbot.hooks.triggerHook $args[2] $args
	fi
done