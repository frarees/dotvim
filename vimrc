set cmdheight=2
set laststatus=2

if has("autocmd")
	execute pathogen#infect()
endif

if has("syntax")
	syntax on

	if has("autocmd")
		if has("gui_running")
			set background=light
			if has("gui_gtk2")
				set guifont=Roboto\ Mono\ Light\ for\ Powerline\ 24
			else
				set guifont=Roboto\ Mono\ Light\ for\ Powerline:h24
			endif
			colorscheme solarized
		elseif &t_Co > 8
			let g:solarized_termcolors=&t_Co
			colorscheme solarized
		endif
	endif
endif

if has("autocmd")
	filetype plugin indent on
	filetype plugin on

	autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab nocindent smartindent
	autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab nocindent smartindent

	" pico8
	com PicoTreeToggle NERDTreeToggle $HOME/Library/Application\ Support/pico-8/carts
	com PicoOpen exec "!".$PICO_PATH
	com -nargs=1 PicoBuild exec "!".$PICO_PATH." -run \"".<args>."\""
	autocmd FileType pico8 nnoremap <C-b> :PicoBuild fnamemodify(bufname(1), ':p')<CR>

	if has("python")
		" omnisharp
		let g:OmniSharp_server_path = join([expand('<sfile>:p:h'), 'omnisharp-server', 'OmniSharp', 'bin', 'Debug', 'OmniSharp.exe'], '/')
		let g:OmniSharp_timeout = 1
		let g:OmniSharp_start_server = 1

		set noshowmatch
		set completeopt=menuone,noinsert,noselect
		set splitbelow
		set updatetime=500

		augroup omnisharp_commands
			autocmd!
			autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
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

	" ctrlp
	let g:ctrlp_custom_ignore = {
				\ 'dir':  '\v[\/](\.git|\.hg|\.svn|Temp|Library|obj|bin|AssetBundles)$',
				\ 'file': '\v\.(exe|so|dll|meta|csproj|unityproj|booproj|sln|userprefs|png|psd|mdb|jpg|keystore|wav|mp3|fbx|ttf|otf|tga)$',
				\ }

	" airline
	let g:airline#extensions#tabline#enabled=1
	let g:airline#extensions#bufferline#enabled=1
	let g:airline#extensions#tabline#buffer_nr_show=1
	let g:airline#extensions#tabline#fnamemod=':t'
	let g:airline_theme='solarized'
	if (&guifont =~ 'Powerline')
		let g:airline_powerline_fonts = 1
		if !exists('g:airline_symbols')
			let g:airline_symbols = {}
		endif
		let g:airline_symbols.space="\ua0"
	endif
endif

map <C-n> :NERDTreeToggle<CR>

