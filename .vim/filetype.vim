"~/.vim/filetype.vim
augroup filetypedetect
	au! BufRead,BufNewFile .vimperatorrc setfiletype vimperator
augroup END
