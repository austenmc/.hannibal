set softtabstop=2
set tabstop=2
set shiftwidth=2
set expandtab
set smartcase
set ic
set number

autocmd BufNewFile,BufRead /Users/austenmc/lotgd/* set tabstop=4 shiftwidth=4 softtabstop=4

filetype indent plugin on
set autoindent

set ruler

syntax enable
set background=dark
if has('gui_running')
  colorscheme solarized
endif
:set guifont=CamingoCode:h15

execute pathogen#infect()
filetype plugin indent on

:so ~/.vim/a.vim

" Load ctrlp
set runtimepath^=~/.vim/bundle/ctrlp.vim
" Enable a cache (duh)
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
" Set no max file limit
let g:ctrlp_max_files = 0
" Search from current directory instead of project root
let g:ctrlp_working_path_mode = 0
" Configure to use the_silver_searcher
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
" Ignore certain files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.png,*.jpg,*.jpeg,*.gif
