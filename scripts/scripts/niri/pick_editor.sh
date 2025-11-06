#!/usr/bin/env bash

editor="$1"
dir=$(zoxide query --interactive)
if [[ -z "$dir" || -z "$editor" ]]; then
    exit 0
fi

eval "$editor $dir"
