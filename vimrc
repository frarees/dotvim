set laststatus=2
set showtabline=2

let filetype_m='objc'

call plug#begin('~/.vim/plugged')
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'OmniSharp/omnisharp-vim'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'maximbaz/lightline-ale'
Plug 'leafgarland/typescript-vim'
Plug 'lluchs/vim-wren'
Plug 'ziglang/zig.vim'
Plug 'tpope/vim-fugitive'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
call plug#end()

if has("syntax")
	syntax on

	if has("autocmd")
		if has("gui_running")
			set guioptions-=e
			set guifont=FiraMono-Regular:h16
		endif
		set background=dark
		silent! colorscheme gruvbox
	endif
	set noshowmode
endif

if has("autocmd")
	filetype plugin indent on
	filetype plugin on

	autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab nocindent smartindent
	autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab nocindent smartindent

	" fzf toggle
	autocmd! FileType fzf tnoremap <buffer> <C-p> <c-c>

	" disable bell
	set noerrorbells visualbell t_vb=
	autocmd GUIEnter * set visualbell t_vb=

	let g:tagbar_autofocus = 1

	" omnisharp
	let g:OmniSharp_timeout = 5
	let g:OmniSharp_start_server = 1
	let g:OmniSharp_selector_ui = 'fzf'
	let g:OmniSharp_highlighting = 0
	let g:OmniSharp_server_stdio = 1

	if has("insert_expand")
		set completeopt=longest,menuone,preview,popuphidden
		set completepopup=highlight:Pmenu,border:off
	endif

	augroup omnisharp_commands
		autocmd!

		autocmd CursorHold *.cs OmniSharpTypeLookup

		autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
		autocmd FileType cs nmap <silent> <buffer> <Leader>osfu <Plug>(omnisharp_find_usages)
		autocmd FileType cs nmap <silent> <buffer> <Leader>osfi <Plug>(omnisharp_find_implementations)
		autocmd FileType cs nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
		autocmd FileType cs nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
		autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
		autocmd FileType cs nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)
		autocmd FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
		autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
		autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
		autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

		autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
		autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)

		autocmd FileType cs nmap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)

		autocmd FileType cs nmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
		autocmd FileType cs xmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)

		autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)

		autocmd FileType cs nmap <silent> <buffer> <Leader>osnm <Plug>(omnisharp_rename)

		autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
		autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
		autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)

		autocmd FileType cs :OmniSharpSetCd
	augroup END

	" ale
	let g:ale_linters = {
		\ 'cs': ['OmniSharp'],
		\ 'javascript': ['standard'],
		\ }
	let g:ale_fixers = {
		\ 'javascript': ['standard'],
		\ }
	let g:ale_c_parse_makefile = 1

	" lightline + bufferline
	let g:lightline = {
		\ 'colorscheme': 'darcula'
		\ }
	let g:lightline.tabline = {
		\ 'left': [
		\	['buffers'],
		\ ],
		\ 'right': [
		\	['readonly']
		\ ] }
	let g:lightline.active = {
		\ 'left': [
		\	['mode', 'paste'],
		\	['readonly', 'filename', 'modified']
		\ ],
		\ 'right': [
		\	['linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok'],
		\	['lineinfo'],
		\	['percent'],
		\	['fileformat', 'fileencoding', 'filetype'],
		\ ] }
	let g:lightline.component_expand = {
		\ 'buffers': 'lightline#bufferline#buffers',
		\ 'linter_checking': 'lightline#ale#checking',
		\ 'linter_warnings': 'lightline#ale#warnings',
		\ 'linter_errors': 'lightline#ale#errors',
		\ 'linter_ok': 'lightline#ale#ok',
		\ }
	let g:lightline.component_type = {
		\ 'buffers': 'tabsel',
		\ 'linter_checking': 'left',
		\ 'linter_warnings': 'warning',
		\ 'linter_errors': 'error',
		\ 'linter_ok': 'left',
		\ }
	let g:lightline#bufferline#show_number = 1
	let g:lightline#bufferline#filename_modifier = ':t'
endif

" set cd to sln path, if possible
command! OmniSharpSetCd call <SID>setcd()
function! s:setcd()
	if exists('b:OmniSharp_buf_server')
		exe 'cd ' . fnamemodify(b:OmniSharp_buf_server, ':p:h')
	endif
endfunction

" perforce
function! s:p4edit()
	set autoread
	echom system("p4 edit " . bufname("%"))
	set autoread<
endfunction

function! s:p4annotate()
	echom system("p4 annotate -u " . bufname("%") . " | sed '" . (line(".") + 1) . "!d'")
endfunction

command! P4Edit call <SID>p4edit()
command! P4Annotate call <SID>p4annotate()

nnoremap <leader>ed :P4Edit<CR>
nnoremap <leader>who :P4Annotate<CR>

nnoremap <leader>at :ALEToggle<CR>

nnoremap <silent> <C-n> :NERDTreeToggle<CR>
nnoremap <silent> <C-K> :TagbarToggle<CR>
nnoremap <silent> <C-p> :Files<CR>

