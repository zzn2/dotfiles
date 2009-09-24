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
autocmd! BufWritePost .vimrc source ~/.vimrc

"Run local sources
"Write some local account here
"such as twitter account that shouldn't to be open
"and something set local to specific machine.
source $HOME/vimrc.local

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
	set guioptions-=T "hide toolbar
	set guioptions-=m "hide menubar
	set guioptions-=L "hide left menubar
	set guioptions-=r "hide right menubar
	if has("gui_win32")
		"adjust window size on first load
		if exists("s:vimrc_loaddone") == 0
			set lines=70 
			set columns=110
		endif
		let s:vimrc_loaddone = 1

		if ( &encoding == 'cp936' )
			"chinese windows
			set guifont=MS\ Gothic:h9
		else
			"japanese windows
			set guifont=ÇlÇr\ ÉSÉVÉbÉN:h9
		endif

		colorscheme darkblue
	else "mac or linux
		"adjust window size on first load
		if exists("s:vimrc_loaddone") == 0
			set lines=80
			set columns=110
		endif
		let s:vimrc_loaddone = 1

		set guifont=Monaco:h9
		colorscheme torte
	endif
else "console
	set background=dark
	colorscheme darkblue
	hi Comment ctermfg=DarkBlue 
endif

autocmd BufEnter * :syntax sync fromstart

hi Search term=reverse ctermbg=Yellow ctermfg=Black guibg=Yellow guifg=Black
hi Cursorline term=reverse ctermfg=Black ctermbg=Yellow guibg=DarkBlue

"Show Cursorline only in current buffer
"autocmd WinLeave * set nocursorline
"autocmd WinEnter * set nocursorline
autocmd BufLeave * set nocursorline
autocmd BufEnter * set cursorline
autocmd BufCreate * set cursorline

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

"search
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
"nmap <C-J> mz:m+<cr>`z
"nmap <C-K> mz:m-2<cr>`z
"vmap <C-J> :m'>+<cr>`<my`>mzgv`yo`z
"vmap <C-K> :m'<-2<cr>`>my`<mzgv`yo`z

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

"Do not open IME by default
set iminsert=0
set imsearch=-1

" i18n
"------------------------------------
set fileencodings=iso-2022-jp,utf-8,sjis,euc-jp,cp932
" to support euc-jp in windows
if has("gui_win32")
	map <Leader>a :e++enc=euc-jp<CR>
endif

" Plugin Settings
"-----------------------------------

"Lookupfile setting
let g:LookupFile_MinPatLength=2                 "start search after 2 types
let g:LookupFile_PreserveLastPattern=0          "do not save last search
let g:LookupFile_PreservePatternHistory=1       "save search history
let g:LookupFile_AlwaysAcceptFirst=1            "select the 1st item on return
let g:LookupFile_AllowNewFiles=0                "new file creation now allowed
if filereadable("./filenametags")
	let g:LookupFile_TagExpr='"./filenametags"' "set the tag file name
endif
nmap <silent> <space> :LUBufs<cr>
nmap <silent> <space><space> :LUWalk<cr>

"NERDTree setting
" <enter> to toggle NERDTree
nmap <silent> <C-m> :NERDTreeToggle<cr>
