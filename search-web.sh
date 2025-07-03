#!/bin/bash

searchTerm=$(dmenu -p "Search:" < /dev/null)

if [ "${searchTerm}" != "" ];then
  qutebrowser "$searchTerm"
fi

