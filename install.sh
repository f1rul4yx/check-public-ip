#!/bin/bash

RESET="\e[0m"
ROJO="\e[31m"
VERDE="\e[32m"

verification_root() {
  if [[ "$EUID" -ne 0 ]]; then
    echo -e "${ROJO}[-] Este script se debe ejecutar con permisos de root.${RESET}"
    exit 1
  fi
}

install_all() {
  whereis curl
  if [[ $? -ne 0 ]]; then
    apt install curl -y
  fi
  read -p "Introduce el correo electrónico que has configurado para enviar los cambios: " MAIL
  cp systemd/* /etc/systemd/system/
  cp script/check-public-ip.sh /usr/local/bin/
  sed -i "s|^MAIL=.*|MAIL=\"$MAIL\"|" /usr/local/bin/check-public-ip.sh
  systemctl daemon-reload
  systemctl enable --now check-public-ip.timer
  echo -e "${VERDE}[+] El servicio se instalo correctamente.${RESET}"
}

verification_root
install_all
