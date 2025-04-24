#!/bin/bash

# Configuración
ROFI_THEME="-theme ~/.config/rofi/launchers/type-2/style-5.rasi" # Personaliza tu tema
SINK_RETRIES=5

# Función principal
show_menu() {
  # Obtener dispositivos Bluetooth pareados
  devices=$(bluetoothctl devices | awk '{print $2 " " $3}' | sed 's/ /_/g')

  # Activar Bluetooth si está apagado
  bluetoothctl power on >/dev/null

  # Escanear dispositivos (5 segundos)
  bluetoothctl scan on >/dev/null &
  scan_pid=$!
  sleep 5
  kill $scan_pid

  # Generar lista para Rofi
  device_list=$(bluetoothctl devices | awk '{$1=""; print $0}' | sed 's/^ *//')

  # Mostrar menú Rofi
  chosen=$(echo "$device_list" | rofi -dmenu -p "Dispositivos Bluetooth" $ROFI_THEME)

  # Extraer MAC del dispositivo seleccionado
  mac_address=$(echo "$chosen" | awk '{print $1}')

  [ -z "$mac_address" ] && exit 0 # Salir si se cancela

  # Conectar dispositivo
  connect_device "$mac_address"
}

connect_device() {
  local mac=$1
  echo "Conectando a $mac..."

  bluetoothctl trust "$mac"

  for i in {1..5}; do
    if bluetoothctl connect "$mac" | grep -q "Connection successful"; then
      echo "¡Conexión exitosa!"
      set_pulseaudio_sink "$mac"
      exit 0
    fi
    sleep 2
  done

  notify-send "Error" "No se pudo conectar a $mac"
  exit 1
}

set_pulseaudio_sink() {
  local mac=$1
  local pulse_mac=${mac//:/_}

  for ((i = 1; i <= $SINK_RETRIES; i++)); do
    sink_name=$(pactl list sinks short | grep -i "bluez_sink.$pulse_mac" | awk '{print $2}')

    [ -n "$sink_name" ] && break
    sleep 1
  done

  if [ -n "$sink_name" ]; then
    pactl set-default-sink "$sink_name"
    pactl list short sink-inputs | awk '{print $1}' | xargs -I{} pactl move-sink-input {} "$sink_name"
    notify-send "Audio Configurado" "Salida de audio cambiada a $chosen"
  else
    notify-send "Advertencia" "No se encontró el dispositivo de audio"
  fi
}

# Dependencias
check_deps() {
  command -v rofi >/dev/null || {
    notify-send "Error" "Rofi no está instalado"
    exit 1
  }
  command -v bluetoothctl >/dev/null || {
    notify-send "Error" "bluetoothctl no está instalado"
    exit 1
  }
  command -v pactl >/dev/null || {
    notify-send "Error" "pactl no está instalado"
    exit 1
  }
}

# Ejecución principal
check_deps
show_menu
