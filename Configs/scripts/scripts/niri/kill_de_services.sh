#!/usr/bin/env bash

systemctl --user disable --now waybar
systemctl --user disable --now mako
systemctl --user mask mako
systemctl --user disable --now swww
systemctl --user disable --now gammastep
systemctl --user disable --now hypridle

systemctl --user disable --now noctalia

systemctl --user disable --now battery-watch
