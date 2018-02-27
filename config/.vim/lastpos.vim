
" record last position
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" some people use:
" au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | 
"		\ exe "normal g'\"" | endif
" but the '\' char causes troubles in certain vim versions

