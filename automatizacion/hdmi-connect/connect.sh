#!/usr/bin/bash

export DISPLAY=:0
export XAUTHORITY=/home/$USER/.Xauthority

INTERNAL_OUTPUT="eDP-1"
HDMI_OUTPUT="HDMI-2"

if xrandr | grep "$HDMI_OUTPUT connected"; then
  xrandr --output $HDMI_OUTPUT --auto --same-as $INTERNAL_OUTPUT
else
  xrandr --output $HDMI_OUTPUT --off --output $INTERNAL_OUTPUT --auto
fi
