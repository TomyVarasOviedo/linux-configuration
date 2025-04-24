#!/usr/bin/bash

# Configuración
if [[ $1 == "haylou" ]]; then
  MAC_ADDRESS="76:FC:8B:24:A0:04"
elif [[ $1 == "motorola" ]]; then
  MAC_ADDRESS="38:A2:8C:DD:5D:80"
fi
SINK_RETRIES=5 # Intentos para detectar el sink de audio

# Función para configurar PulseAudio
set_pulseaudio_sink() {
  local sink_name

  # Convertir MAC a formato usado por PulseAudio (XX_XX_XX_XX_XX_XX)
  local pulse_mac=${MAC_ADDRESS//:/_}

  echo "Buscando sink de audio Bluetooth..."

  for ((i = 1; i <= $SINK_RETRIES; i++)); do
    sink_name=$(pactl list sinks short | grep -i "bluez_sink.$pulse_mac" | awk '{print $2}')

    if [ -n "$sink_name" ]; then
      echo "Configurando salida de audio: $sink_name"

      # Establecer como sink predeterminado
      pactl set-default-sink "$sink_name"

      # Mover todas las entradas actuales al nuevo sink
      echo "Reenrutando aplicaciones..."
      pactl list short sink-inputs | awk '{print $1}' | xargs -I{} pactl move-sink-input {} "$sink_name"

      return 0
    fi

    echo "Intento $i: Sink no detectado. Esperando..."
    sleep 2
  done

  echo "Advertencia: No se encontró el sink Bluetooth"
  return 1
}

# Función para conectar
connect_headphones() {
  echo "Activando Bluetooth..."
  bluetoothctl power on

  echo "Marcando dispositivo como confiable..."
  bluetoothctl trust "$MAC_ADDRESS"

  echo "Intentando conectar..."
  for i in {1..5}; do
    if bluetoothctl connect "$MAC_ADDRESS" | grep -q "Connection successful"; then
      echo "¡Conexión exitosa!"
      sleep 1 # Pequeña espera para sincronización
      set_pulseaudio_sink
      exit 0
    else
      echo "Intento $i fallido. Reintentando..."
      sleep 2
    fi
  done

  echo "Error: No se pudo conectar después de 5 intentos"
  exit 1
}

# Verificaciones
if ! command -v bluetoothctl || ! command -v pactl; then
  echo "Error: Se requieren bluetoothctl y pactl"
  exit 1
fi

if [[ -z "$MAC_ADDRESS" ]]; then
  echo "Error: Configura la dirección MAC en el script"
  exit 1
fi

connect_headphones
