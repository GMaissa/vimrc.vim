" vimrc.vim - Extension of vim-sensible plugin with less sensible defaults.
" Maintainer:   Guillaume Maïssa <pro.g@maissa.fr>
" Version:      1.0

if exists('g:loaded_sensible') || &compatible
  finish
else
  let g:loaded_sensible = 1
endif

" Disable strange Vi defaults.
set nocompatible

" Colors {{{
  if has('syntax') && !exists('g:syntax_on')
    syntax enable
  endif
" }}}

" Spaces / Tabs {{{
  set backspace=indent,eol,start

  set autoindent

  if has('autocmd')
    filetype plugin indent on
  endif

  set smarttab
" }}}

" Encoding {{{
  if &encoding ==# 'latin1' && has('gui_running')
    set encoding=utf-8
  endif
" }}}

" Autocomplete {{{
  " Disable include file autocompletion search
  set complete-=i                       

  " enhanced command-line completion
  set wildmenu

  if has('path_extra')
    setglobal tags-=./tags tags-=./tags; tags^=./tags;
  endif
" }}}

" Editing {{{
  " Disable octal increment with C-a / C-x
  set nrformats-=octal

  if v:version > 703 || v:version == 703 && has('patch541')
    set formatoptions+=j                " Delete comment character when joining commented lines
  endif

  " automaticall read file changed outside vim when not changed inside vim
  set autoread

  " Switch between buffers without having to save first.
  set hidden
" }}}

" Map keys {{{
  " Enable wait timeout for key mapping
  set ttimeout

  " Time out on key codes after a tenth of a second
  set ttimeoutlen=100

  inoremap <C-U> <C-G>u<C-U>
" }}}

" Search {{{
  " Highlight search matched string
  set incsearch

  " Use <C-L> to clear the highlighting of :set hlsearch.
  if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
  endif
" }}}

" UI Config {{{
  " Allways display the status line
  set laststatus=2

  " Show the line and column number of the cursor position in status line
  set ruler

  " Show as much as possible of the last line.
  set display+=lastline

  " Minimal number of screen lines to keep above and below cursor
  if !&scrolloff
    set scrolloff=1
  endif

  " Minimal number of screen columns to keep to left and right of cursor
  if !&sidescrolloff
    set sidescrolloff=5
  endif

  " Strings to use in 'list' mode and for the :list command
  if &listchars ==# 'eol:$'
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+ 
  endif

  " Allow color schemes to do bright colors without forcing bold.
  if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
    set t_Co=16
  endif

  " Highlight line under cursor. It helps with navigation.
  set cursorline

  " do not display line numbers
  set nonumber

  " Show mode in statusbar, not separately.
  set noshowmode

  " Only redraw when necessary.
  set lazyredraw
" }}}

if &history < 1000
  set history=1000
endif

if &tabpagemax < 50
  set tabpagemax=50
endif

set sessionoptions-=options

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" vim: ft=vim sw=2 foldenable foldmethod=marker foldlevel=0
