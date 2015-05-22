#!/usr/bin/env zsh
# Command handlers
# The passed arguments is command, followed by it's arguments
# Also set are the following variables:
# - raw_line
# - channel
# - ident
# - nick
# - hostname

function irc-command-bots {
	sendPrivMsg "$channel" "Reporting in! [zsh]"
}
addIrcHook CMD_BOTS irc-command-bots

function irc_cmd_login {

}
addIrcHook CMD_BOTS irc-command-login