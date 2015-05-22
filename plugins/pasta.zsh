#!/usr/bin/env zsh

# > .pasta
# < Spam incoming!
function ircCmdPasta {
	sendPrivMsg "$target" "Spam incoming!"
}
addIrcHook CMD_PASTA ircCmdPasta