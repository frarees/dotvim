execute pathogen#infect()
syntax on
filetype plugin indent on

let g:syntastic_javascript_checkers = ['standard']
autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab nocindent smartindent
autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab nocindent smartindent

