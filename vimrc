set nocompatible              " be iMproved, required
filetype off                  " required

set encoding=utf-8
let mapleader=","

set number
set relativenumber
set ruler
syntax on

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
noremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Invisible characters
" autocmd BufEnter * set listchars=tab:▸\ ,eol:¬

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc

" Status bar
set laststatus=2

" NERDTree configuration
let NERDTreeIgnore=['\.rbc$', '\~$']
" Nerd Tree (toggle)
map <Leader>n :NERDTreeToggle<CR>
" Nerd Tree (reveal current file)
map <Leader>f :NERDTreeFind<CR>
" Close Nerdtree when selecting a file
let NERDTreeQuitOnOpen=1


" ZoomWin configuration
map <Leader>z :ZoomWin<CR>

" Edit user .vimrc
map <Leader>r :e ~/.vimrc<CR>

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function s:setupWrapping()
  set wrap
  set wm=2
  set textwidth=72
endfunction

function s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Mm <CR>
endfunction

" make and python use real tabs
au FileType make                                     set noexpandtab
au FileType python                                   set noexpandtab

" Thorfile, Rakefile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

au BufRead,BufNewFile *.txt call s:setupWrapping()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'briancollins/vim-jst.git'
Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'
Plugin 'bling/vim-airline'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'fatih/vim-go'
Plugin 'tpope/vim-haml'
Plugin 'pangloss/vim-javascript'
Plugin 'groenewege/vim-less'
Plugin 'tpope/vim-markdown'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'moll/vim-node'
Plugin 'mmalecki/vim-node.js'
Plugin 'altercation/vim-colors-solarized'
Plugin 'wavded/vim-stylus'
Plugin 'ervandew/supertab.git'
Plugin 'tpope/vim-surround'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-unimpaired'
Plugin 'ap/vim-css-color'
Plugin 'tpope/vim-endwise'
Plugin 'elzr/vim-json'
Plugin 'honza/vim-snippets.git'
Plugin 'SirVer/ultisnips.git'
Plugin 'Valloric/YouCompleteMe.git'
Plugin 'mattn/gist-vim.git'
Plugin 'tpope/vim-commentary.git'
Plugin 'airblade/vim-gitgutter.git'
Plugin 'tpope/vim-repeat.git'
Plugin 'justinmk/vim-sneak.git'
Plugin 'jiangmiao/auto-pairs.git'
Plugin 'vim-scripts/ZoomWin.git'
Plugin 'Blackrush/vim-gocode.git'
Plugin 'mbbill/undotree'

" load the plugin and indent settings for the detected filetype
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Use modeline overrides
set modeline
set modelines=10

" Default color scheme
color default

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
cmap w!! w !sudo tee > /dev/null %
" Fast saving
nmap <Leader>w :w!<cr>
nmap .<Leader> :wq!<cr>

" ------------------------------------------------------------------------------
" snipmate
" ------------------------------------------------------------------------------
" Configure snipmate dir
let g:snippets_dir="~/.vim/snippets"

" ------------------------------------------------------------------------------
" File type specifics *
" ------------------------------------------------------------------------------
" Go
au FileType go nmap gd <Plug>(go-def)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

" Do not create swap files, we're using git after all
set nobackup
set nowritebackup
set noswapfile

" CtrlP
let g:ctrlp_dont_split = 'NERD_tree_2'
let g:ctrlp_working_path_mode = ''
let g:ctrlp_mruf_relative = 1
nmap <Leader>p :CtrlPMRU<CR>

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

nnoremap <leader>h :split<enter>
nnoremap <leader>v :vsplit<enter>
let g:AutoPairsMultilineClose=0
