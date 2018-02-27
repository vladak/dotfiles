" Open new split panes to right and bottom, which feels more natural
" than Vim default:
set splitbelow
set splitright

" Open file at last edited position.
if version >= 604
  " Some old versions are not supported.
  source ~/.vim/lastpos.vim
endif

source ~/.vim/bad-whitespace.vim
