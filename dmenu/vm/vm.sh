#!/bin/bash

declare -A options

max_options=10

options=(
  ["Windows 11"]="qemu-system-x86_64 -hda /home/Michael/.vm-isos/Win11.img -accel kvm -cpu max -smp 4 -m 16G -usbdevice tablet"
)

options_len=${#options[@]}
options_count=$((options_len<max_options ? options_len : max_options))

for i in "${!options[@]}";do
  input="${input}${i}\n"
done

choice=$(echo -e "${input::-2}" | dmenu -c -l "${options_count}")
${options[$choice]}
