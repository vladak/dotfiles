" indenting and formatting
set autoindent
set wrap
set textwidth=80

" display settings
set ruler
syntax on

" Open new split panes to right and bottom, which feels more natural
" than Vim default:
set splitbelow
set splitright

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" highlight text that goes over 80 columns (do not use with 'set columns')
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
set colorcolumn=80

" Open file at last edited position.
if version >= 604
  " Some old versions are not supported.
  source ~/.vim/lastpos.vim
endif

source ~/.vim/bad-whitespace.vim
