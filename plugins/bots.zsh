#!/usr/bin/env zsh

# > .bots
# < Reporting in! [zsh]
function zshbot.bots.bots {
	zshbot.util.sendPrivMsg "$target" "Reporting in! [zsh] ~ try .source"
}
zshbot.commands.registerCommand "bots" zshbot.bots.bots "Shows info about this bot" "bots"

# > .source/.sauce
# < https://github.com/legfloss/zshbot
function zshbot.bots.source {
	zshbot.util.sendPrivMsg "$target" "$SOURCE"
}
zshbot.commands.registerCommand "source" zshbot.bots.source "Show a link to this bot's source" "source"
zshbot.commands.registerCommand "sauce" zshbot.bots.source  "Show a link to this bot's source" "sauce" "true"