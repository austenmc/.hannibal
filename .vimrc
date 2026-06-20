" ============================================================
" vim-plug — auto-installs itself on first run
" ============================================================

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Appearance
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'

" File navigation
Plug 'tpope/vim-vinegar'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Editing
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

call plug#end()

" ============================================================
" Core
" ============================================================

set nocompatible
filetype plugin indent on
set modelines=0

" ============================================================
" Performance
" ============================================================

set lazyredraw          " don't redraw during macros
set synmaxcol=200       " stop syntax highlighting past col 200 (long lines are slow)
set ttyfast
set updatetime=300      " faster gitgutter / CursorHold response

" Folds: manual by default to avoid per-keystroke recomputation.
" Use `zf` to create folds manually; `za` to toggle.
set foldmethod=manual
set nofoldenable

" ============================================================
" Appearance
" ============================================================

syntax enable
set background=dark
colorscheme onedark
set laststatus=2
set number
set nowrap
set guifont=BlexMono\ Nerd\ Font:h18
set guioptions=

" lightline replaces airline — noshowmode removes the redundant "-- INSERT --" line
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ 'active': {
  \   'left':  [['mode', 'paste'], ['gitbranch', 'filename', 'modified']],
  \   'right': [['lineinfo'], ['percent'], ['filetype']]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead'
  \ }
  \ }
set noshowmode

" ============================================================
" Tabs / indentation
" ============================================================

set softtabstop=2
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent

" ============================================================
" Searching
" ============================================================

set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

" ============================================================
" Leader
" ============================================================

let mapleader = ","

" ============================================================
" Key mappings — general
" ============================================================

" Quick access to vimrc
nmap <leader>ev :tabedit ~/.vimrc<cr>

" ; as : so you don't have to hit shift
nnoremap ; :

" Clear search highlight
nnoremap <leader><space> :noh<cr>

" Window navigation (Ctrl-hjkl)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Open a vertical split and jump to it
nnoremap <leader>w <C-w>v<C-w>l

" Move lines up/down (Option-j/k on macOS)
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" System clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p

" ============================================================
" File navigation
" ============================================================

" fzf: fuzzy file search
nnoremap <leader>f :Files<cr>
" fzf: open buffers
nnoremap <leader>b :Buffers<cr>
" fzf: ripgrep search across project
nnoremap <leader>/ :Rg<cr>
" fzf: ripgrep word under cursor
nnoremap <leader>* :Rg <c-r>=expand("<cword>")<cr><cr>

" Use ripgrep for fzf file listing when available
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git"'
endif

" fzf layout — full-width panel at the bottom, 40% of screen height
let g:fzf_layout = { 'down': '40%' }

" Preview window on the right when searching file contents
let g:fzf_preview_window = ['right:50%:wrap', 'ctrl-p']

" NERDTree
nnoremap <C-n> :NERDTreeToggle<cr>
nnoremap <leader>n :NERDTreeFind<cr>

let g:NERDTreeShowHidden = 1
let g:NERDTreeIgnore = ['\.git$', 'node_modules', '\.DS_Store']

" Auto-close vim when NERDTree is the last window
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ============================================================
" Git (fugitive + gitgutter)
" ============================================================

nnoremap <leader>gs :Git<cr>
nnoremap <leader>gd :Gdiffsplit<cr>
nnoremap <leader>gb :Git blame<cr>
nnoremap <leader>gl :Git log --oneline -20<cr>
nnoremap <leader>gp :Git push<cr>

" Navigate between git hunks
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
" Stage / undo / preview hunk under cursor
nmap <leader>hs <Plug>(GitGutterStageHunk)
nmap <leader>hu <Plug>(GitGutterUndoHunk)
nmap <leader>hp <Plug>(GitGutterPreviewHunk)

let g:gitgutter_sign_added    = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed  = '-'
