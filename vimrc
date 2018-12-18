set laststatus=2
set showtabline=2

call plug#begin('~/.vim/plugged')
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'vim-syntastic/syntastic'
Plug 'OmniSharp/omnisharp-vim'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()

if has("syntax")
	syntax on

	if has("autocmd")
		if has("gui_running")
			set guioptions-=e
			set guifont=FiraMono-Regular:h18
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

	if has("python")
		" omnisharp
		let g:OmniSharp_server_path = join([expand('<sfile>:p:h'), 'omnisharp-roslyn', 'run'], '/')
		let g:OmniSharp_timeout = 5
		let g:OmniSharp_start_server = 1
		let g:OmniSharp_selector_ui = 'fzf'
		let g:OmniSharp_highlight_types = 1

		set noshowmatch
		if has("insert_expand")
			set completeopt=menuone
		endif
		set splitbelow
		set updatetime=500

		augroup omnisharp_commands
			autocmd!
			if has("insert_expand")
				autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
			endif

			autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<cr>

			autocmd FileType cs nnoremap <buffer> <leader>fi :OmniSharpFindImplementations<cr>
			autocmd FileType cs nnoremap <buffer> <leader>ft :OmniSharpFindType<cr>
			autocmd FileType cs nnoremap <buffer> <leader>fs :OmniSharpFindSymbol<cr>
			autocmd FileType cs nnoremap <buffer> <leader>fu :OmniSharpFindUsages<cr>
			autocmd FileType cs nnoremap <buffer> <leader>fm :OmniSharpFindMembers<cr>
			autocmd FileType cs nnoremap <buffer> <leader>dc :OmniSharpDocumentation<cr>
			autocmd FileType cs nnoremap <buffer> <leader>th :OmniSharpHighlightTypes<cr>

			autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<cr>
			autocmd FileType cs inoremap <buffer> <C-\> <C-o> :OmniSharpSignatureHelp<cr>

			autocmd FileType cs nnoremap <buffer> <C-K> :OmniSharpNavigateUp<cr>
			autocmd FileType cs nnoremap <buffer> <C-J> :OmniSharpNavigateDown<cr>

			autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

			if v:version >= 704
				autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck
			endif
		augroup END

		nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
		xnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

		nnoremap <leader>rl :OmniSharpReloadSolution<cr>

		nnoremap <leader>ss :OmniSharpStartServer<cr>
		nnoremap <leader>sp :OmniSharpStopServer<cr>

		nnoremap <leader>th :OmniSharpHighlightTypes<cr>

		nnoremap <leader>nm :OmniSharpRename<cr>
		nnoremap <F2> :OmniSharpRename<cr>

		command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")
	endif

	" syntastic
	let g:syntastic_javascript_checkers = ['standard']
	let g:syntastic_cs_checkers = ['syntax']

	" lightline + bufferline
	let g:lightline = { 'colorscheme': 'darcula' }
	let g:lightline.tabline = { 'left': [['buffers']], 'right': [['readonly']] }
	let g:lightline.component_expand = { 'buffers': 'lightline#bufferline#buffers' }
	let g:lightline.component_type = { 'buffers': 'tabsel' }
	let g:lightline#bufferline#show_number = 1
	let g:lightline#bufferline#filename_modifier = ':t'
endif

map <C-n> :NERDTreeToggle<CR>
map <C-p> :Files<CR>

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

nnoremap <leader>ed :P4Edit<cr>
nnoremap <leader>who :P4Annotate<cr>

