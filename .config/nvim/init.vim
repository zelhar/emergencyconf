"------- START Plug manager
call plug#begin('~/.local/share/nvim/plugged')
"fzf
Plug '/data/data/com.termux/files/usr/bin/fzf'
Plug 'junegunn/fzf.vim'
"useful plugins
Plug 'Townk/vim-autoclose'
Plug 'bling/vim-bufferline'
Plug 'echuraev/translate-shell.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/TextFormat'
Plug 'godlygeek/tabular'
Plug 'dhruvasagar/vim-table-mode'

"Color Themes
Plug 'altercation/vim-colors-solarized'
Plug 'Rsidhoum/bushfire'
Plug 'tomasr/molokai'
Plug 'nanotech/jellybeans.vim'
Plug 'crusoexia/vim-monokai'
Plug 'rakr/vim-one'
Plug 'NLKNguyen/papercolor-theme'
Plug 'morhetz/gruvbox'
Plug 'robertmeta/nofrils'
Plug 'andreypopp/vim-colors-plain'
Plug 'pbrisbin/vim-colors-off'
Plug 'vietjtnguyen/toy-blocks'

"programming plugins
Plug 'Twinside/vim-hoogle' "haskell hoogle plgin
Plug 'neovimhaskell/haskell-vim' "syntax highlighter
Plug 'neoclide/coc.nvim', {'branch': 'release'} "not just haskell.
""""python formatter
Plug 'psf/black'

Plug 'jpalardy/vim-slime'

call plug#end()
"----------------Vim-Plug END ---------------------------------------------------

filetype plugin indent on
syntax on
set autoread
scriptencoding utf-8
set listchars=eol:¬,tab:>»,trail:·
nnoremap <C-Down> j<C-e>
nnoremap <C-Up> k<C-y>
vnoremap <C-Down> <Down><C-e>
vnoremap <C-Up> <Up><C-y>
inoremap <C-Down> <C-X><C-e><Down>
inoremap <C-Up> <C-X><C-y><Up>
"scroll half screnn up/down with Alt-Up Alt-Down
nnoremap <A-Down> <C-d>
nnoremap <A-Up> <C-u>
vnoremap <A-Down> <C-d>
vnoremap <A-Up> <C-u>
inoremap <A-Down> <C-d>
inoremap <A-Up> <C-u>
nnoremap <Leader>] :bn<CR><C-l>
nnoremap <Leader>[ :bp<CR>
nnoremap <Tab> :tabnext<Cr>
nnoremap <S-Tab> :tabprevious<Cr>
nnoremap <Leader><Enter> a<Enter><Esc>
tnoremap <Esc> <C-\><C-n>
set dictionary+=/$HOME/dictionaries/symbols
"make autocomplete with ctrl-n search in the also in the dictionary
set complete+=k
set complete+=kspell
set complete+=i "scan current and included files
set complete+=t "tag completion
set ffs=unix,dos,mac
set cursorline
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor-blinkon400-blinkoff200-blinkwait250,r-cr:hor20-Cursor/lCursor
set splitbelow
set splitright
"Tablet Specific Settings
set noswapfile
set nobackup
set termguicolors
colorscheme darkblue
set spelllang=en,de,es,he
set ignorecase
"plugin settings
"Vim-airline/powerline settings
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
"Some more airline stuff- disable undesired plugin integration
let g:airline#extensions#bufferline#enabled = 0
let g:airline#extensions#branch#enabled = 1
"Some more plugin settings
"for vim-table-mode
"let g:table_mode_corner = '|'
let g:table_mode_corner = '+'
let g:table_mode_corner_corner = '+'
let g:table_mode_header_fillchar = '='
let g:table_mode_verbose = 1
"let g:loaded_table_mode = 1
"Turning off AutoClose only use it when I need to.
let g:AutoCloseOn = 0
let g:AutoClosePairs = {'"': '"', '[': ']', '''': '''', '(': ')', '{': '}'}
"Setting bufferline to my liking
let g:bufferline_echo = 1
let g:bufferline_rotate = 1
let g:bufferline_fname_mod = ':t'
let g:bufferline_fixed_index =  1
"More Vim-airline settings
let g:airline_extensions = ['tabline', 'bufferline', 'whitespace']
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1
"translate-shell settings
let g:trans_default_direction = ":es+de"
let g:trans_directions_list = [
        \['', 'de', 'es'],
        \['en', 'es'],
        \['es', 'en'],
        \['en', 'de'],
        \['de', 'en'],
        \['', 'en'],
        \['', ''],
\]
inoremap <silent> <leader>t <ESC>:Trans<CR><C-w><C-w>
nnoremap <silent> <leader>t :Trans<CR><C-w><C-w>
vnoremap <silent> <leader>t :Trans<CR><C-w><C-w>
autocmd WinEnter * :filetype detect 
"Set (locally) working dir to be the same as the file being edited in the buffer
autocmd BufEnter * silent! lcd %:p:h
"vim-slime
"let g:slime_target = "neovim"
let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"
