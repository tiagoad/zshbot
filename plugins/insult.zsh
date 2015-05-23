#!/usr/bin/env zsh

# > .insultme
# < Fuck you!
function zshbot.insult.insultme {
	insult=$(curl -s http://www.insultgenerator.org/ | grep wrap -A3 | grep br | cut -c 9- | rev | cut -c 7- | rev)

	zshbot.util.sendPrivMsg "$target" "$nick: $insult"
}
zshbot.commands.registerCommand "insultme" zshbot.insult.insultme "Insults you" "insultme"