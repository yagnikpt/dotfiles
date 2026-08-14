#!/bin/env bash

# Target active directory where the script runs
TARGET_DIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"
echo "Targeting Assetto Corsa Directory: $TARGET_DIR"

if [ ! -f "$TARGET_DIR/acs.exe" ] && [ ! -f "$TARGET_DIR/AssettoCorsa.exe" ]; then
  echo "ERROR: This script must be run inside the Assetto Corsa root folder containing acs.exe!"
  exit 1
fi

echo "Wiping every file tracked by Pure & Sol official uninstallers..."

# ==========================================
# 1. PURE REMOVAL (DIRECTIONS FROM PURE.BAT)
# ==========================================
echo "Removing Pure Engine components..."

# Weather scripts & LCS engine paths
rm -rf "$TARGET_DIR/extension/weather/pure"
rm -rf "$TARGET_DIR/extension/weather/Pure LCS"

# Dynamic and Static controllers
rm -rf "$TARGET_DIR/extension/weather-controllers/pureCtrl"
rm -rf "$TARGET_DIR/extension/weather-controllers/pureCtrl static"

# Config configurations, skydomes, and tools
rm -rf "$TARGET_DIR/extension/config-ext/Pure"
rm -rf "$TARGET_DIR/extension/config-ext/Pure LCS"
rm -rf "$TARGET_DIR/extension/config-ext/PurePlanner"
rm -rf "$TARGET_DIR/extension/config-ext/PureShaders"

# Internal Lua apps
rm -rf "$TARGET_DIR/apps/lua/PureConfig"
rm -rf "$TARGET_DIR/apps/lua/PurePP"
rm -rf "$TARGET_DIR/apps/lua/PurePlanner"
rm -rf "$TARGET_DIR/apps/lua/PurePlanner2"
rm -rf "$TARGET_DIR/extension/lua/pp-filters/pure"

# Pure Post Processing Filters (.ini configuration files)
rm -f "$TARGET_DIR/system/cfg/ppfilters/pure.ini"
rm -f "$TARGET_DIR/system/cfg/ppfilters/pureCAM.ini"
rm -f "$TARGET_DIR/system/cfg/ppfilters/pureEYE.ini"
rm -f "$TARGET_DIR/system/cfg/ppfilters/pureHDR.ini"
rm -f "$TARGET_DIR/system/cfg/ppfilters/pureHDR-EYE.ini"
rm -f "$TARGET_DIR/system/cfg/ppfilters/pureCandy.ini"
rm -f "$TARGET_DIR/system/cfg/ppfilters/pureLinear.ini"
rm -f "$TARGET_DIR/system/cfg/ppfilters/pureVR.ini"

# Pure Scriptable Post Processing Filters (.lua logic files)
rm -f "$TARGET_DIR/system/cfg/ppfilters/pure_scripts/pure.lua"
rm -f "$TARGET_DIR/system/cfg/ppfilters/pure_scripts/pureCAM.lua"
rm -f "$TARGET_DIR/system/cfg/ppfilters/pure_scripts/pureEYE.lua"
rm -f "$TARGET_DIR/system/cfg/ppfilters/pure_scripts/pureHDR.lua"
rm -f "$TARGET_DIR/system/cfg/ppfilters/pure_scripts/pureHDR-EYE.lua"
rm -f "$TARGET_DIR/system/cfg/ppfilters/pure_scripts/pureCandy.lua"
rm -f "$TARGET_DIR/system/cfg/ppfilters/pure_scripts/pureLinear.lua"
rm -f "$TARGET_DIR/system/cfg/ppfilters/pure_scripts/pureVR.lua"
rm -f "$TARGET_DIR/system/cfg/ppfilters/pure_scripts/default_script.lua"
rm -f "$TARGET_DIR/system/cfg/ppfilters/pure_scripts/pure_nopp.lua"

# Pure LCS Filter variants
rm -f "$TARGET_DIR/system/cfg/ppfilters/purelcs_scripts/pure.lua"
rm -f "$TARGET_DIR/system/cfg/ppfilters/purelcs_scripts/pureCandy.lua"
rm -f "$TARGET_DIR/system/cfg/ppfilters/purelcs_scripts/pureHDR.lua"
rm -f "$TARGET_DIR/system/cfg/ppfilters/purelcs_scripts/pureVR.lua"
rm -rf "$TARGET_DIR/system/cfg/ppfilters/purelcs_scripts/pure"

# ==========================================
# 2. SOL REMOVAL (DIRECTIONS FROM SOL.BAT)
# ==========================================
echo "Removing Sol Engine components..."

# Individual loose files in filter and texture spaces
rm -f "$TARGET_DIR/system/cfg/ppfilters/custom config example.ini"
rm -f "$TARGET_DIR/system/cfg/ppfilters"/__Sol*.ini
rm -f "$TARGET_DIR/system/cfg/ppfilters/sol_custom_configs"/__Sol*.lua
rm -f "$TARGET_DIR/system/cfg/ppfilters/sol_custom_configs"/custom config example*.lua
rm -f "$TARGET_DIR/extension/textures/color_grading/none.png"
rm -f "$TARGET_DIR/extension/textures/color_grading"/__Sol_*.png
rm -f "$TARGET_DIR/content/gui/icons"/Sol\ *.png

# Delete target parent directory maps matching sol wildcard strings
find "$TARGET_DIR/apps/python/" -maxdepth 1 -type d -name "sol_*" -exec rm -rf {} +
find "$TARGET_DIR/content/weather/" -maxdepth 1 -type d -name "sol_*" -exec rm -rf {} +
find "$TARGET_DIR/extension/weather-controllers/" -maxdepth 1 -type d -name "sol*" -exec rm -rf {} +

# Specific loose weather structures
rm -rf "$TARGET_DIR/extension/weather/simplePPoff"
rm -rf "$TARGET_DIR/extension/weather/sol"
rm -rf "$TARGET_DIR/system/cfg/ppfilters/sol_custom_configs"

echo "Success! Your game directories match a native Windows uninstall."
