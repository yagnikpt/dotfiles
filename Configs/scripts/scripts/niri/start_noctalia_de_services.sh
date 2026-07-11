#!/usr/bin/env bash

systemctl --user add-wants niri.service noctalia

systemctl --user enable --now noctalia
