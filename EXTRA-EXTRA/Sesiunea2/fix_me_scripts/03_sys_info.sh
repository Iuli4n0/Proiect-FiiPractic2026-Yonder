#!/bin/bash

echo "=== System Info ==="

distro=$(cat /etc/os-release | grep "^NAME" | cut -d= -f2)
echo "Distro: $distro"

ram_total=$(free -m | awk 'NR==2{print $2}')
ram_used=$(free -m | awk 'NR==2{print $3}')
echo "RAM: ${ram_used}MB used of ${ram_total}MB"

if [[ $ram_used -gt $((ram_total / 2)) ]]; then
  echo "WARNING: over 50% RAM in use"
else
  echo "RAM usage is fine"
fi
