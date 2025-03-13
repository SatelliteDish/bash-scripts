#!/bin/bash

declare -A commands

commands=(
  ["Start"]="systemctl start docker"
  ["Stop"]="systemctl stop docker.socket"
)

for i in "${!commands[@]}"; do
  command_string="${command_string}${i}\n"
done

chosen_command=$(echo -e "${command_string::-2}" | dmenu -c -l "${#commands[@]}")

echo ${commands[$chosen_command]}

${commands[$chosen_command]} | echo
