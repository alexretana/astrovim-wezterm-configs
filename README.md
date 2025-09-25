# AstroNvim & WezTerm Configurations

This repository contains my personal configuration files for [AstroNvim](https://github.com/AstroNvim/AstroNvim) (Neovim distribution) and [WezTerm](https://wezfurlong.org/wezterm/) terminal emulator.

## 🚀 Features

### WezTerm Configuration
- **TMux-style keybindings** with `Ctrl+B` as leader key
- **Dynamic theming** with 4 color schemes: Ryuuko, Catppuccin Mocha, Sea Shells (Gogh), Tokyo Night
- **Background cycling** with 4 custom background images
- **Opacity controls** with 6 transparency levels (0.85-0.99) and toggle functionality
- **Tab and pane management** similar to tmux
- **PowerShell 7** as default shell with launch menu
- **Custom font**: CaskaydiaCove Nerd Font Mono
- **Performance optimized**: 240 FPS with EGL preference

### WezTerm Keybindings
| Key Combination | Action |
|----------------|---------|
| `Ctrl+B` then `c` | Create new tab |
| `Ctrl+B` then `x` | Close current pane |
| `Ctrl+B` then `\|` | Split horizontally |
| `Ctrl+B` then `-` | Split vertically |
| `Ctrl+B` then `h/j/k/l` | Navigate panes |
| `Ctrl+B` then `arrows` | Resize panes |
| `Ctrl+B` then `1-9` | Switch to tab |
| `Ctrl+B` then `y` | Cycle background images |
| `Ctrl+B` then `u` | Cycle opacity levels |
| `Ctrl+B` then `i` | Toggle opacity on/off |
| `Ctrl+B` then `o` | Cycle color themes |

### AstroNvim Configuration
- **AstroNvim v5+** template with customizations
- **Relative line numbers** and enhanced visual settings
- **LSP signature help** with ray-x/lsp_signature.nvim
- **Discord presence** with andweeb/presence.nvim
- **Custom dashboard** with personalized ASCII art
- **Enhanced autopairs** with custom rules for LaTeX
- **Filetype extensions** and custom configurations

## 📂 Repository Structure

```
├── nvim/                      # AstroNvim configuration
│   ├── lua/
│   │   └── plugins/          # Custom plugin configurations
│   ├── init.lua              # Bootstrap file
│   └── lazy-lock.json        # Plugin lockfile
├── wezterm/
│   ├── assets/               # Background images (bg-1 to bg-4)
│   └── wezterm.lua          # Main configuration file
└── .gitignore               # Excludes sensitive data and caches
```

## 🛠️ Installation

### Prerequisites
- [Neovim](https://neovim.io/) (latest stable)
- [WezTerm](https://wezfurlong.org/wezterm/installation.html)
- [PowerShell 7](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell) (Windows)
- [CaskaydiaCove Nerd Font](https://www.nerdfonts.com/)

### Setup

1. **Backup existing configurations:**
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   mv ~/.local/share/nvim ~/.local/share/nvim.bak
   mv ~/.config/wezterm ~/.config/wezterm.bak
   ```

2. **Clone this repository:**
   ```bash
   git clone https://github.com/alexretana/astrovim-wezterm-configs.git ~/.config/
   ```

3. **For Windows users:**
   - Copy `nvim/` to `%LOCALAPPDATA%\nvim\`
   - Copy `wezterm/` to `%USERPROFILE%\.config\wezterm\`

4. **Install background images:**
   - Place your custom background images as `bg-1.jpg` through `bg-4.jpg` in the `wezterm/assets/` directory
   - Update the path in `wezterm.lua` if using a different location

5. **Start applications:**
   ```bash
   # Start Neovim (plugins will auto-install)
   nvim

   # Start WezTerm with new config
   wezterm
   ```

## 🎨 Customization

### Adding New Themes
Edit the `themes` array in `wezterm/wezterm.lua`:
```lua
local themes = { "Ryuuko", "Catppuccin Mocha", "Sea Shells (Gogh)", "Tokyo Night", "Your New Theme" }
```

### Custom Background Images
1. Add images to `wezterm/assets/` as `bg-X.jpg`
2. Update the cycle count in the `cycle_background` function

### AstroNvim Plugins
Add new plugins in `nvim/lua/plugins/user.lua` (uncomment the return statement first).

## 🔒 Security

This repository excludes:
- Session data and caches (`nvim-data/`)
- API keys and credentials
- Temporary files and logs
- Personal configuration overrides

## 📝 Notes

- Background images are not included (add your own to `wezterm/assets/`)
- Paths are configured for Windows; adjust for Linux/macOS
- Some plugins in `user.lua` are disabled by default
- The configuration assumes PowerShell 7 installation at the standard Windows location

## 🤝 Contributing

Feel free to fork this repository and customize it for your needs. If you find improvements or fixes, pull requests are welcome!