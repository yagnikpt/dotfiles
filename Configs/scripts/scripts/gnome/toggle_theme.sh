#!/usr/bin/env bash

current_theme=$(gsettings get org.gnome.desktop.interface color-scheme)
os_theme='default'
shell_theme='Marble-sysacc-light'
if [ $current_theme == "'prefer-dark'" ]; then
	os_theme='default'
	shell_theme='Marble-sysacc-light'
else
	os_theme='prefer-dark'
	shell_theme='Marble-sysacc-dark'
fi
gsettings set org.gnome.desktop.interface color-scheme $os_theme
gsettings set org.gnome.shell.extensions.user-theme name $shell_theme
