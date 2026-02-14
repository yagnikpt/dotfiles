#!/usr/bin/env bash

rm -rf ~/.config/discord/Cache
rm -rf ~/.npm/_cacache
rm -rf ~/.npm/_npx
rm -rf ~/go/pkg/mod/cache
rm -rf ~/.local/share/zed/node/cache
rm -rf ~/.bun/install/cache
rm -rf ~/.cache/go-build
rm -rf ~/.var/app/com.spotify.Client/cache/

bunx npkill
