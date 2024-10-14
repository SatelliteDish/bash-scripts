#!/bin/bash


if (( $# != 1 )); then
  echo "Invalid arguments, please provide either a file to back up or use -r to remove all backups in dir."
  exit 1
fi

if (( $1 == "-r" ));then
  for file in ./*; do
    if [[ $file == *.bk ]]; then
      echo "Removing"
      rm "${file}"
    fi
  done
else
  cp $1 $1.bk
fi

exit 0
