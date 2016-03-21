execute pathogen#infect()
syntax on
filetype plugin indent on
filetype plugin on

set completeopt=longest,menuone,preview
set splitbelow

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
augroup END

set updatetime=500

let g:OmniSharp_server_path = join([expand('<sfile>:p:h'), 'omnisharp-server', 'OmniSharp', 'bin', 'Debug', 'OmniSharp.exe'], '/')
let g:syntastic_javascript_checkers = ['standard']
autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab nocindent smartindent
autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab nocindent smartindent

let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v[\/](\.git|\.hg|\.svn|Temp|Library|obj|bin|AssetBundles)$',
			\ 'file': '\v\.(exe|so|dll|meta|csproj|unityproj|booproj|sln|userprefs|png|psd|mdb|jpg|keystore|wav|mp3|fbx|ttf|otf|tga)$',
			\ }

