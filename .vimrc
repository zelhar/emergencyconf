" /~/.vimrc
set nocompatible
" Remove ALL autocommands for the current group:
autocmd!
"------- START Plug manager
"call plug#begin('~/.vim/plugged')
""call plug#begin('~/.local/share/nvim/plugged')
""fzf
"Plug '/data/data/com.termux/files/usr/bin/fzf'
"Plug 'junegunn/fzf.vim'
""useful plugins
"Plug 'Townk/vim-autoclose'
"Plug 'bling/vim-bufferline'
"Plug 'echuraev/translate-shell.vim'
"Plug 'scrooloose/nerdtree'
"Plug 'tpope/vim-surround'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'vim-scripts/TextFormat'
"Plug 'godlygeek/tabular'
"Plug 'dhruvasagar/vim-table-mode'
"
""Color Themes
"Plug 'altercation/vim-colors-solarized'
"Plug 'Rsidhoum/bushfire'
"Plug 'tomasr/molokai'
"Plug 'nanotech/jellybeans.vim'
"Plug 'crusoexia/vim-monokai'
"Plug 'rakr/vim-one'
"Plug 'NLKNguyen/papercolor-theme'
"Plug 'morhetz/gruvbox'
"Plug 'robertmeta/nofrils'
"Plug 'andreypopp/vim-colors-plain'
"Plug 'pbrisbin/vim-colors-off'
"Plug 'vietjtnguyen/toy-blocks'
"
""programming plugins
"Plug 'Twinside/vim-hoogle' "haskell hoogle plgin
"Plug 'neovimhaskell/haskell-vim' "syntax highlighter
"Plug 'neoclide/coc.nvim', {'branch': 'release'} "not just haskell.
"""""python formatter
"Plug 'psf/black'
"
"Plug 'jpalardy/vim-slime'
"
"call plug#end()
""----------------Vim-Plug END ---------------------------------------------------

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
"set dictionary+=/$HOME/dictionaries/symbols
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
"set spelllang=en,de,es,he
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
"
"Testing Konsole cursor shape:
if (&term =~ "screen-256color" || &term=~"tmux-256")
    if $ISKONSOLE
        "checking for tmux first because it can run through different terminals
        "let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
        "let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
        let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    else
        "This should work in urxvt and maybe xterm
        "set term=xterm-256color
        let &t_SI = "\ePtmux;\e\e[5 q\e\\"
        let &t_EI = "\ePtmux;\e\e[2 q\e\\"
        let &t_SR = "\ePtmux;\e\e[3 q\e\\"
    endif
elseif &term =~"xterm" && $ISKONSOLE
    "I set up the $ISKONSOLE env var in mykonsole profile
    let &t_SI = "\<Esc>]50;CursorShape=1;BlinkingCursorEnabled=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0;BlinkingCursorEnabled=0\x7"
    let &t_SR = "\<Esc>]50;CursorShape=2;BlinkingCursorEnabled=1\x7"
"""elseif &term == "xterm" || &term == "xterm-256color" || &term=="xterm-256color-italic"
elseif &term =~ "xterm" && !$ISKONSOLE
    "let &t_EI = "\<Esc>]12;red\x7"
    "let &t_SI = "\<Esc>]12;orange\x7"
    "let &t_SI .= "\<Esc>[1 q"
    "let &t_EI .= "\<Esc>[2 q"
    "let &t_SR .= "\<Esc>[3 q"
    " 1 or 0 -> blinking block
    " 2 ->solid block
    " 3 -> blinking underscore
    " 4 ->solid underscore
    " Recent versions of xterm (282 or above) also support
    " 5 -> blinking vertical bar
    " 6 -> solid vertical bar  " solid underscore
    let &t_SI = "\<Esc>[5 q"
    " solid block
    let &t_EI = "\<Esc>[2 q"
    let &t_SR = "\<Esc>[3 q"
    " 1 or 0 -> blinking block
    " 3 -> blinking underscore
elseif &term =~ "rxvt" && !$ISKONSOLE
    let &t_SI = "\<Esc>[5 q"
    let &t_EI = "\<Esc>[2 q"
    let &t_SR = "\<Esc>[3 q"
    " use an orange cursor in insert mode
    "let &t_SI = "\<Esc>]12;orange\x7"
    " use a red cursor otherwise
    "let &t_EI = "\<Esc>]12;red\x7"
    "silent !echo -ne "\033]12;red\007"
    " reset cursor when vim exits
    "autocmd VimLeave * silent !echo -ne "\033]112\007"
    " use \003]12;gray\007 for gnome-terminal
elseif &term =~ "nvim"
    "nothing to do yet

else
"    let &t_SI = "\e[?6;0;0c"
"    let &t_EI = "\e[?16;0;0c"
"    let &t_EI = "\<Esc>[6 q"
"    let &t_SR = "\e[?2;0;0c"
"    let &t_ti.="\e[1 q"
"    let &t_SI.="\e[5 q"
"    let &t_EI.="\e[1 q"
"    let &t_te.="\e[0 q"
"    echo "unknown terminal 1"
endif
"To enable italic fonts on terminal:
set t_ZH=[3m
set t_ZR=[23m
"Or that way seems to work just as above without typing in special esc char:
"if &term =~"xterm" || &term =~ "screen" || &term =~ "tmux"
if &term =~ "xterm" || &term =~ "rxvt"
    let &t_ZH="\e[3m"
    let &t_ZR="\e[23m"
elseif &term =~ "screen" || &term =~ "tmux"
    let &t_ZH="\e[3m"
    let &t_ZR="\e[23m"
    "let &t_ZH="\ePtmux;\e\e[3m\e\\"
    "let &t_ZR="\ePtmux;\e\e[23m\e\\"
elseif &term =~ "nvim"
    "nothing to do yet
else
"    echo "unknown terminal 2"
endif 
