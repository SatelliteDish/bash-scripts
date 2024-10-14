name=$(dmenu -c -p "Name: " < /dev/null)
if [ "$name" != "" ]; then
  cd ~/Pictures/screenshots
  scrot -s "${name}"  
fi
