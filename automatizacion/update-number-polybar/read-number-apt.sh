#!/bin/bash

FILE="$HOME/.config/automatizacion/update-number-polybar/apt-number.txt"

if [ -f "$FILE" ]; then
  cat "$FILE"
else
  echo " ..."
fi
