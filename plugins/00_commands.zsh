#!/usr/bin/env zsh
# IRC command/numeric handlers (00 to have priority)

# List of commands
# Separator is US (unit separator) \037
COMMANDS=()

# parses a command row
function zshbot.commands.parseCommandRow {
	# split the row by \037
	cmd_args=("${(@s.\037.)1}")

	cmd_command=$cmd_args[1]:l
	cmd_callback=$cmd_args[2]
	cmd_description=$cmd_args[3]
	cmd_usage=$cmd_args[4]
	cmd_hidden=$cmd_args[5]
	cmd_type=$cmd_type[6]
}

# handles commands
function zshbot.commands.commandHandler {
	# ignore server messages
	[[ $server != "" ]] && return

	# get the line that was sent
	line="${@[4,-1]}"
	line="$line[2,-1]"

	# check if the line is a CTCP command
	if [[ $line[1] == $'\001' ]]; then
		# split the command by spaces
		ctcp_command=("${(@s. .)line[2,-2]}")

		# trigger the CTCP hook
		zshbot.hooks.triggerHook "CTCP_${ctcp_command[1]:u}" ${ctcp_command}

	elif [[ $line[1] == $COMMAND_PREFIX ]]; then
		# split the line by spaces
		line=("${(@s. .)line[2,-1]}")

		# copy the raw line into another variable, so the command handler can read it
		typeset -a raw_line
		set -A raw_line $@

		# find the command target
		target="$raw_line[3]"
		if [[ $target == "$NICK" ]]; then
			target="$nick"
		fi

		# find if the command exists
		for command in $COMMANDS; do
			zshbot.commands.parseCommandRow "$command"

			if [[ $line[1]:l == $cmd_command ]]; then
				$cmd_callback $line
			fi
		done
	fi

}
zshbot.hooks.registerHook PRIVMSG zshbot.commands.commandHandler

# registers a command
# registerCommand <command> <callback> <description> <usage> <hidden> <async>
function zshbot.commands.registerCommand {
	CMDROW="${1}\037${2}\037${3}\037${4}\037${5}\037${6}\037"
	COMMANDS+=$CMDROW
	zshbot.commands.parseCommandRow "$CMDROW"

	zshbot.util.logLine "Registered command ${COMMAND_PREFIX}${cmd_usage}"
}

# lists all the available commands
# .commands
function zshbot.commands.commands {
	output="Available commands: "
	for command in $COMMANDS; do
		zshbot.commands.parseCommandRow "$command"

		if [[ $cmd_hidden != "true" ]]; then
			output+="$cmd_command, "
		fi
	done
	output="$output[1,-3]"
	zshbot.util.sendNotice "$target" "$output"
	zshbot.util.sendNotice "$target" "Use .help <command> to learn more about any of them"
}
zshbot.commands.registerCommand "commands" zshbot.commands.commands "Lists commands" "commands"

# outputs a command usage
function zshbot.commands.outputUsage {
	zshbot.commands.help "help"
}

# shows help about a certain command
# .help <command>
function zshbot.commands.help {
	for command in $COMMANDS; do
		zshbot.commands.parseCommandRow "$command"

		if [[ $line[2]:l == $cmd_command ]]; then
			zshbot.util.sendNotice "$target" "${cmd_description}"
			zshbot.util.sendNotice "$target" "Usage: ${COMMAND_PREFIX}${cmd_usage}"
			return
		fi
	done
	zshbot.util.sendNotice "$target" "No such command"
}
zshbot.commands.registerCommand "help" zshbot.commands.help "Shows help about a command" "help <command>"