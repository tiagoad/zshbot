#!/usr/bin/env zsh
# Utility functions

# sends a line to the server
# sendLine <line>
function sendLine {
	# debug output
	echo "$fg[green]> $@$reset_color"

	# send to file descriptor
	echo $@ >&$fd
}

# logs a line
# logLine <line>
function logLine {
	echo "$fg[blue]? $@$reset_color"
}

# parse hostname
# fills the following variables:
# - nick
# - ident
# - hostname
# or just
# - server
function parseHost {
	[[ $@ -regex-match "^:((.+)!(.+)@(.+)|[^@]+)$" ]]

	if [[ ! $match[2] ]]; then
		server="$match[1]"
		ident=
		nick=
		hostname=
	else
		server=
		nick="$match[2]"
		ident="$match[3]"
		hostname="$match[4]"
	fi
}

# sends a PRIVMSG to a channel/user
# sendPrivMsg <channel/user> <message>
function sendPrivMsg {
	sendLine "PRIVMSG $1 :$@[2,-1]"
}

# sends a NOTICE to a channel/user
# sendNotice <channel/user> <message>
function sendNotice {
	sendLine "NOTICE $1 :$@[2,-1]"
}

# sends a CTCP response NOTICE to a channel/user
# sendCtcpResponse <channel/user> <message>
function sendCtcpReponse {
	sendNotice "$1" "\001$@[2,-1]\001"
}