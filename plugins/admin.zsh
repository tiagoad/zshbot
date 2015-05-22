#!/usr/bin/env zsh
# Administrative commands

# > .join <channel>
function ircCmdJoin {
	if isLineUserLoggedInOrError; then
		sendLine "JOIN $2"
	fi
}
addIrcHook CMD_JOIN ircCmdJoin

# > .part [channel]
function ircCmdPart {
	if isLineUserLoggedInOrError; then
		if [[ $2 ]]; then
			sendLine "PART $2"
		else
			sendLine "PART $target"
		fi
	fi
}
addIrcHook CMD_PART ircCmdPart