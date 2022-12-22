set laststatus=2
set showtabline=2

let filetype_m='objc'

call plug#begin()
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'OmniSharp/omnisharp-vim'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'maximbaz/lightline-ale'
Plug 'AndrewRadev/bufferize.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'wsdjeg/vim-fetch'
call plug#end()

if has("syntax")
	syntax on

	if has("autocmd")
		if has("gui_running") && !has("gui_vimr")
			set guioptions-=e
			if has("macunix")
				set guifont=FiraMono-Regular:h16
			elseif has("unix")
				set guifont=FiraMono-Regular \16
			endif
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

	if has('unix')
		let g:coc_node_path = '/usr/local/bin/node'
	endif

	" omnisharp
	let g:OmniSharp_timeout = 5
	let g:OmniSharp_start_server = 1
	let g:OmniSharp_selector_ui = 'fzf'
	let g:OmniSharp_selector_findusages = 'fzf'
	let g:OmniSharp_highlighting = 0
	let g:OmniSharp_server_stdio = 1
	let g:OmniSharp_diagnostic_showid = 1
	"let g:OmniSharp_proc_debug = 1
	"let g:OmniSharp_loglevel = 'debug'
	let g:OmniSharp_diagnostic_exclude_paths = [
		\ 'obj\\',
		\ '[Tt]emp\\',
		\ '\.nuget\\',
		\ '\<AssemblyInfo\.cs\>',
		\ ]

	if has("insert_expand")
		if has("nvim")
			set completeopt=menuone,preview
		else
			set completeopt=menuone,preview,popuphidden
			set completepopup=highlight:Pmenu,border:off
		endif
	endif

	augroup omnisharp_commands
		autocmd!

		"autocmd CursorHold *.cs OmniSharpTypeLookup

		" default
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

		autocmd FileType cs nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
		autocmd FileType cs xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)

		autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)

		autocmd FileType cs nmap <silent> <buffer> <Leader>osnm <Plug>(omnisharp_rename)

		autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
		autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
		autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)

		" custom
		autocmd FileType cs nmap <silent> <buffer> <Leader>gd <Plug>(omnisharp_go_to_definition)
		autocmd FileType cs nmap <silent> <buffer> <Leader>fu <Plug>(omnisharp_find_usages)
		autocmd FileType cs nmap <silent> <buffer> <Leader>fi <Plug>(omnisharp_find_implementations)
		autocmd FileType cs nmap <silent> <buffer> <Leader>fs <Plug>(omnisharp_find_symbol)
		autocmd FileType cs nmap <silent> <buffer> <Leader>pd <Plug>(omnisharp_preview_definition)
		autocmd FileType cs nmap <silent> <buffer> <Leader>dc <Plug>(omnisharp_documentation)

		"autocmd FileType cs :OmniSharpSetCd
	augroup END

	" ale
	let g:ale_linters = {
		\ 'cs': ['OmniSharp'],
		\ 'go': ['golangci-lint'],
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

nnoremap <leader>at :ALEToggle<CR>

nnoremap <silent> <C-n> :NERDTreeToggle<CR>
nnoremap <silent> <C-p> :Files<CR>

