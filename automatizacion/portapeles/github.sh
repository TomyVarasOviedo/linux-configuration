#!/usr/bin/bash
#Poner ruta del archivo txt donde se guarde el token
GITHUB_TOKEN=$(cat ~/github-token.txt)

echo $GITHUB_TOKEN | xclip -selection clipboard
