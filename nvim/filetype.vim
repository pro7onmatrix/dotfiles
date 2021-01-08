if exists("did_load_filetypes")
    finish
endif
augroup filetypedetect
    au! BufRead,BufNewFile *.gp,*.gnuplot   set filetype=gnuplot commentstring=#\ %s
    au! BufRead,BufNewFile *.bib,*.bibtex   set commentstring=%\ %s
augroup END

autocmd FileType cpp,c setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
