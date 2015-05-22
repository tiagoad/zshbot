#!/usr/bin/env zsh

# > .bots
# < Reporting in! [zsh]
function ircCmdBots {
	sendPrivMsg "$target" "Reporting in! [zsh]"
}
addIrcHook CMD_BOTS ircCmdBots

# > .source/.sauce
# < https://github.com/legfloss/zshbot
function ircCmdSource {
	sendPrivMsg "$target" "$SOURCE"
}
addIrcHook CMD_SOURCE ircCmdSource
addIrcHook CMD_SAUCE ircCmdSource