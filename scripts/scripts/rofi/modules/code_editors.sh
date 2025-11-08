#!/bin/env bash

vscode="Code"
zed="Zed"
neovim="Neovim"

options="$vscode\n$zed\n$neovim"

val=$(echo -e $options | rofi -dmenu -p "Code Editors" -l 3 -theme ~/.config/rofi/modules/base.rasi)

case "$val" in
    $vscode)
        $HOME/scripts/rofi/modules/vscode_workspaces.sh
        ;;
    $zed)
        kitty --title="code-editor-tui" -e zsh -i -c "$HOME/scripts/niri/pick_editor.sh zed"
        ;;
    $neovim)
        kitty --title="code-editor-tui" -e zsh -i -c "$HOME/scripts/niri/pick_editor.sh nvim" &
        ;;
    *)
        exit 0
        ;;
esac
