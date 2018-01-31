set nocompatible

" Disable modelines just in case I encounter security issues with such files.
set modelines=0

" Remap the leader.
let mapleader = ","

" Tabs
set softtabstop=2
set tabstop=2
set shiftwidth=2
set expandtab
filetype indent plugin on
set autoindent
autocmd BufNewFile,BufRead /Users/austenmc/lotgd/* set tabstop=4 shiftwidth=4 softtabstop=4

" Searching
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>

" For simplicity of accessing :
nnoremap ; :

" Losing focus on the window should save
au FocusLost * :wa

" Windows
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" NERDTree
" Be able to close the window if only NERDTree is open.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>

" Features
set undofile
set wildmenu

" CommandT
let g:CommandTFileScanner='watchman'
let g:CommandTMaxCachedDirectories=10
let g:CommandTMaxFiles=200000

" Clang Complete
" For Objective-C, this needs to be active, otherwise multi-parameter methods won't be completed correctly
let g:clang_snippets = 1

" Appearance and themes.
set laststatus=2
set number
syntax enable
set background=dark
colorscheme onedark
let g:airline_theme = 'onedark'
:set guifont=CamingoCode:h15

" Syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" Folding
set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2

execute pathogen#infect()
