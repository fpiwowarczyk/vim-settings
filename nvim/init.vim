
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
set signcolumn=yes

" Some servers have issues with backup files
set nobackup 
set nowritebackup

" Having longer update time leads to noticable delays and poor user experience
set updatetime=300


call plug#begin()
"Autocomplete: 
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
"Color:
Plug 'morhetz/gruvbox'
"File Browser:
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'mkitt/tabline.vim'
Plug 'ryanoasis/vim-devicons'
"File Search:
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Git:
Plug 'tpope/vim-fugitive'
"GO:
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Autoclose Brackets: 
Plug 'townk/vim-autoclose'
call plug#end()

"COPY/PASTE:
"-----------
"Increases the memory limit form 50 lines to 1000 lines 
:set viminfo='100,<1000,s10,h

"Color:
"------
colorscheme gruvbox

"AUTO IMPORT:
"------------
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1

"Go Syntax Highlight:
let g:go_highlight_fields=1
let g:go_highlight_functions=1
let g:go_highlight_function_calls=1
let g:go_highlight_extra_types=1
let g:go_highlight_operators = 1


" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

"File Browser
" Shortcut to ctrl-n 
nnoremap <C-n> :NERDTreeToggle<CR>
" Open NERDTree when dir is selected "vim m"
let g:nerdtree_tabs_open_on_console_startup=2
" Add a close button in the upper right for tabs 
let g:tablineclosebutton=1
" Show hidden files 
let NERDTreeShowHidden=1
"Automatically find and select currently opened file in NERDTree
let g:nerdtree_tabs_autofind=1
" Add folder icon to directories 
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
"Hide expand/collapse arrows
let g:NERDTreeDirArrowExpandable = "\u00a0"
let g:NERDTreeDirArrowCollapsible = "\u00a0"
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
nnoremap <silent> <C-f> :Files<CR>
highlight! link NERDTreeFlags NERDTreeDir


"MOUSE:
"------
"Allow using mouse helpful for switching/resizing windows
set mouse+=a
if &term =~ '^screen'
  " tmux knows the extended mouse mode
  set ttymouse=xte)m2
endif


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"


inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


function! CheckBackspace() abort 
  let col = col('.') - 1 
  return !col || getline('.')[col -1] =~# '\s'
endfunction

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else 
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Common Go commands 
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>e :<C-u>call <SID>RunGoProgram()<CR>



"
function! s:RunGoProgram()
  source .env
  call go#cmd#Run(0)
endfunction
