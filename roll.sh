#!/bin/bash

# Author: Bendik J. Ferkingstad, <https://github.com/bendikf>
#
# This work is licensed under CC0 1.0 Universal (CC0 1.0) Public Domain Dedication.
#
# For more information, please refer to <https://creativecommons.org/publicdomain/zero/1.0/>

# Rolls dice and stores the results in an array
roll_dice() {
	local num_dice=$1
	local num_sides=$2
	local rolls=()

	for ((i = 1; i <= num_dice; i++)); do
		roll=$(( (RANDOM % num_sides) + 1 ))
		rolls+=($roll)
	done

	echo "${rolls[@]}"
}

# Calculates the sum of all dice rolled
sum_rolls() {
	local rolls=("$@")
	local sum=0

	for roll in "${rolls[@]}"; do
		sum=$(( sum + roll ))
	done

	echo $sum
}

# Finds the die with the lowest result
max_roll() {
	local rolls=("$@")
	local max=${rolls[0]}

	for roll in "${rolls[@]}"; do
		if (( roll > max )); then
			max=$roll
		fi
	done

	echo $max
}

# Finds the die with the highest result
min_roll() {
	local rolls=("$@")
	local min=${rolls[0]}

	for roll in "${rolls[@]}"; do
		if (( roll < min )); then
			min=$roll
		fi
	done

	echo $min
}

# Displays the help message
show_help() {
	echo "Usage: $0 [options] NdM"
	echo
    	echo "Roll dice specified by NdM, where N is the number of dice and M is the number of sides."
    	echo
    	echo "Options:"
    	echo "  -s, --sum       Return the sum of the dice rolls (default behavior)"
  	echo "  -l, --list      List the results from all rolls"    
	echo "  -x, --max       Return the maximum result"
	echo "  -m, --min       Return the minimum result"
	echo "  -h, --help      Display this help message"
    	echo
       	echo "Examples:"
	echo "  $0 2d6          Roll two six-sided dice and return the sum"
    	echo "  $0 -l 3d10      Roll three ten-sided dice and list the results"
       	echo "  $0 -x 1d20      Roll one twenty-sided die and return the highest result"
	echo "  $0 -m 4d8       Roll four eight-sided dice and return the lowest result"
	echo
	echo "Special cases:"
	echo "  $0          Roll one six-sided die and return the result"
	echo "  $0 d4       Roll one four-sided die and return the result"
}

# Default action
action="sum"

# Parse options from the command line
while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do
	case $1 in
		-s | --sum )
			action="sum"
			;;
		-l | --list )
			action="list"
			;;
		-x | --max )
			action="max"
			;;
		-m | --min )
			action="min"
			;;
		-h | --help )
			show_help
			exit 0
			;;
		* )
			echo "Invalid option: $1"
			exit 1
			;;
	esac;
	shift; 
done

# If '--' is encountered, shift it off the argument list
if [[ "$1" == '--' ]]; then
	shift;
fi

# Get the dice string argument from the command line
dice_string=$1

# If no dice string is given, default to "1d6"
if [[ -z "$dice_string" ]]; then
	dice_string="1d6"
fi

# Check if the dice string is valid, i.e. NdM where N = the number of dice and M = the number of sides.
if [[ $dice_string =~ ^([0-9]*)d([0-9]+)$ ]]; then
	num_dice=${BASH_REMATCH[1]}
	num_sides=${BASH_REMATCH[2]}

	# Default to 1 die if no number is specified (e.g. d10)
	if [[ -z $num_dice ]]; then
		num_dice=1
	fi

	# Check for 
	if [[ $num_dice -le 0 || $num_sides -lt 2 ]]; then
		echo "Number of dice must both be greater than zero and number of sides must be at least two."
		exit 1
	fi

	rolls=$(roll_dice $num_dice $num_sides)
	rolls_array=($rolls)

	# If only one die is rolled, ignore options and return the result
	if [[ $num_dice -eq 1 ]]; then
		echo "Result: ${rolls_array[0]}"
	else
		case $action in
			sum)
				echo "Sum: $(sum_rolls ${rolls_array[@]})"
				;;
			list)
				echo "Results: ${rolls_array[@]}"
				;;
			max)
				echo "Max: $(max_roll ${rolls_array[@]})"
				;;
			min)
				echo "Min: $(min_roll ${rolls_array[@]})"
				;;
		esac
	fi
else
	echo "Invalid input. Please use the format NdM where N is the number of dice and M is the number of sides."
fi
