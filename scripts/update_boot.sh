#!/usr/bin/env bash

SCRIPT="/root/atlas_check.sh"

sed -i "s|^exit 0|${SCRIPT}\nexit 0|" /etc/rc.local
exit 0
