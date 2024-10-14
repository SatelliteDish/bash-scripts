#!/bin/bash

declare -A methods

methods=(
  ["POST"]="post"
  ["GET"]="get"
  ["DELETE"]="delete"
  ["PUT"]="put"
)

for i in "${!methods[@]}"; do
  method_string="${method_string}${i}\n"
done

chosen_method=$(echo -e "${method_string::-2}" | dmenu -c -l "${#methods[@]}")

hostname=$(dmenu -p "Enter Hostname:" < /dev/null)

headers=""
port=""
body=""
output=""
output_headers=""
no_ssl=""
follow=""
verbose=""
endpoint=""

builder() {
  declare -A options
  options=(
    ["Port"]="set_port"  
    ["Body"]="set_body"  
    ["Output"]="set_output"
    ["Headers"]="set_headers"
    ["Include Headers In Response"]="include_headers"
    ["Follow Redirects"]="follow_redirects"  
    ["Allow Connections To SLL With No Cert"]="allow_no_ssl"
    ["Verbose"]="verbose"
    ["Finish"]="build"
  )
  for i in "${!options[@]}"; do
    option_string="${option_string}${i}\n"
  done

  option_choice=$(echo -e ${option_string} | dmenu -c -l "${#options[@]}")
  ${options[$option_choice]}
  echo $port
}

set_headers() {
  declare -A headers_map
  while [[ $header_choice != "Back" ]]; do
    header_choice=$(echo -e "Add\nRemove\nBack" | dmenu -c -l 3)
    if [ $header_choice == "Add" ]; then
      header_name=$(dmenu -c -p "Enter Header Name:" < /dev/null)
      header_value=$(dmenu -c -p "Enter Header Value:" < /dev/null)
      headers_map["${header_name}"]="${header_value}"
    else
      for i in "${!headers_map[@]}"; do
        header_string="${header_string}${i}\n"
      done
      header_choice=$(echo -e "${header_string::-2}" | dmenu -c -l "${#headers_map[@]}")
      unset $headers_map[$header_choice]
    fi
    for i in "${!headers_map[@]}"; do
      headers=$'--header "${i}: ${headers[$i]" }'
    done
  done
}

set_port() {
  port=$(dmenu -c -p "Enter Port Number:" < /dev/null)
  builder
}

set_body() {
  body=$(dmenu -c -p "Enter the Desired Body:")
  builder
}

set_output() {
  output=$(dmenu -c -p "Enter the path you'd like to output the response to:")
  builder
}

include_headers() {
  if [$(confirm) == "Yes"]; then
    output_headers="-i"
  fi
  builder
}

follow_redirects() {
  if [$(confirm) == "Yes" ]; then
    follow="-L"
  fi
  builder
}

  
allow_no_ssl() {
  if [$(confirm) == "Yes" ]; then
    no_ssl="-k"
  fi
  builder
}

set_verbose() {
  if [$(confirm) == "Yes" ]; then
    verbose="-v"
  fi
  builder
}

set_endpoint() {
  endpoint=$(dmenu -c -p "Enter the endpoint you want to send the response to, starting with /:")
  builder
}

post() {
  echo "post"  
}

get() {
  echo "curl" "${headers}" "${verbose}" "${no_ssl}" "${output}" "${follow_redirects}" "${output_headers}"   "${hostname}${port}${endpoint}"
  $(curl "${headers}" "${verbose}" "${no_ssl}" "${output}" "${follow_redirects}" "${output_headers}"   "${hostname}${port}${endpoint}")
}

delete() {
  echo "delete"
}

put() {
  echo "put"
}

build() {
  ${methods[$chosen_method]}
}

builder
