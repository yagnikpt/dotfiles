#!/usr/bin/env bash

systemctl --user add-wants niri.service noctalia
systemctl --user add-wants niri.service mate-polkit

systemctl --user enable --now noctalia
systemctl --user enable --now mate-polkit
