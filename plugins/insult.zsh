#!/usr/bin/env zsh

# > .insultme
# < Fuck you!
function ircCmdInsultMe {
	insult=$(curl -s http://www.insultgenerator.org/ | grep wrap -A3 | grep br | gcut -c 9- | rev | gcut -c 7- | rev)

	sendPrivMsg "$target" "$nick: $insult"
}
addIrcAsyncHook CMD_INSULTME ircCmdInsultMe
addIrcAsyncHook CMD_INSULT ircCmdInsultMe