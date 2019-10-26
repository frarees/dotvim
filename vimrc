set laststatus=2
set showtabline=2

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

	" fzf toggle
	autocmd! FileType fzf tnoremap <buffer> <C-p> <c-c>

	if has("python")
		" omnisharp
		let g:OmniSharp_timeout = 5
		let g:OmniSharp_start_server = 1
		let g:OmniSharp_selector_ui = 'fzf'
		let g:OmniSharp_highlight_types = 1
		let g:OmniSharp_server_stdio = 1

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

			" autocmd FileType cs nnoremap <buffer> <C-p> :OmniSharpFiles<cr>

			autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
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

" custom files
function! s:files()
	if exists('b:OmniSharp_buf_server')
		call fzf#vim#files(fnamemodify(b:OmniSharp_buf_server, ':p:h')) 
	else
		call fzf#vim#files('')
	endif
endfunction

command! CustomFiles call <SID>files()
nnoremap <C-p> :CustomFiles<CR>

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

nnoremap <leader>at :ALEToggle<CR>

nnoremap <C-n> :NERDTreeToggle<CR>
