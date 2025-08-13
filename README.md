# 🚀 Vim Setup Script

A comprehensive, one-command Vim configuration script that transforms your vanilla Vim into a powerful, modern development environment.

## ✨ Features

### 🎨 **Beautiful Themes**
- **5 Popular Color Schemes**: Gruvbox, Dracula, OneDark, Nord, Sonokai
- **Theme Cycling**: Press `F4` to instantly switch between themes
- **Matching Status Bar**: Airline themes automatically sync with your colorscheme

### 📁 **File Management**
- **NerdTree**: Elegant file explorer with tree view
- **Quick Navigation**: `Ctrl+n` to toggle, `Ctrl+f` to find current file
- **Auto-close**: Smart closing when NerdTree is the last window

### 🔧 **Git Integration**
- **GitGutter**: Visual diff indicators in the gutter
- **Fugitive**: Full Git workflow within Vim
- **Status Bar Integration**: See current branch and changes at a glance

### 📄 **JSON Support**
- **Syntax Highlighting**: Enhanced JSON syntax with proper indentation
- **Formatting**: Built-in JSON formatting with `jq` and Python
- **Smart Settings**: Auto-configured 2-space indentation for JSON files

### ⚡ **Enhanced Productivity**
- **Smart Line Numbers**: Hybrid absolute/relative numbering
- **Improved Search**: Highlighted results with easy navigation
- **Window Management**: Intuitive `Ctrl+hjkl` navigation
- **Clipboard Integration**: Seamless system clipboard support

## 🛠️ Installation

### One-Command Setup
```bash
curl -fsSL https://raw.githubusercontent.com/ensonb/vimplug/main/vimplug_install.sh | bash
```

### Manual Installation
```bash
# Clone the repository
git clone https://github.com/ensonb/vimplug.git
cd [REPO-NAME]

# Make executable and run
chmod +x vimplug_install.sh
./vimplug_install.sh
```

## 🎮 Key Mappings

### File Management
| Key | Action |
|-----|--------|
| `Ctrl+n` | Toggle NerdTree |
| `Ctrl+f` | Find current file in NerdTree |

### Navigation
| Key | Action |
|-----|--------|
| `Ctrl+h/j/k/l` | Navigate between windows |
| `F3` | Toggle relative line numbers |
| `F4` | Cycle through color themes |

### Quick Actions
| Key | Action |
|-----|--------|
| `\w` | Quick save |
| `\q` | Quick quit |
| `\h` | Clear search highlighting |

### JSON
| Key | Action |
|-----|--------|
| `\jf` | Format JSON with jq |
| `\jp` | Format JSON with Python |

### Git
| Key | Action |
|-----|--------|
| `\gs` | Git status |
| `\ga` | Git add current file |
| `\gc` | Git commit |
| `\gd` | Git diff split |
| `]h` | Next git hunk |
| `[h` | Previous git hunk |

### Search
| Key | Action |
|-----|--------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` | Next match (centered) |
| `N` | Previous match (centered) |

## 🔧 What Gets Installed

### Plugins
- **[NerdTree](https://github.com/preservim/nerdtree)** - File system explorer
- **[Airline](https://github.com/vim-airline/vim-airline)** - Lean & mean status/tabline
- **[GitGutter](https://github.com/airblade/vim-gitgutter)** - Git diff in the gutter
- **[Fugitive](https://github.com/tpope/vim-fugitive)** - Premier Git plugin
- **[vim-json](https://github.com/elzr/vim-json)** - Better JSON for Vim

### Color Schemes
- **[Gruvbox](https://github.com/morhetz/gruvbox)** - Retro groove color scheme
- **[Dracula](https://github.com/dracula/vim)** - Dark theme with vibrant colors
- **[OneDark](https://github.com/joshdick/onedark.vim)** - Atom's iconic One Dark theme
- **[Nord](https://github.com/arcticicestudio/nord-vim)** - Arctic, north-bluish theme
- **[Sonokai](https://github.com/sainnhe/sonokai)** - High Contrast & Vivid Color Scheme

### Dependencies
- `vim` - The editor itself
- `curl` - For downloading vim-plug
- `git` - Version control integration
- `xclip` - Clipboard integration (Linux)
- `jq` - JSON processing
- `python3` - JSON formatting fallback

## 🖥️ Environment Support

- ✅ **WSL (Windows Subsystem for Linux)**
- ✅ **Ubuntu/Debian** (apt-based systems)
- ✅ **CentOS/RHEL** (yum-based systems)
- ✅ **Most Linux distributions**

## 📚 Getting Help

After installation, run the help script for a complete reference:
```bash
~/vim-help.sh
```

Or use these Vim commands:
```vim
:help NERDTree
:help airline
:help fugitive
```

## 🔄 Maintenance

### Update Plugins
```bash
vim-update  # or vim +PlugUpdate +qall
```

### Clean Unused Plugins
```bash
vim-clean   # or vim +PlugClean +qall
```

### Manual Plugin Management
```vim
:PlugInstall    " Install new plugins
:PlugUpdate     " Update existing plugins
:PlugClean      " Remove unused plugins
```

## 🛡️ Safety Features

- **Automatic Backup**: Existing `.vimrc` is backed up with timestamp
- **Non-destructive**: Preserves your current setup before making changes
- **Confirmation Prompt**: Asks before proceeding with installation
- **Error Handling**: Exits gracefully on any errors

## 🎯 Perfect For

- **New Vim Users**: Get a powerful setup without the learning curve
- **Developers**: Modern IDE-like features in lightweight Vim
- **WSL Users**: Optimized for Windows Subsystem for Linux
- **Git Workflows**: Seamless version control integration
- **JSON Development**: Enhanced support for JSON editing

## 🤝 Contributing

Found a bug or want to add a feature? Contributions are welcome!

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⭐ Show Your Support

If this project helped you, please consider giving it a star! ⭐

---

**Happy Viming!** 🎉

> *Transform your Vim experience from zero to hero in just one command.*
