set laststatus=2
"set showtabline=2
set showtabline=0
set number
set termguicolors

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'editorconfig/editorconfig-vim'
Plug 'OmniSharp/omnisharp-vim'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'AndrewRadev/bufferize.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'wsdjeg/vim-fetch'
Plug 'wellle/context.vim'
call plug#end()

if has("syntax")
	syntax on

	if has("autocmd")
		if has("gui_running") && !has("gui_vimr")
			set guioptions-=e " no tab pages
			set guioptions-=m " no menu bar
			set guioptions-=T " no toolbar

			" hide scrollbars
			set guioptions-=r
			set guioptions-=l
			set guioptions-=R
			set guioptions-=L

			if has("macunix")
				set guifont=FiraMono-Regular:h16
			elseif has("win32")
				set guifont=Fixedsys
			else
				set guifont=FiraMono-Regular \16
			endif
		endif

		let g:gruvbox_italic=0
		let g:gruvbox_bold=0
		set background=dark
		silent! colorscheme gruvbox
	endif
	set noshowmode
endif

if has("autocmd")
	filetype plugin indent on
	filetype plugin on

	" disable bell
	set noerrorbells visualbell t_vb=
	autocmd GUIEnter * set visualbell t_vb=

	if has('unix')
		let g:coc_node_path = '/usr/local/bin/node'
	endif

	" context.vim
	let g:context_highlight_tag = '<hide>'

	" omnisharp-vim
	let g:OmniSharp_timeout = 5
	let g:OmniSharp_start_server = 1
	let g:OmniSharp_selector_ui = 'fzf'
	let g:OmniSharp_selector_findusages = 'fzf'
	let g:OmniSharp_highlighting = 0
	let g:OmniSharp_server_stdio = 1
	let g:OmniSharp_diagnostic_showid = 1
	"let g:OmniSharp_server_use_net6 = 1
	"let g:OmniSharp_proc_debug = 1
	"let g:OmniSharp_loglevel = 'debug'
	let g:OmniSharp_diagnostic_exclude_paths = [
		\ 'obj\\',
		\ '[Tt]emp\\',
		\ '\.nuget\\',
		\ '\<AssemblyInfo\.cs\>',
		\ ]

	" omnisharp style overrides
	hi! def OmniSharpActiveParameter cterm=underline gui=underline 

	if has("insert_expand")
		if has("nvim")
			set completeopt=menuone,preview
		else
			"set completeopt=menuone,preview,popuphidden
			set completeopt=longest,menuone,popuphidden
			set completepopup=highlight:Pmenu,border:off
		endif
	endif

	set statusline=%<%f\ %h%m%r%=

	function! LinterStatus() abort
			let l:counts = ale#statusline#Count(bufnr(''))

			let l:all_errors = l:counts.error + l:counts.style_error
			let l:all_non_errors = l:counts.total - l:all_errors

			return l:counts.total == 0 ? '' : printf(
			\   '%dW %dE',
			\   all_non_errors,
			\   all_errors
			\)
	endfunction

	set statusline+=%{LinterStatus()}

	" ale
	let g:ale_linters = {
		\ 'cs': ['OmniSharp']
		\ }
	let g:ale_disable_lsp = 1

	" fzf
	let g:fzf_preview_window = []
	let g:fzf_force_termguicolors = 1
	let g:fzf_colors =
		\ { 'fg':      ['fg', 'Normal'],
		\   'bg':      ['bg', 'Normal'],
		\   'hl':      ['fg', 'Comment'],
		\   'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
		\   'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
		\   'hl+':     ['fg', 'Statement'],
		\   'info':    ['fg', 'PreProc'],
		\   'border':  ['fg', 'Ignore'],
		\   'prompt':  ['fg', 'Conditional'],
		\   'pointer': ['fg', 'Exception'],
		\   'marker':  ['fg', 'Keyword'],
		\   'spinner': ['fg', 'Label'],
		\   'header':  ['fg', 'Comment'] } 

	augroup omnisharp_commands
		autocmd!

		" Show type information automatically when the cursor stops moving.
		" Note that the type is echoed to the Vim command line, and will overwrite
		" any other messages in this space including e.g. ALE linting messages.
		"autocmd CursorHold *.cs OmniSharpTypeLookup

		" The following commands are contextual, based on the cursor position.
		autocmd FileType cs nmap <silent> <buffer> <Leader>gd <Plug>(omnisharp_go_to_definition)
		autocmd FileType cs nmap <silent> <buffer> <Leader>fu <Plug>(omnisharp_find_usages)
		autocmd FileType cs nmap <silent> <buffer> <Leader>fi <Plug>(omnisharp_find_implementations)
		autocmd FileType cs nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
		autocmd FileType cs nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
		autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
		autocmd FileType cs nmap <silent> <buffer> <Leader>dc <Plug>(omnisharp_documentation)
		autocmd FileType cs nmap <silent> <buffer> <Leader>fs <Plug>(omnisharp_find_symbol)
		autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
		autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
		autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

		" Navigate up and down by method/property/field
		autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
		autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
		" Find all code errors/warnings for the current solution and populate the quickfix window
		autocmd FileType cs nmap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)
		" Contextual code actions (uses fzf, vim-clap, CtrlP or unite.vim selector when available)
		autocmd FileType cs nmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
		autocmd FileType cs xmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
		" Repeat the last code action performed (does not use a selector)
		autocmd FileType cs nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
		autocmd FileType cs xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)

		autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)

		autocmd FileType cs nmap <silent> <buffer> <Leader>osnm <Plug>(omnisharp_rename)

		autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
		autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
		autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
	augroup END
endif

nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-b> :Buffers<CR>

