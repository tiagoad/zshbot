#!/usr/bin/env zsh
# IRC command/numeric handlers

# join all channels on RPL_WELCOME
function joinChannels {
	for channel in $CHANNELS; do
		sendLine "JOIN $channel"
	done
}
addIrcHook 001 joinChannels

# rejoin channels when kicked
function kickRejoin {
	if [[ $@[4] == $NICK ]]; then
		sendLine "JOIN $@[3]"
	fi
}
addIrcHook KICK kickRejoin

# handles commands
function commandHandler {
	# ignore server messages
	[[ $server != "" ]] && return

	# get the line that was sent
	line="${@[4,-1]}"
	line="$line[2,-1]"

	# check if the line is a CTCP command
	if [[ $line[1] == $CHAR_001 ]]; then
		# split the command by spaces
		ctcp_command=("${(@s. .)line[2,-2]}")

		# trigger the CTCP hook
		triggerIrcHook "CTCP_${ctcp_command[1]:u}" ${ctcp_command}

	elif [[ $line[1] == $COMMAND_PREFIX ]]; then
		# split the line by spaces
		line=("${(@s. .)line[2,-1]}")

		# call the command function
		typeset -a raw_line
		set -A raw_line $@

		# find the command target
		target="$raw_line[3]"
		if [[ $target == "$NICK" ]]; then
			target="$nick"
		fi

		# trigger the CMD hook
		triggerIrcHook "CMD_${line[1]:u}" ${line}
	fi

}
addIrcHook PRIVMSG commandHandler