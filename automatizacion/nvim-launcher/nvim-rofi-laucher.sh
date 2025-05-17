#!/usr/bin/bash

ROFI_THEME="~/.config/automatizacion/nvim-launcher/rofi.rasi"
NOTIFY_THEME="~/.config/rofi-wifi-menu/confirm.rasi"

PATH=$(rofi -dmenu -p ">" -theme "$ROFI_THEME")
echo "$PATH"
if [[ -n "$PATH" ]]; then
  /usr/bin/kitty -e nvim $PATH
else
  echo "Ruta no encontrada" | rofi -dmenu -theme "$NOTIFY_THEME"
fi
