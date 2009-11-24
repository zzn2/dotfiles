"~/.vim/filetype.vim
if exists("did_load_filetypes")
	finish
endif

augroup filetypedetect
	au! BufRead,BufNewFile .vimperatorrc setfiletype vimperator
augroup END
