# ReSkate Mac Performance Launcher

A lightweight `zsh` launch framework engineered to eliminate VRAM-related SSD swap stutter, fix window border glitches, and maintain a locked 60 FPS in *ReSkate* on base 8GB Apple Silicon Macs.

## Features
- **Dynamic RAM Detection:** Automatically configures resolution targets based on whether your Mac has 8GB or 16GB+ unified memory.
- **Metal FSR Upscaling:** Renders internally at 50% scale (720p on 8GB hardware) and uses Metal FSR (`WINE_FULLSCREEN_FSR=1`) to output a clean, high-performance display.
- **Memory Optimization:** Forces DirectX 12 buffer compaction (`WINE_D3D12_MEMORY_COMPACT=1`) to prevent unified memory exhaustion.
- **Engine Stripping:** Disables high-overhead passes like `SpotLightShadowmapEnable` and `Dx12AsyncComputeEnable`.
- **Window Management Fixes:** Overrides Wine registry settings to prevent border glitches and force proper fullscreen focus.

---

## Prerequisites
- **Engine Setup:** GameHub / Wine 11 / GPTK installed in the standard application directory.
- **ReSkate** installed in your default Games folder.

---

## Installation & Setup

1. **Clone or Download** this repository to your Mac.
2. Open **Terminal** and navigate to the directory where `Play_ReSkate.command` is saved:
   cd /path/to/repository
3. Make the script executable:
   chmod +x Play_ReSkate.command
4. **Launch the game:** Double-click `Play_ReSkate.command` in Finder or run it directly from the Terminal:
   ./Play_ReSkate.command

---

## Options at Startup

When you run the script, a 3-second diagnostic countdown will display your system specs and selected profile:
- Press **`H`** during the countdown to enable the Metal HUD overlay.
- Otherwise, let the timer run out to launch directly into the game.

---

## In-Game Recommended Settings
To ensure optimal performance and prevent conflicts with the launcher's Metal FSR:
- **Window Mode:** Fullscreen
- **Quality Presets:** Custom (Set World Detail, Textures, Shadows, Meshes, and Lighting to **Low**)
- **In-Game Resolution Scaling:** Off (handled externally by FSR)
- **VSync:** On (Target 60Hz)

---

## Security, Transparency & AI Disclaimer

- **No Root Required:** This script contains no compiled binaries or `sudo` requirements. All launch arguments, environment variables, and registry modifications are completely transparent and readable within `Play_ReSkate.command`.
- **AI-Assisted Engineering:** This launcher and documentation were developed with AI assistance to refine memory management logic, structure shell parameters, and document setup steps for low-spec Mac users.

---

## Credits
Special thanks to **u/Early_Technician_540** on r/Skate4 for discovering the baseline GameHub, Wine, and GPTK translation configurations.
