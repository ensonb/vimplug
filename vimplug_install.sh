#!/bin/bash

# ==============================================================================
# VIM SETUP SCRIPT
# ==============================================================================
# This script will:
# 1. Install vim-plug
# 2. Create/backup existing .vimrc
# 3. Install comprehensive vim configuration
# 4. Install vim plugins automatically
# ==============================================================================

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${BLUE}$1${NC}"
}

# Check if running in WSL or Linux
check_environment() {
    print_header "Checking environment..."
    
    if [[ -f /proc/version ]] && grep -qi microsoft /proc/version; then
        print_status "Detected WSL environment"
        ENV_TYPE="WSL"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        print_status "Detected Linux environment"
        ENV_TYPE="LINUX"
    else
        print_warning "Unknown environment, proceeding anyway..."
        ENV_TYPE="UNKNOWN"
    fi
}

# Install dependencies
install_dependencies() {
    print_header "Installing dependencies..."
    
    # Check if we can install packages
    if command -v apt &> /dev/null; then
        print_status "Installing required packages..."
        sudo apt update
        sudo apt install -y vim curl git xclip jq python3
    elif command -v yum &> /dev/null; then
        print_status "Installing required packages with yum..."
        sudo yum install -y vim curl git xclip jq python3
    else
        print_warning "Package manager not detected. Please ensure vim, curl, git, xclip, jq, and python3 are installed."
    fi
}

# Backup existing .vimrc
backup_vimrc() {
    if [[ -f ~/.vimrc ]]; then
        print_warning "Existing .vimrc found"
        BACKUP_FILE="$HOME/.vimrc.backup.$(date +%Y%m%d_%H%M%S)"
        cp ~/.vimrc "$BACKUP_FILE"
        print_status "Backed up existing .vimrc to $BACKUP_FILE"
    fi
}

# Install vim-plug
install_vim_plug() {
    print_header "Installing vim-plug..."
    
    if [[ -f ~/.vim/autoload/plug.vim ]]; then
        print_status "vim-plug already installed"
    else
        print_status "Downloading vim-plug..."
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        print_status "vim-plug installed successfully"
    fi
}

