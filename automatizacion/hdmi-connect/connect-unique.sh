#!/usr/bin/bash

INTERNAL_OUTPUT="eDP-1"
HDMI_OUTPUT="HDMI-2"

if xrandr | grep "$HDMI_OUTPUT connected"; then
  #Cambiar a pantalla unica
  xrandr --output HDMI-1 --auto --primary --output eDP-1 --off
else
  xrandr --output eDP-1 --auto --primary --output HDMI-2 --off
fi
