#!/usr/bin/env zsh

# > .bots
# < Reporting in! [zsh]
function ircCmdBots {
	sendPrivMsg "$target" "Reporting in! [zsh]"
}
addIrcHook CMD_BOTS ircCmdBots