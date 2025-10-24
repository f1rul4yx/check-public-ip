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

remove_all() {
  sudo systemctl stop check-public-ip.timer
  sudo systemctl stop check-public-ip.service
  sudo systemctl disable check-public-ip.timer
  sudo systemctl disable check-public-ip.service
  rm -r /etc/check-public-ip
  rm -r /etc/systemd/system/check-public-ip*
  rm -r /usr/local/bin/check-public-ip.sh
  systemctl daemon-reload
  echo -e "${VERDE}[+] El servicio se desinstalo correctamente.${RESET}"
}

verification_root
remove_all
