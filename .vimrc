"Created by zhu on 2009-08-01
"Based from http://amix.dk/vim/vimrc.html

" General
"--------------------------
"Get out of VI's compatibal mode
set nocompatible

"Sets how many lines of history VIM har to remember
set history=400

"Enable filetype plugin
filetype plugin on
filetype indent on

"Set to auto read when a file is changed from the outside
set autoread

"Have the mouse enabled all the time
set mouse=a

"Set mapleader
let mapleader = ","
let g:mapleader = ","

"Fast saving
nmap <leader>w :w<cr>
nmap <leader>f :find<cr>

"Fast reloading of the .vimrc
map <leader>s :source ~/.vimrc<cr>
map <leader>e :e! ~/.vimrc<cr>
autocmd! bufwritepost .vimrc source ~/.vimrc

" Sub Functions
"----------------------------
function! MySys()
	if has("mac")
		return "mac"
	elseif has("win32")
		return "windows"
	else
		return "linux"
	endif
endfunction

" Colors and Fonts
"---------------------------
"Enable syntax highlight
syntax enable

if has("gui_running")
	if MySys() == "windows"
		set lines=70 
		set columns=110
		set guifont=ÇlÇr_ÉSÉVÉbÉN:h9
		colorscheme darkblue
	else "mac or linux
		set lines=50
		set columns=90
		set guioptions-=T
		set guioptions-=m
		colorscheme elflord
	endif
else "console
	if MySys() == "mac"
		set background=dark
		colorscheme darkblue
	else
		colorscheme default
	endif
endif

autocmd BufEnter * :syntax sync fromstart

hi Search term=reverse ctermbg=Yellow ctermfg=Black guibg=Yellow guifg=Black
hi Cursorline term=reverse ctermbg=Blue ctermfg=Black

"Highlight current
set cursorline
"hi cursorline guibg=#333333

" VIM userinterface
"-----------------------------
"Set 7 lines to the cursors - when moving vertical
set so=3

"Turn on wild menu
set wildmenu
set wildmode=list

"Always show current position
set ruler

"The commandbar is 1 high
set cmdheight=1

"show line number
set nu

"Ignore case when searching
set ignorecase
set incsearch

"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=

"Show matching bracets
set showmatch

"Highlight search things
set hlsearch


" Statusline
"-----------------------------
function! GetStatusEx()
    let str = ''
    let str = str . '' . &fileformat . ']'
    if has('multi_byte') && &fileencoding != ''
    let str = '[' . &fileencoding . ':' . str
    endif
    return str
endfunction

"Always hide the statusline
set laststatus=2

"Format the statusline
set statusline=%y%{GetStatusEx()}\ %F%m%r%h\ %w\ \ %h\ %=Line:\ %l/%L\ Col:%c

" Visual
"------------------------------
"Press * or # to search for the current selection
function! VisualSearch(direction) range
	let l:saved_reg = @"
	execute "normal! vgvy"
	let l:pattern = escape(@", '\\/.*$^~[]')
	let l:pattern = substitute(l:pattern, "\n$", "", "")
	if a:direction == 'b'
		execute "normal ?" . l:pattern . "^M"
	else
		execute "normal /" . l:pattern . "^M"
	endif
	let @/ = l:pattern
	let @" = l:saved_reg
endfunction

vnoremap <silent> * :call VisualSearch('f')<cr>
vnoremap <silent> # :call VisualSearch('b')<cr>

" Moving around and tabs
"------------------------------
"Map space to / and c-space to ?
map <space> /
map <c-spase> ?

"Smart way to move between windows.
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"General Abbrevs
"--------------------------------
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
iab xname zhu
iab ins /* INS-S 09S-PR1-00000 zhu */<cr><cr>/* INS-S 09S-PR1-00000 zhu */

" Editing mappings etc.
"--------------------------------
"Move a line of text using control
nmap <C-J> mz:m+<cr>`z
nmap <C-K> mz:m-2<cr>`z
vmap <C-J> :m'>+<cr>`<my`>mzgv`yo`z
vmap <C-K> :m'<-2<cr>`>my`<mzgv`yo`z

" Command-line config
"--------------------------------
"Bash like
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>

" Files and backups
"--------------------------------
set nobackup
set nowb
set noswapfile

" Text options
"--------------------------------
set shiftwidth=4
set tabstop=4
set smarttab

set autoindent
set cindent

set nowrap

" i18n
"------------------------------------
set fileencodings=iso-2022-jp,utf-8,sjis,euc-jp,cp932
