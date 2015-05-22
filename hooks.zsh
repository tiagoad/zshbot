#!/usr/bin/env zsh
# A simple hook system in zsh

# Generates a random prefix, so we can reload the config and not have duplicate hooks
function initHooks {
	HOOKPREFIX=$(base64 </dev/urandom | tr -dc 'A-Z' | head -c10)
}

# Adds a function to a hook
# addIrcHook <hook> <function>
function addIrcHook {
	# appends the function name to an array named IRC_HOOK_<hook name>.
	# for example, for the hook "001", appends the function name to the
	# IRC_HOOK_001 array
	eval "IRC_HOOK_${HOOKPREFIX}_$1+=$2"
}

# Adds a function to an async hook
# addIrcAsyncHook <hook> <function>
function addIrcAsyncHook {
	# appends the function name to an array named IRC_HOOK_<hook name>.
	# for example, for the hook "001", appends the function name to the
	# IRC_HOOK_001 array
	eval "IRC_HOOK_ASYNC_${HOOKPREFIX}_$1+=$2"
}

# Triggers a hook
# triggerIrcHook <hook> <args>
function triggerIrcHook {
	#logLine "HOOK $1"

	# calls each function hooked, with the specified args
	for function in $(eval "echo \$IRC_HOOK_${HOOKPREFIX}_$1"); do
		eval "$function \$@[2,-1]"
	done

	# calls each function async hooked, with the specified args
	for function in $(eval "echo \$IRC_HOOK_ASYNC_${HOOKPREFIX}_$1"); do
		eval "$function \$@[2,-1]" &
	done
}

initHooks