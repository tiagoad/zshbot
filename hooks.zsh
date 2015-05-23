#!/usr/bin/env zsh
# A simple hook system in zsh

# Associative array holding all the hooks
HOOKS=()

# Adds a function to a hook
# zshbot.hooks.registerHook <hook> <function>
function zshbot.hooks.registerHook {
	zshbot.util.logLine "Registered $1 -> $2 (SYNC)"
	HOOKS+="SYNC $1 $2"
}

# Adds a function to an async hook
# zshbot.hooks.registerAsyncHook <hook> <function>
function zshbot.hooks.registerAsyncHook {
	zshbot.util.logLine "Registered $1 -> $2 (ASYNC)"
	HOOKS+="ASYNC $1 $2"
}

# Triggers a hook
# zshbot.hooks,triggerIrcHook <hook> <args>
function zshbot.hooks.triggerHook {	
	for hook in $HOOKS; do
		args=("${(@s/ /)hook}")

		if [[ $args[2] == $1 ]]; then
			cmd="$args[3] \$@[2,-1]"

			if [[ $args[1] == "ASYNC" ]]; then
				cmd="$cmd &"
			fi

			eval $cmd
		fi
	done
}