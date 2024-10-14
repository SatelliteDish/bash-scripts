#!/bin/bash

declare -A options

options=(
  ["Shut Down"]="systemctl poweroff"
  ["Reboot"]="systemctl reboot"
  ["Cancel"]="exit 0"
)

for i in "${!options[@]}";do
  input="${input}${i}\n"
done

choice=$(echo -e "${input::-2}"| dmenu -c -l 3)

if [ $choice != "Cancel" ]; then
  if [ $(confirm) = "No" ]; then
    exit 0
  fi
fi

echo $choice

${options[$choice]}
