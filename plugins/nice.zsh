#!/usr/bin/env zsh
# * hug

#!/usr/bin/env zsh

# > .hug
function zshbot.nice.hug {
	if [[ $2 == "" ]]; then
		2="$nick"
	fi

	zshbot.util.sendCtcpMessage "$target" "ACTION hugs $2"
}
zshbot.commands.registerCommand "hug" zshbot.nice.hug "Hugs**" "hug [user]"