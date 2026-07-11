#!/usr/bin/env bash

systemctl --user add-wants niri.service noctalia_v5
systemctl --user add-wants niri.service mate-polkit

systemctl --user enable --now noctalia_v5
systemctl --user enable --now mate-polkit
