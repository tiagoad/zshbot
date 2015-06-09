#!/bin/zsh

function zshbot.weather.weather {
	results=$(curl -s "http://api.openweathermap.org/data/2.5/weather?units=metric&q=$@[2,-1]")
	cod=$(jshon -e cod -u <<< "$results")

	if [[ $cod != "200" ]]; then
		error=$(jshon -e message -u <<< "$results")
		echo $error
	else
		description=$(jshon -e weather -e 0 -e description -u <<< "$results")

		name=$(jshon -e name -u <<< "$results")
		country=$(jshon -e sys -e country -u <<< "$results")

		# main
		main=$(jshon -e main <<< "$results")
		current=$(jshon -e temp -u <<< "$main")
		temp_min=$(jshon -e temp_min -u <<< "$main")
		temp_max=$(jshon -e temp_max -u <<< "$main")
		humidity=$(jshon -e humidity -u <<< "$main")

		output=$(printf "%s, %s. Current: %s, %iC, %i%%. High: %iC Low: %iC" "$name" "$country" "$description" "$current" "$humidity" "$temp_max" "$temp_min.")
		zshbot.util.sendPrivMsg "$target" "$output"
	fi
}

zshbot.commands.registerCommand "weather" zshbot.weather.weather "Shows weather info" "weather <place>"