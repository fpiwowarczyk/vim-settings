if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd!
  autocmd VimEnter * PlugInstall
endif

syntax on
" Shows cursorline 
set cursorline
set et ts=2 sts=2 sw=2
set showmatch
set ignorecase
set mouse=v
set hlsearch
set autoindent
" Show line numbers
set number 
set wildmode=longest,list
" Encoding
set encoding=UTF-8
"When changing currently opened file it will be hidden not closed 
set hidden




call plug#begin()
"Autocomplete: 
Plug 'neoclide/coc.nvim', {'branch':'release'}
"Color:
Plug 'morhetz/gruvbox'
"File Browser:
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'mkitt/tabline.vim'
Plug 'ryanoasis/vim-devicons'
"Snippets:
Plug 'ncm2/ncm2-ultisnips'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' 
"Go:  
Plug 'fatih/vim-go', { 'do': 'GoUpdateBinaries' }
"File Search:
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Git:
Plug 'tpope/vim-fugitive'
call plug#end()

"COPY/PASTE:
"-----------
"Increases the memory limit form 50 lines to 1000 lines 
:set viminfo='100,<1000,s10,h

"Color:
"------
colorscheme gruvbox

autocmd CursorHold * silent call CocActionAsync('highlight')

"AUTO IMPORT:
"------------
let g:go_fmt_command = "goimports"

"SNIPPETS:
"---------
"Change default expand since TAB is used to cycle options
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"File Browser
" Shortcut to ctrl-n 
nnoremap <C-n> :NERDTree<CR>
" Open NERDTree when dir is selected "vim m"
let g:nerdtree_tabs_open_on_console_startup=2
" Add a close button in the upper right for tabs 
let g:tablineclosebutton=1
"Automatically find and select currently opened file in NERDTree
let g:nerdtree_tabs_autofind=1
" Add folder icon to directories 
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
"Hide expand/collapse arrows
let g:NERDTreeDirArrowExpandable = "\u00a0"
let g:NERDTreeDirArrowCollapsible = "\u00a0"
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
highlight! link NERDTreeFlags NERDTreeDir


"SHORTCUTS:
"----------
"Open file at same line last closed 
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g'\"" | endif
endif

"MOUSE:
"------
"Allow using mouse helpful for switching/resizing windows
set mouse+=a
if &term =~ '^screen'
  " tmux knows the extended mouse mode
  set ttymouse=xterm2
endif
