#!/usr/bin/env bash

systemctl --user add-wants niri.service inir
systemctl --user add-wants niri.service mate-polkit

systemctl --user enable --now inir
systemctl --user enable --now mate-polkit
