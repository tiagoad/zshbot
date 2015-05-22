#!/usr/bin/env zsh

[[ $IRC_AUTHORIZED_USERS != "" ]] || IRC_AUTHORIZED_USERS=( )

# > .login <password>
# < Logged in!
function ircCmdLogin {
	if [[ $2 == $AUTH_PASSWORD ]]; then
		IRC_AUTHORIZED_USERS+="${raw_line[1]}"
		
		logLine "User ${raw_line[1]} has successfully logged in"
		sendPrivMsg "$target" "You have been successfully logged in"
	fi
}
addIrcHook CMD_LOGIN ircCmdLogin

# Checks if the passed user string has logged in
function isUserLoggedIn {
	if [[ "$IRC_AUTHORIZED_USERS[(r)$@]" ]]; then
		return 0
	else
		return 1
	fi
}

# Checks if the current line user string has logged in
function isLineUserLoggedIn {
	isUserLoggedIn "$raw_line[1]";
}

# Checks if the current line user string has logged in
function isLineUserLoggedInOrError {
	if isLineUserLoggedIn; then
		return 0
	else
		sendNotice "$nick" "You are not authorized to use this command"
		return 1
	fi
}