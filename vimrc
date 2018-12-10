"set cmdheight=2
set laststatus=2

call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
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
		let g:OmniSharp_timeout = 3
		let g:OmniSharp_start_server = 1
		let g:OmniSharp_selector_ui = 'fzf'

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
			autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
			autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
			autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
			autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
			autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
			autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
			autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
			autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
			autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>

			autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

			if v:version >= 704
				autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck
			endif
		augroup END

		nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
		vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

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

	" lightline
	let g:lightline = { 'colorscheme': 'darcula' }
endif

map <C-n> :NERDTreeToggle<CR>
map <C-p> :Files<CR>

" perforce
function! s:p4edit()
	set autoread
	echom system("p4 edit " . bufname("%"))
	set autoread<
endfunction

command! P4Edit call <SID>p4edit()

nnoremap <leader>ed :P4Edit<cr>

