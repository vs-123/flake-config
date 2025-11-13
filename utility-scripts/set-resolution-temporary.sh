#!/bin/bash

echo "======================================"
echo "===== RESOLUTION SETTER BY vs-12 ====="
echo "======================================"

echo "* This is temporary"

is_it_right="n"
cvt_args=""

while [[ "$(echo "$is_it_right" | tr "[:upper:]" "[:lower:]")" != "y" ]]; do
echo "Enter the resolution and refresh rate you need in the following format:"
echo "> <width> <height> <refresh_rate_hz>"
echo ""
read -p "> " cvt_args
cvt_args="$(echo "$cvt_args" | tr -s " ")"
echo "Is this right?"
echo ">>> $cvt_args"
read -p "(y/n) ? " is_it_right
echo ""
done

modeline_cmd="cvt $cvt_args"
modeline_res_raw="$(eval $modeline_cmd)"
modeline_res="$(echo $modeline_res_raw | grep 'Modeline' | sed "s/Modeline //")"
modename="$(echo $modeline_res | awk "{print $2}")"

display_output=""
is_it_right="n"
while [[ "$(echo "$is_it_right" | tr "[:upper:]" "[:lower:]")" != "y" ]]; do
xrandr
echo "Available display outputs are given above."
echo "Choose the display output on which you'd like to apply the new mode."
read -p "> " display_output
echo "Is this right?"
echo ">>> $display_output"
read -p "(y/n) ? " is_it_right
echo ""
done

xrandr_cmd_1="xrandr --newmode $modeline_res"
xrandr_cmd_2="xrandr --addmode $display_output $modename"
xrandr_cmd_3="xrandr --output $display_output $modename"

eval $xrandr_cmd_1
eval $xrandr_cmd_2

read -p "Would you like to apply the mode right now? (y/n) " yes_no

if [[ "$(echo "$yes_no" | tr "[:upper:]" "[:lower:]")" == "y" ]]; then
   eval $xrandr_cmd_3
fi

echo "======================================"
echo "===== INSTRUCTIONS FOR PERMANENT ====="
echo "======================================"
echo "* Paste the following three lines into ~/.xprofile"
echo "$xrandr_cmd_1"
echo "$xrandr_cmd_2"
echo "$xrandr_cmd_3"

echo "THE END"


