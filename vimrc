set cmdheight=2
set laststatus=2

call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }
Plug 'vim-syntastic/syntastic'
Plug 'OmniSharp/omnisharp-vim'
call plug#end()

if has("syntax")
	syntax on

	if has("autocmd")
		set background=dark
		if has("gui_running")
			if has("gui_gtk2")
				set guifont=SF\ Mono\ Regular\ 11
			else
				set guifont=SF\ Mono\ Regular:h11
			endif
			silent! colorscheme gruvbox
		elseif &t_Co > 8
			let g:gruvbox_termcolors=&t_Co
			silent! colorscheme gruvbox
		endif
	endif
endif

if has("autocmd")
	filetype plugin indent on
	filetype plugin on

	autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab nocindent smartindent
	autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab nocindent smartindent

	if has("python")
		" omnisharp
		let g:OmniSharp_server_path = join([expand('<sfile>:p:h'), 'omnisharp-roslyn', 'run'], '/')
		let g:OmniSharp_timeout = 1
		let g:OmniSharp_start_server = 1
		let g:OmniSharp_selector_ui = 'ctrlp'

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

	" ctrlp
	let g:ctrlp_custom_ignore = {
				\ 'dir':  '\v[\/](\.git|\.hg|\.svn|\.vs|Temp|Library|obj|bin|AssetBundles)$',
				\ 'file': '\v\.(exe|so|dll|meta|csproj|unityproj|booproj|sln|userprefs|png|psd|mdb|jpg|keystore|wav|mp3|fbx|ttf|otf|tga)$',
				\ }

	let g:ctrlp_root_markers = ['.p4config', '.p4ignore', '.vscode', 'ProjectSettings']
	let g:ctrlp_by_filename = 1
	let g:ctrlp_max_files = 0
	let g:ctrlp_max_depth = 40
	let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:64'

	" airline
	let g:airline#extensions#tabline#enabled=1
	let g:airline#extensions#bufferline#enabled=1
	let g:airline#extensions#tabline#buffer_nr_show=1
	let g:airline#extensions#tabline#fnamemod=':t'
	let g:airline_theme='gruvbox'
	if (&guifont =~ 'Powerline')
		let g:airline_powerline_fonts = 1
		if !exists('g:airline_symbols')
			let g:airline_symbols = {}
		endif
		let g:airline_symbols.space="\ua0"
	endif
endif

map <C-n> :NERDTreeToggle<CR>
map <C-p> :CtrlP<CR>

" perforce
function! s:p4edit()
	set autoread
	echom system("p4 edit " . bufname("%"))
	set autoread<
endfunction

command! P4Edit call <SID>p4edit()

nnoremap <leader>ed :P4Edit<cr>

