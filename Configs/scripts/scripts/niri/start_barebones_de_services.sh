#!/usr/bin/env bash

systemctl --user unmask mako

systemctl --user add-wants niri.service waybar
systemctl --user add-wants niri.service mako
systemctl --user add-wants niri.service swww
systemctl --user add-wants niri.service gammastep
systemctl --user add-wants niri.service hypridle
systemctl --user add-wants niri.service battery-watch
systemctl --user add-wants niri.service mate-polkit

systemctl --user enable --now waybar
systemctl --user enable --now mako
systemctl --user enable --now swww
systemctl --user enable --now gammastep
systemctl --user enable --now hypridle
systemctl --user enable --now battery-watch
systemctl --user enable --now mate-polkit
