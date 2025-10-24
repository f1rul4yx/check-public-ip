#!/bin/bash

CONFIG="/etc/check-public-ip/"
CURRENT_IP="$CONFIG/current_ip.txt"
NEW_IP="$CONFIG/new_ip.txt"
CHECK_IP=$(curl ifconfig.me)
MAIL="your_mail.gmail.com"

if [[ ! -d $CONFIG ]]; then
  mkdir $CONFIG
fi

echo "$CHECK_IP" > $CURRENT_IP

if [[ ! -f $NEW_IP ]]; then
  touch $NEW_IP
fi

diff $CURRENT_IP $NEW_IP
if [[ $? -ne 0 ]]; then
  echo "$CHECK_IP" > $NEW_IP
  echo "$(cat $NEW_IP)" | mail -s "Nueva IP Pública" "$MAIL"
fi
