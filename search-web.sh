#!/bin/bash

searchTerm=$(dmenu -p "Search:" < /dev/null)

if[ "$searchTerm" != "" ];then
  firefox --search "$searchTerm"
fi

