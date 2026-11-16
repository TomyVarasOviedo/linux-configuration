#!/usr/bin/bash
IMAGE_BASE=$(cat /home/tomy/.config/automatizacion/background-changer/base-img.txt)
BASE_DIR="/home/tomy/Documentos/Fondos"

show_help() {
  echo "Usage: background-command.sh [OPTIONS] [IMAGE_NAME]"
  echo ""
  echo "Change the desktop wallpaper using feh."
  echo ""
  echo "Arguments:"
  echo "  IMAGE_NAME    Image filename from $BASE_DIR (optional)"
  echo ""
  echo "Options:"
  echo "  -l IMAGE_NAME Set lock screen wallpaper"
  echo "  --help        Show this help message"
  echo ""
  echo "Examples:"
  echo "  background-command.sh              # Use default image from base-img.txt"
  echo "  background-command.sh my-image.jpg # Change to specific image"
  echo "  background-command.sh -l my-image.jpg # Set lock screen image"
}
check_image() {
  if [[ -f "$1" ]]; then
    MIME_TYPE=$(file -i "$BASE_DIR/$1" | cut -d: -f2 | xargs)
    case "$MIME_TYPE" in
    image/*)
      return 1
      ;;
    *)
      echo "El archivo no es una imagen"
      return 0
      ;;
    esac
  else
    echo "el archivo no existe"
    return 0
  fi
}

if [[ "$1" = "--help" ]]; then
  show_help
  exit 0
fi

if [[ "$1" = "-l" ]]; then
  if [[ -z "$2" ]]; then
    echo "Error: -l requires an image name"
    exit 1
  fi
  check_image $2
  resultado=$?
  if [ "$resultado" -eq 1 ]; then
    echo "$2" >~/.config/automatizacion/background-changer/lock-img.txt
    echo "Lock screen image updated to: $2"
  else
    echo "Error al cambiar la imagen de lockscreen"
  fi
  exit 0
fi

change_background() {
  # $1: Nombre de la imagen para cambiar el fondo de pantalla, debe estar en DIR_BASE
  feh --bg-fill "$BASE_DIR/$1"
}

if [[ $# -eq 0 ]]; then
  change_background $IMAGE_BASE
else
  check_image $1
  resultado=$?
  if [ "$resultado" -eq 1 ]; then
    echo "$1" >~/.config/automatizacion/background-changer/base-img.txt
    change_background "$1"
  else
    echo "Error al cambiar de fondo de pantalla"
  fi
fi
