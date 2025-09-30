!# /bin/bash

#Instalacion automatica
sudo apt install ./nvim-linux-x86_64.deb rofi i3 i3status ranger picom kitty libreoffice vim lsd

# Instalar fuentes
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip

unzip FiraCode.zip

sudo mv -t /usr/share/fonts/ $(ls | grep FiraCode)

#Limpiar la cache de las fuentes
fc-cache -t -v