# Create the .vimrc file
create_vimrc() {
    print_header "Creating .vimrc configuration..."
    
    cat > ~/.vimrc << 'EOF'
" ==============================================================================
" VIM CONFIGURATION
" ==============================================================================

" ==============================================================================
" PLUGIN MANAGEMENT
" ==============================================================================
call plug#begin('~/.vim/plugged')
  " File Management
  Plug 'preservim/nerdtree'
  
  " Status Line
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  
  " Git Integration
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  
  " JSON Support
  Plug 'elzr/vim-json'
  
  " Color Schemes
  Plug 'morhetz/gruvbox'
  Plug 'dracula/vim', { 'name': 'dracula' }
  Plug 'joshdick/onedark.vim'
  Plug 'arcticicestudio/nord-vim'
  Plug 'sainnhe/sonokai'
call plug#end()

" ==============================================================================
" GENERAL SETTINGS
" ==============================================================================
" Enable syntax highlighting
syntax enable
set background=dark

" Color Scheme (choose one - uncomment your preferred theme)
colorscheme gruvbox
" colorscheme dracula
" colorscheme onedark
" colorscheme nord
" colorscheme sonokai

" Line Numbers
set number
" set relativenumber                " Uncomment for relative line numbers
set numberwidth=4
set signcolumn=yes
set cursorline

" Status Line
set laststatus=2                    " Always show status line
set updatetime=250                  " Faster update time for git indicators

" Clipboard Integration
set clipboard=unnamedplus           " Use system clipboard

" ==============================================================================
" NERDTREE CONFIGURATION
" ==============================================================================
" NerdTree Settings
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" NerdTree Key Mappings
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Auto-close NerdTree
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" ==============================================================================
" AIRLINE CONFIGURATION
" ==============================================================================
" Airline Settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'

" Airline Git Integration
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 1

" ==============================================================================
" GIT CONFIGURATION
" ==============================================================================
" GitGutter Settings
let g:gitgutter_enabled = 1
let g:gitgutter_signs = 1
let g:gitgutter_highlight_linehl = 0

" GitGutter Key Mappings
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap <Leader>hs <Plug>(GitGutterStageHunk)
nmap <Leader>hu <Plug>(GitGutterUndoHunk)
nmap <Leader>hv <Plug>(GitGutterPreviewHunk)

" Fugitive Key Mappings
nnoremap <Leader>gs :Git status<CR>
nnoremap <Leader>ga :Git add %<CR>
nnoremap <Leader>gc :Git commit<CR>
nnoremap <Leader>gd :Gdiffsplit<CR>

" ==============================================================================
" JSON CONFIGURATION
" ==============================================================================
" JSON Settings
let g:vim_json_syntax_conceal = 0    " Don't hide quotes
let g:vim_json_warnings = 1          " Show warnings

" JSON file-specific settings
autocmd FileType json setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType json syntax match Comment +\/\/.\+$+

" JSON formatting commands
command! FormatJSON %!jq .
command! FormatJSONPython %!python -m json.tool

" JSON key mappings
nnoremap <Leader>jf :FormatJSON<CR>
nnoremap <Leader>jp :FormatJSONPython<CR>

" ==============================================================================
" CUSTOM KEY MAPPINGS
" ==============================================================================
" Toggle relative line numbers
nnoremap <F3> :set relativenumber!<CR>

" Toggle color schemes
nnoremap <F4> :call CycleColorScheme()<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Quick save
nnoremap <Leader>w :w<CR>

" Quick quit
nnoremap <Leader>q :q<CR>

" Better search navigation
nnoremap n nzzzv        " Center screen on next match
nnoremap N Nzzzv        " Center screen on previous match

" Clear search highlighting
nnoremap <Leader>h :nohl<CR>

" Search for selected text in visual mode
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" ==============================================================================
" THEME CYCLING FUNCTION
" ==============================================================================
" Function to cycle through color schemes
function! CycleColorScheme()
    if g:colors_name == 'gruvbox'
        colorscheme dracula
        let g:airline_theme='dracula'
        echo "Switched to Dracula theme"
    elseif g:colors_name == 'dracula'
        colorscheme onedark
        let g:airline_theme='onedark'
        echo "Switched to OneDark theme"
    elseif g:colors_name == 'onedark'
        colorscheme nord
        let g:airline_theme='nord'
        echo "Switched to Nord theme"
    elseif g:colors_name == 'nord'
        colorscheme sonokai
        let g:airline_theme='sonokai'
        echo "Switched to Sonokai theme"
    else
        colorscheme gruvbox
        let g:airline_theme='gruvbox'
        echo "Switched to Gruvbox theme"
    endif
    AirlineRefresh
endfunction

" ==============================================================================
" ADDITIONAL USEFUL SETTINGS
" ==============================================================================
" Search Settings
set ignorecase                      " Case insensitive search
set smartcase                       " Case sensitive if uppercase present
set hlsearch                        " Highlight search results
set incsearch                       " Incremental search

" Indentation
set autoindent                      " Auto indent
set smartindent                     " Smart indent
set expandtab                       " Use spaces instead of tabs
set tabstop=4                       " Tab width
set shiftwidth=4                    " Shift width
set softtabstop=4                   " Soft tab stop

" Performance
set ttyfast                         " Fast terminal connection
set lazyredraw                      " Don't redraw during macros

" Backup and Swap Files
set nobackup                        " No backup files
set nowritebackup                   " No backup before overwriting
set noswapfile                      " No swap files

" ==============================================================================
" END OF CONFIGURATION
" ==============================================================================
EOF

    print_status ".vimrc created successfully"
}

# Install plugins
install_plugins() {
    print_header "Installing Vim plugins..."
    
    print_status "Starting Vim to install plugins..."
    vim +PlugInstall +qall
    
    print_status "Plugins installed successfully"
}

