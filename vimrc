execute pathogen#infect()
syntax on
filetype plugin indent on
filetype plugin on

" omnisharp
let g:OmniSharp_server_path = join([expand('<sfile>:p:h'), 'omnisharp-server', 'OmniSharp', 'bin', 'Debug', 'OmniSharp.exe'], '/')
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
	autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck
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

" syntastic
let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_cs_checkers = ['semantic', 'syntax']

" ctrlp
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v[\/](\.git|\.hg|\.svn|Temp|Library|obj|bin|AssetBundles)$',
			\ 'file': '\v\.(exe|so|dll|meta|csproj|unityproj|booproj|sln|userprefs|png|psd|mdb|jpg|keystore|wav|mp3|fbx|ttf|otf|tga)$',
			\ }

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" nerdtree
map <C-n> :NERDTreeToggle<CR>

autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab nocindent smartindent
autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab nocindent smartindent

set updatetime=500
set completeopt=longest,menuone,preview
set splitbelow
set cmdheight=2
