#!/bin/bash

# "xrandr --newmode $modeline_res"
# "xrandr --addmode $display_output $modename"
# "xrandr --output $display_output $modename"

echo "======================================"
echo "===== RESOLUTION SETTER BY vs-12 ====="
echo "======================================"

echo "* This is temporary"
echo ""
echo "[PROMPT FROM SCRIPT] Enter your desired resolution & refresh rate in the following format:"
echo "==> <width_px> <height_px> <refresh_rate_hz>"
echo ""

cvt_args=""
yesno="n"
while [[ ! "$yesno" =~ [yY] ]]; do
   read -p "==> " cvt_args
   echo "[CONFIRMATION]"
   echo ">>> $cvt_args"
   echo ""
   read -p "Is this right? (y/n) " yesno
done

modeline_cmd="cvt $cvt_args"
modeline_res=$(eval $modeline_cmd)
modeline_res=$(echo "$modeline_res" | tail -n 1)

modeline_fmt=$(echo "$modeline_res" | sed -r 's/(.*)Modeline//g')
modename=$(echo "$modeline_fmt" | awk '{print $1}')

display_output=$(eval xrandr | grep -v 'disconnected' | grep 'connected' | awk '{print $1}')
echo "Display Output: $display_output"
read -p "Is this your display output? (y/n) " yesno

if [[ ! "$yesno" =~ [yY] ]]; then
   while [[ ! "$yesno" =~ [yY] ]]; do
      eval xrandr
      read -p "Please enter your display output: " display_name
      echo "Display Output: $display_output"
      read -p "Is this your display output? (y/n) " yesno
   done
fi

xrandr_cmd_1="xrandr --newmode $modeline_fmt"
xrandr_cmd_2="xrandr --addmode $display_output $modename"
xrandr_cmd_3="xrandr --output $display_output --mode $modename"


echo "I am going to run the following commands:"
echo "   " $xrandr_cmd_1
echo "   " $xrandr_cmd_2
echo "   " $xrandr_cmd_3
read -p "Should I continue? (y/n) " yesno

if [[ "$yesno" =~ [yY] ]]; then
   eval $xrandr_cmd_1     
   eval $xrandr_cmd_2     
   eval $xrandr_cmd_3
fi

echo "THE END"

