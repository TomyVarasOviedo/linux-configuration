#!/usr/bin/bash

ROFI_THEME="~/.config/rofi/launchers/type-2/style-5.rasi"
MESSAGE_THEME="~/.config/rofi-wifi-menu/confirm.rasi"
show_menu() {
  file_address=$(rofi -dmenu -p "Dirreccion del archivo" -placeholder "~/Escritorio/" -lines 1 -theme $ROFI_THEME)
  if [[ file_address != "" || file_address != null ]]; then
    screenshot_lauch $file_address
  else
    echo "Captura cancelada" | rofi -dmenu -theme MESSAGE_THEME -lines 1
  fi
}
screenshot_lauch() {
  maim -s ~/Escritorio/$1
}

show_menu
