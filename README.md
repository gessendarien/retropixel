# RetroPixel - GIMP Plugin

![Version](https://img.shields.io/badge/version-1.1.0-blue)
![GIMP](https://img.shields.io/badge/GIMP-3.0%2B-green)
![License](https://img.shields.io/badge/license-GPL%20v3-orange)

GIMP plugin that applies PS1/N64 style pixelation effects, ideal for creating retro textures for 3D objects.

## Features

- **Adjustable Pixelation**: Control pixel size for the retro effect
- **Color Reduction**: Simulates the limited palette of old consoles
- **Dithering**: Adds retro-style noise for color transitions
- **Target Resolution**: Define specific dimensions for 3D textures
- **Easy to Use**: Integrated interface in GIMP

## Preview

<div align="center">
  <img src="screenshot_1.png" width="60%" alt="RetroPixel GIMP"/>
  <br/>
  <img src="screenshot_2.png" width="60%" alt="RetroPixel Effect GIMP"/>
</div>

## Parameters

| Parameter | Description | Range | Default |
|-----------|-------------|-------|---------|
| **Preset** | Quick settings (Custom/PS1 Low/PS1 Med/N64/Extreme) | - | Custom |
| **Pixel Size** | Size of each pixel block (ignored with presets) | 2-32 | 8 |
| **Colors** | Colors in the palette (ignored with presets) | 4-256 | 32 |
| **Output Width** | Output width in pixels, 0 = original (ignored with presets) | 0-512 | 0 |
| **Output Height** | Output height in pixels, 0 = original (ignored with presets) | 0-512 | 0 |
| **Dithering** | None / Floyd-Steinberg / Positioned | - | None |
| **Color Tint** | Apply retro color tint (None/Red/Orange/Yellow/etc.) | - | None |

## Usage

### Windows:
- Download the code from the "Code" button at the top.
- Extract the file and save the RetroPixel folder in a location of your choice.
- Open GIMP and go to **Edit > Preferences > Folders** (at the bottom of the left-hand menu).
- Expand the option by clicking the arrow.
- Go to **Plug-ins** and add the folder where you saved the script.
- Restart GIMP.
- Test RetroPixel from **Filters > Distorts > RetroPixel**.

### Linux:
- Download the code from the "Code" button at the top.
- Extract the file and save the RetroPixel folder in a location of your choice.
- Grant all permissions to the `RetroPixel.scm` script.
- Copy the `RetroPixel.scm` file to the folder `~/.config/GIMP/3.0/scripts/` (make sure it matches the version of GIMP you are using).
- Open GIMP.
- Test RetroPixel from **Filters > Distorts > RetroPixel**.


## Usage Examples

### Texture for 3D model (64x64)
```
Preset: Custom
Pixel Size: 8
Colors: 32
Output Width: 64
Output Height: 64
Dithering: Floyd-Steinberg
```

### Intense PS1 effect
```
Preset: PS1 Low (128×128)
Dithering: Positioned
Color Tint: Sepia
```

### Soft N64 effect
```
Preset: N64 (256×256)
Dithering: Floyd-Steinberg
Color Tint: None
```

## Recommended Workflow for 3D Textures

1. Prepare your original texture in high resolution
2. Apply the RetroPixel plugin with your target texture dimensions
3. Export as PNG or TGA
4. Import into your 3D engine (Unity, GDevelop, Blender, etc.)
5. Set the texture filter to "Point" or "Nearest" to maintain the pixelated effect

## License

This project is licensed under the GNU General Public License v3.0. See the LICENSE file for details.

## Credits

By gessendarien 🦧 Inspired by the texture aesthetics of PlayStation 1 and Nintendo 64.

---

**Enjoy creating retro textures with RetroPixel! 🎮✨**

---

## Support the Project

If you find this plugin useful, consider supporting:

[![Support via PayPal](https://img.shields.io/badge/Donate-PayPal-blue.svg)](https://paypal.me/gessendarien)

Thank you! 💚🫰

