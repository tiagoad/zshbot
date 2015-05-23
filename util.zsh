#!/usr/bin/env zsh
# Utility functions

# sends a line to the server
# zshbot.util.sendLine <line>
function zshbot.util.sendLine {
	# debug output
	echo "$fg[green]< $@$reset_color"

	# send to file descriptor
	echo $@ >&$fd
}

# logs a line
# zshbot.util.logLine <line>
function zshbot.util.logLine {
	echo "$fg[blue]? $@$reset_color"
}

# parse hostname
# fills the following variables:
# - nick
# - ident
# - hostname
# or just
# - server
function zshbot.util.parseHost {
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
# zshbot.util.sendPrivMsg <channel/user> <message>
function zshbot.util.sendPrivMsg {
	zshbot.util.sendLine "PRIVMSG $1 :$@[2,-1]"
}

# sends a NOTICE to a channel/user
# zshbot.util.sendNotice <channel/user> <message>
function zshbot.util.sendNotice {
	zshbot.util.sendLine "NOTICE $1 :$@[2,-1]"
}

# sends a CTCP response NOTICE to a channel/user
# zshbot.util.sendCtcpReponse <channel/user> <message>
function zshbot.util.sendCtcpReponse {
	zshbot.util.sendNotice "$1" "\001$@[2,-1]\001"
}