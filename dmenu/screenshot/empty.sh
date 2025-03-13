#!/bin/bash

choice="$(echo -e 'Yes\nNo' | dmenu -c -l 2 -p 'Empty screenshots?')"

if [ "$choice" == "Yes" ]; then
  rm /home/Michael/Pictures/screenshots/*
fi
