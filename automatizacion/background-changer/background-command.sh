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
  echo "  --help        Show this help message"
  echo ""
  echo "Examples:"
  echo "  background-command.sh              # Use default image from base-img.txt"
  echo "  background-command.sh my-image.jpg # Change to specific image"
}

if [[ "$1" = "--help" ]]; then
  show_help
  exit 0
fi

change_background() {
  # $1: Nombre de la imagen para cambiar el fondo de pantalla, debe estar en DIR_BASE
  feh --bg-fill "$BASE_DIR/$1"
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
