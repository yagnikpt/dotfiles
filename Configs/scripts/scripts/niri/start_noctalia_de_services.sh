#!/usr/bin/env bash

systemctl --user add-wants niri.service noctalia.service

systemctl --user enable --now noctalia
