#!/bin/bash

declare -A options

max_options=10

options=(
  ["Spotify"]="spotify-launcher"
  ["Steam"]="steam"
  ["Discord"]="firefox www.discord.com"
  ["Edit Neovim"]="st -e nvim /home/Michael/.config/nvim"
  ["PavuControl"]="pavucontrol"
  ["Keepassxc"]="keepassxc"
  ["OBS"]="obs"
  ["Obsidian"]="obsidian"
  ["Chrome"]="google-chrome-stable"
  ["Libre Office"]="libreoffice"
  ["Lutris"]="lutris"
  ["Godot"]="godot-mono-bin"
  ["Android Studio"]="bash ~/apps/android-studio/bin/studio.sh"
  ["Zen"]="zen-browser"
)
options_len=${#options[@]}
option_count=$((options_len<max_options ? options_len : max_options))

for i in "${!options[@]}";do
  input="${input}${i}\n"
done

choice=$(echo -e "${input::-2}"| dmenu -c -l "${option_count}")
${options[$choice]}
