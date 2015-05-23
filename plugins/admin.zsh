#!/usr/bin/env zsh
# Administrative commands

# > .join <channel>
function zshbot.admin.join {
	if zshbot.auth.isThisUserLoggedInOrError; then
		zshbot.util.sendLine "JOIN $2"
	fi
}
zshbot.commands.registerCommand "join" zshbot.admin.join "Joins a channel" "join <channel>" true

# > .part [channel]
function zshbot.admin.part {
	if zshbot.auth.isThisUserLoggedInOrError; then
		if [[ $2 ]]; then
			zshbot.util.sendLine "PART $2"
		else
			zshbot.util.sendLine "PART $target"
		fi
	fi
}
zshbot.commands.registerCommand "part" zshbot.admin.part "Parts a channel" "part [channel]" true

# > .raw <line>
function zshbot.admin.raw {
	if zshbot.auth.isThisUserLoggedInOrError; then
		zshbot.util.sendLine "$@[2,-1]"
	fi
}
zshbot.commands.registerCommand "raw" zshbot.admin.raw "Sends a raw line to the server" "raw <line>" true

# > .eval <line>
function zshbot.admin.eval {
	if zshbot.auth.isThisUserLoggedInOrError; then
		eval "$@[2,-1]"
	fi
}
zshbot.commands.registerCommand "raw" zshbot.admin.eval "Evaluates a shell line" "raw <line>" true

# > .reload
function zshbot.admin.reload {
	if zshbot.auth.isThisUserLoggedInOrError; then
		zshbot.core.reloadModules
		zshbot.util.sendNotice "$target" "Reloaded"
	fi
}
zshbot.commands.registerCommand "reload" zshbot.admin.reload "Reloads the bot" "reload" true