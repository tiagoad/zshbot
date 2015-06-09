#!/usr/bin/env zsh

# > .insultme
# < Fuck you!
function zshbot.insult.insultme {
	insult=$(curl -s http://www.insultgenerator.org/ | awk '/<br><br>.*<\/div>/{gsub(/<\/div>/, ""); gsub(/<br><br>/, ""); print}')

	zshbot.util.sendPrivMsg "$target" "$nick: $insult"
}
zshbot.commands.registerCommand "insultme" zshbot.insult.insultme "Insults you" "insultme"
