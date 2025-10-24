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
  echo "Introduce el correo electrónico que has configurado para enviar los cambios: " MAIL
  sed -i "s|your_mail@gmail.com|$MAIL|" script/check-public-ip.sh
  cp systemd/* /etc/systemd/system/
  cp script/check-public-ip.sh /usr/local/bin/
  systemctl daemon-reload
  systemctl enable --now rsync-backup-systemd.timer
  echo -e "${VERDE}[+] El servicio se instalo correctamente.${$RESET}"
}

verification_root
install_all
