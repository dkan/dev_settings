call plug#begin('~/.vim/plugged')
" editor ui
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
" file find and search
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" functionality
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-multiple-cursors'
" auto complete
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" linting/fixing
Plug 'dense-analysis/ale'
" syntax highlighting
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
" Plug 'ap/vim-css-color'
" colorscheme
Plug 'mhartington/oceanic-next'
call plug#end()

syntax on

set termguicolors
colorscheme OceanicNext

set swapfile
set undofile
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//
set history=1000

" styled-components syntax highlighting from start
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

let mapleader = "\\"

set nocompatible

set mouse=a
set number
set backspace=indent,eol,start
set scrolloff=3

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

" ale
let g:ale_sign_column_always = 1
let g:jsx_ext_required = 0
let g:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\   'ruby': ['rubocop'],
\   'typescript': ['prettier', 'tslint', 'eslint'],
\   'typescript.tsx': ['prettier', 'tslint', 'eslint'],
\ }
let g:ale_fix_on_save = 1
nnoremap <leader>w :ALEFix<CR>
highlight ALEWarning ctermbg=none cterm=undercurl
highlight ALEError ctermbg=none cterm=undercurl

let g:ale_completion_enabled = 1
set completeopt=noselect,noinsert
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" Use deoplete.
let g:deoplete#enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" javascript
au FileType javascript nmap <leader>dd :ALEGoToDefinition<CR>
au FileType javascript.jsx nmap <leader>dd :ALEGoToDefinition<CR>

" typescript
au FileType typescript nmap <leader>dd :ALEGoToDefinition<CR>
au FileType typescript.tsx nmap <leader>dd :ALEGoToDefinition<CR>

" ruby filetypes
au FileType ruby nmap <leader>dd gf

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

" fzf
nnoremap <C-p> :Files<CR>
command! -bang -nargs=* Files call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

nnoremap <C-c>c :Commits<CR>
nnoremap <C-c>b :BCommits<CR>

nnoremap <C-b> :Buffers<CR>
command! -bang -nargs=* Buffers call fzf#vim#buffers(<q-args>, fzf#vim#with_preview(), <bang>0)
nnoremap <C-h> :History<CR>
nnoremap <leader>/ :History/<CR>

nnoremap <C-f> :Find<SPACE>
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" color fzf buffer to color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
let g:fzf_preview_window = 'down:40%'

map <C-j> :cnext<CR>
map <C-k> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
nnoremap <leader>f :Find <C-R><C-W><CR>

" nerdtree
map <leader>n :NERDTreeToggle<CR>
map <leader>m :NERDTreeFind<CR>
let g:NERDTreeWinSize=50
let NERDTreeShowHidden=1
let NERDTreeMapOpenSplit='s'
let NERDTreeMapOpenVSplit='v'
