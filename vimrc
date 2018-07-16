call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-multiple-cursors'
Plug 'Shougo/neocomplete.vim'
" syntax highlighting
Plug 'w0rp/ale'
Plug 'fatih/vim-go'
Plug 'vim-ruby/vim-ruby'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'flowtype/vim-flow'
" removed until it is fixed to not have mem errors
" Plug 'fleischie/vim-styled-components'
" colorscheme
Plug 'mhartington/oceanic-next'
" mark down
Plug 'suan/vim-instant-markdown'
call plug#end()

syntax on
colorscheme OceanicNext

set swapfile
set undofile
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//
set history=1000

set mouse=a
set relativenumber
set number
set nocompatible
set backspace=indent,eol,start
set scrolloff=5
set hlsearch
set incsearch                   " Find as you type search

set list
set listchars=tab:—\—,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

set cursorline

set autoindent                  " Indent at the same level of the previous line
set shiftwidth=2                " Use indents of 2 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=2                   " An indentation every 2 columns
set softtabstop=2               " Let backspace delete indent
set splitright
set splitbelow
set ttyfast

set regexpengine=1 " set to old regexp engine, seems much faster

let g:airline_theme='dark'

" browser
let g:netrw_banner = 0
let g:netrw_liststyle = 3

" fzf
nnoremap <C-p> :FZF<CR>
nnoremap <C-c> :Commits<CR>
nnoremap <C-b> :BCommits<CR>
nnoremap <C-f> :Find<SPACE>

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

" neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" tab instead of ctrl n
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" " better grep
" command -nargs=+ Ggr execute 'silent Ggrep!' <q-args> | cw | redraw!
" vnoremap <leader>g y:Ggr <C-R>0<CR>
" autocmd QuickFixCmdPost *grep* cwindow
" nnoremap <C-f> :Ggr<SPACE>

map <C-j> :cnext<CR>
map <C-k> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" ale
let g:ale_sign_column_always = 1
let g:jsx_ext_required = 0
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'ruby': ['rubocop'],
\ }

" js filetypes
let g:flow#enable = 0
let g:flow#omnifunc = 0
let g:javascript_plugin_flow = 1

au FileType javascript.jsx nmap <Leader>dd :FlowJumpToDef<CR>
au FileType javascript nmap <Leader>dd :FlowJumpToDef<CR>

" Use locally installed flow
let local_flow = finddir('node_modules', '.;') . '/.bin/flow'
if matchstr(local_flow, "^\/\\w") == ''
  let local_flow= getcwd() . "/" . local_flow
endif
if executable(local_flow)
  let g:flow#flowpath = local_flow
endif

" ruby filetypes
au FileType ruby nmap <leader>r "%p

" go filetypes
let g:go_fmt_command = "goimports"

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap <Leader>dd <Plug>(go-def)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

au FileType go nmap <Leader>s <Plug>(go-implements)

" go formatting
au FileType go set noexpandtab

" sql formatting
au FileType sql set expandtab

" strip whitespace
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" multiple cursor fix for neocomplete
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction
