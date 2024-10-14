#!/bin/bash

declare -A options

max_options=10

options=(
  ["Clip Studio Paint"]="/home/Michael/.wine/drive_c/Program\ Files/CELSYS/CLIP\ STUDIO\ 1.5/CLIP\ STUDIO/CLIPStudio.exe"
)
options_len=${#options[@]}
option_count=$((options_len<max_options ? options_len : max_options))

for i in "${!options[@]}";do
  input="${input}${i}\n"
done

choice=$(echo -e "${input::-2}"| dmenu -c -l "${option_count}")
wine ${options[$choice]}
