# rejoin channels when kicked
function zshbot.kickrejoin.onKick {
	if [[ $@[4] == $NICK ]]; then
		zshbot.util.sendLine "JOIN $@[3]"
	fi
}
zshbot.hooks.registerHook KICK zshbot.kickrejoin.onKick