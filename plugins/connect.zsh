# run commands on RPL_WELCOME
function zshbot.connect.connectCommands {
	for command in $CONNECT_COMMANDS; do
		zshbot.util.sendLine "$command"
	done
}
zshbot.hooks.registerHook 001 zshbot.connect.connectCommands

# join all channels on RPL_WELCOME
function zshbot.connect.joinChannels {
	for channel in $CHANNELS; do
		zshbot.util.sendLine "JOIN $channel"
	done
}
zshbot.hooks.registerHook 001 zshbot.connect.joinChannels