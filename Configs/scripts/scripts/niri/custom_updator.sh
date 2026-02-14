#!/bin/env bash

mapfile -t arr < <(dnf list --upgrades | awk 'NR > 2 { print $1 }')

for item in "${arr[@]}"; do
    sudo dnf up "$item" -y
done