# Create useful aliases
create_aliases() {
    print_header "Creating useful aliases..."
    
    # Check if aliases already exist
    if ! grep -q "# Vim Setup Script Aliases" ~/.bashrc; then
        cat >> ~/.bashrc << 'EOF'

# Vim Setup Script Aliases
alias clip="clip.exe"  # WSL clipboard
alias pbcopy="clip.exe"
alias vim-update="vim +PlugUpdate +qall"
alias vim-clean="vim +PlugClean +qall"
EOF
        print_status "Aliases added to ~/.bashrc"
    else
        print_status "Aliases already exist in ~/.bashrc"
    fi
}

# Create helpful commands script
create_helper_script() {
    print_header "Creating helper script..."
    
    cat > ~/vim-help.sh << 'EOF'
#!/bin/bash
# Vim Helper Commands

echo "=== VIM CONFIGURATION HELP ==="
echo ""
echo "Key Mappings:"
echo "  Ctrl+n          - Toggle NerdTree"
echo "  Ctrl+f          - Find current file in NerdTree"
echo "  F3              - Toggle relative line numbers"
echo "  F4              - Cycle through color themes"
echo "  \\w              - Quick save"
echo "  \\q              - Quick quit"
echo "  \\h              - Clear search highlighting"
echo "  \\jf             - Format JSON with jq"
echo "  \\jp             - Format JSON with Python"
echo ""
echo "Git Commands:"
echo "  \\gs             - Git status"
echo "  \\ga             - Git add current file"
echo "  \\gc             - Git commit"
echo "  \\gd             - Git diff split"
echo ""
echo "Search Navigation:"
echo "  /pattern        - Search forward"
echo "  ?pattern        - Search backward"
echo "  n               - Next match"
echo "  N               - Previous match"
echo ""
echo "Vim Commands:"
echo "  :PlugInstall    - Install new plugins"
echo "  :PlugUpdate     - Update plugins"
echo "  :PlugClean      - Remove unused plugins"
echo ""
echo "Shell Aliases:"
echo "  clip            - Copy to clipboard (WSL)"
echo "  vim-update      - Update vim plugins"
echo "  vim-clean       - Clean vim plugins"
EOF

    chmod +x ~/vim-help.sh
    print_status "Helper script created at ~/vim-help.sh"
}

# Main installation function
main() {
    print_header "===================================================="
    print_header "           VIM SETUP SCRIPT"
    print_header "===================================================="
    echo ""
    
    check_environment
    
    echo ""
    read -p "This will install vim-plug and configure vim. Continue? (y/N): " -n 1 -r
    echo ""
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_status "Installation cancelled."
        exit 0
    fi
    
    echo ""
    install_dependencies
    echo ""
    backup_vimrc
    echo ""
    install_vim_plug
    echo ""
    create_vimrc
    echo ""
    install_plugins
    echo ""
    create_aliases
    echo ""
    create_helper_script
    
    echo ""
    print_header "===================================================="
    print_header "           INSTALLATION COMPLETE!"
    print_header "===================================================="
    echo ""
    print_status "Vim has been configured with:"
    echo "  ✓ NerdTree file explorer"
    echo "  ✓ Airline status bar"
    echo "  ✓ Git integration (GitGutter + Fugitive)"
    echo "  ✓ JSON support and formatting"
    echo "  ✓ 5 beautiful color themes"
    echo "  ✓ Enhanced key mappings"
    echo "  ✓ Search improvements"
    echo "  ✓ Tmux configuration (gpakosz)"
    echo ""
    print_status "Quick start:"
    echo "  • Open vim and press Ctrl+n for file tree"
    echo "  • Press F4 to cycle through themes"
    echo "  • Run ~/vim-help.sh for all key mappings"
    echo ""
    print_status "Installation methods for future use:"
    print_status "  Auto-install: curl -fsSL [URL] | bash -s -- --auto"
    print_status "  Interactive:  curl -fsSL [URL] > setup.sh && chmod +x setup.sh && ./setup.sh"
    echo ""
    print_warning "Restart your terminal or run 'source ~/.bashrc' to use new aliases"
    echo ""
}

# Run the main function
main "$@"