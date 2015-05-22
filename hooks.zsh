#!/usr/bin/env zsh
# A simple hook system in zsh

# Associative array holding all the hooks
HOOKS=()

# Adds a function to a hook
# addIrcHook <hook> <function>
function addIrcHook {
	HOOKS+="SYNC $1 $2"
}

# Adds a function to an async hook
# addIrcAsyncHook <hook> <function>
function addIrcAsyncHook {
	HOOKS+="ASYNC $1 $2"
}

# Triggers a hook
# triggerIrcHook <hook> <args>
function triggerIrcHook {	
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