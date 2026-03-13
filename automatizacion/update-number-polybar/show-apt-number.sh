#!/bin/bash

OUTPUT_FILENAME="$HOME/.config/automatizacion/update-number-polybar/apt-number.txt"

if sudo apt update 2>&1; then
  UPDATES=$(apt list --upgradable 2>/dev/null | grep -c "actualizable")

  if [[ UPDATES -eq 0 ]]; then
    echo "󰚰 0" >$OUTPUT_FILENAME
  else
    echo "󰚰 $UPDATES" >$OUTPUT_FILENAME

  fi
else
  echo " " >$OUTPUT_FILENAME
fi

chmod 644 "$OUTPUT_FILENAME"
