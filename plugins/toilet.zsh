#!/usr/bin/env zsh
# Toilet spam

# > .toilet <channel>
function zshbot.toilet.toilet {
	if zshbot.auth.isThisUserLoggedInOrError; then
		local IFS=''
		echo "$@[2,-1]" | cut -c 1-35 | toilet -w 999999999 --gay --irc -f future | while read -r line; do
			echo "$line"
			zshbot.util.sendPrivMsg "$target" "$line"
		done
	fi
}
zshbot.commands.registerCommand "toilet" zshbot.toilet.toilet "Outputs big text using toilet" "toilet <text>"