#!/usr/bin/env zsh

[[ $IRC_AUTHORIZED_USERS != "" ]] || IRC_AUTHORIZED_USERS=( )

# > .login <password>
# < Logged in!
function zshbot.auth.login {
	if [[ $2 == $AUTH_PASSWORD ]]; then
		IRC_AUTHORIZED_USERS+="${raw_line[1]}"
		
		zshbot.util.logLine "User ${raw_line[1]} has successfully logged in"
		zshbot.util.sendNotice "$target" "You have been successfully logged in"
	else
		zshbot.util.sendNotice "$target" "Wrong password."
	fi
}
zshbot.commands.registerCommand "login" zshbot.auth.login "Authenticates you with the bot" "login <password>"

# Checks if the passed user string has logged in
function zshbot.auth.isUserLoggedin {
	if [[ "$IRC_AUTHORIZED_USERS[(r)$@]" ]]; then
		return 0
	else
		return 1
	fi
}

# Checks if the current line user string has logged in
function zshbot.auth.isThisUserLoggedIn {
	zshbot.auth.isUserLoggedin "$raw_line[1]";
}

# Checks if the current line user string has logged in
function zshbot.auth.isThisUserLoggedInOrError {
	if zshbot.auth.isThisUserLoggedIn; then
		return 0
	else
		zshbot.util.sendNotice "$nick" "You are not authorized to use this command"
		return 1
	fi
}