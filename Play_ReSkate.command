#!/bin/zsh

export WINEPREFIX="$HOME/Library/Application Support/ReSkate/prefix"
export WINEDEBUG=-all
export WINEMSYNC=1
export ROSETTA_ADVERTISE_AVX=1
export MTL_DEBUG_LAYER=0
export RESKATE_CRASH_REPORTING=0
export WINE_SIMULATE_WRITECOPY=1

# Metal & Wine Fullscreen Stretch Overrides
export WINE_FULLSCREEN_FSR=1
export WINE_FULLSCREEN_FSR_STRENGTH=2
export WINE_D3D12_NO_STAGING_PIPELINE=1
export WINE_D3D12_MEMORY_COMPACT=1
export MTL_SHADER_VALIDATION=0

RESKATE_ENGINE="$HOME/Library/Application Support/com.gamemac.www/wine-engine"
RESKATE_WINE="$RESKATE_ENGINE/containers/wine_installations/10000073/bin/wine"
RESKATE_GPTK="$RESKATE_ENGINE/downloads/gptk-4.0-2"

export WINE_GPTK_LIBD3DSHARED_PATH="$RESKATE_GPTK/external/libd3dshared.dylib"
export WINEDLLPATH="$RESKATE_GPTK/wine"

# Disable Wine Virtual Desktop & Force Fullscreen Grab
"$RESKATE_ENGINE/containers/wine_installations/10000073/bin/reg" add "HKCU\Software\Wine\X11 Driver" /v "GrabFullscreen" /t REG_SZ /d "Y" /f >/dev/null 2>&1
"$RESKATE_ENGINE/containers/wine_installations/10000073/bin/reg" add "HKCU\Software\Wine\X11 Driver" /v "Decorations" /t REG_SZ /d "N" /f >/dev/null 2>&1

cd "$HOME/Games/ReSkate/game"

clear
echo "=========================================="
echo "    ReSkate Auto-Detecting Hardware...    "
echo "=========================================="

RAM_BYTES=$(sysctl -n hw.memsize)
RAM_GB=$(( RAM_BYTES / 1073741824 ))
CPU_NAME=$(sysctl -n machdep.cpu.brand_string)

if (( RAM_GB <= 8 )); then
    AUTO_PRESET="1"
    DEFAULT_WIDTH=1280
    DEFAULT_HEIGHT=720
    PROFILE_NAME="Low Overhead (8GB Constraint Mode)"
else
    AUTO_PRESET="2"
    DEFAULT_WIDTH=1920
    DEFAULT_HEIGHT=1080
    PROFILE_NAME="High Performance (16GB+ Active Mode)"
fi

ENABLE_HUD=0

echo " CPU: $CPU_NAME"
echo " RAM: ${RAM_GB} GB Unified Memory"
echo " Detected Profile: $PROFILE_NAME"
echo " Target Resolution: ${DEFAULT_WIDTH}x${DEFAULT_HEIGHT}"
echo "=========================================="
echo " Starting in 3 seconds... (Press 'H' for HUD, 'M' for Menu)"

read -t 3 -k 1 USER_INPUT
echo ""

if [[ "$USER_INPUT" == "h" || "$USER_INPUT" == "H" ]]; then
    ENABLE_HUD=1
fi

export MTL_HUD_DATA=$ENABLE_HUD

# Launch with forced resolution and screen flags
"$RESKATE_WINE" ReSkateLauncher.exe \
  -WorldRender.FrameSynthesisMode FrameSynthesisMode_Off \
  -Render.ResolutionScale 0.50 \
  -Render.ResolutionScaleMin 0.50 \
  -Render.DynamicResolutionScaleEnable 0 \
  -Render.Dx12AsyncComputeEnable 0 \
  -Render.FxaaEnable 0 \
  -WorldRender.MotionBlurEnable 0 \
  -WorldRender.DepthOfFieldEnable 0 \
  -GstRender.FullscreenEnabled 1 \
  -GstRender.FullscreenMode 0 \
  -GstRender.ResolutionWidth $DEFAULT_WIDTH \
  -GstRender.ResolutionHeight $DEFAULT_HEIGHT \
  -GstRender.ScreenRefreshRate 60.00 \
  -ignorePipelineCacheErrors \
  -nosplash
