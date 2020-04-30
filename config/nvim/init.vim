let g:python_host_prog='/usr/bin/python3'
let g:python3_host_prog='/usr/bin/python3'

set nocompatible
filetype off

call plug#begin("~/.config/nvim/bundle")
" Plugin List
Plug 'bigeagle/molokai'
" 显示(空格)缩进
Plug 'Yggdroot/indentLine'
" 文件列表
Plug 'scrooloose/nerdtree'
" 底部状态栏
Plug 'itchyny/lightline.vim'

" 结构列表
Plug 'majutsushi/tagbar'
" 标签匹配
Plug 'Valloric/MatchTagAlways'
" 多处高亮
Plug 'jrosiek/vim-mark'
" 彩虹括号
Plug 'kien/rainbow_parentheses.vim'

" Python语法高亮
Plug 'hdima/python-syntax'
" Python缩进
Plug 'hynek/vim-python-pep8-indent'
" CXX语法高亮
Plug 'jackguo380/vim-lsp-cxx-highlight'

" 自动补全
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neoclide/coc-json', {'do': 'npm install --frozen-lockfile'}
" Plug 'neoclide/coc-python', {'do': 'npm install --frozen-lockfile'}
" Plug 'neoclide/coc-highlight', {'do': 'npm install --frozen-lockfile'}
" Plug 'neoclide/coc-lists', {'do': 'npm install --frozen-lockfile'}

" 格式化
Plug 'Chiel92/vim-autoformat'

" 注释
Plug 'preservim/nerdcommenter'

call plug#end()



" UI
if !exists("g:vimrc_loaded")
	if has("nvim")
		set termguicolors
	endif
	let g:molokai_original = 1
	colorscheme molokai
endif " exists(...)

set so=10
set number
syntax on
filetype on
filetype plugin on
filetype indent on

set list lcs=tab:\¦\   

if has("autocmd")  " go back to where you exited
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal g'\"" |
        \ endif
endif

set completeopt=longest,menu " preview

if has('mouse')
    set mouse=a
    set selectmode=mouse,key
    set nomousehide
endif

set autoindent
set modeline
set cursorline
"set cursorcolumn

set shiftwidth=4
set tabstop=4
set softtabstop=4

set showmatch
set matchtime=0
set nobackup
set nowritebackup
set directory=/tmp/.swapfiles//

if has('nvim')
   set ttimeout
   set ttimeoutlen=0
endif

"在insert模式下能用删除键进行删除
set backspace=indent,eol,start

set fenc=utf-8
set fencs=utf-8,gbk,gb18030,gb2312,cp936,usc-bom,euc-jp
set enc=utf-8

augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END
set foldcolumn=0 "设置折叠区域的宽度
set foldlevelstart=200
set foldlevel=200  " disable auto folding
" 用空格键来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
vnoremap <Space> zf

set smartcase
set ignorecase
set nohlsearch
set incsearch
set autochdir

vmap j gj
vmap k gk
nmap j gj
nmap k gk

nmap T :tabnew<cr>

au FileType c,cpp,h,java,css,js,nginx,scala,go inoremap  <buffer>  {<CR> {<CR>}<Esc>O

au BufNewFile *.py call ScriptHeader()
au BufNewFile *.sh call ScriptHeader()

function ScriptHeader()
    if &filetype == 'python'
        let header = "#!/usr/bin/env python3"
        let cfg = "# vim: ts=4 sw=4 sts=4 expandtab"
    elseif &filetype == 'sh'
        let header = "#!/bin/bash"
    endif
    let line = getline(1)
    if line == header
        return
    endif
    normal m'
    call append(0,header)
    if &filetype == 'python'
        call append(2, cfg)
    endif
    normal ''
endfunction

" IndentLine Config -------------------
" json下禁用设置
autocmd Filetype json let g:indentLine_enabled = 0
let g:vim_json_syntax_conceal = 0
let g:indentLine_noConcealCursor=""
" -------------------------------------

" NerdTree Config ---------------------
nmap nt :NERDTreeToggle<cr>

" Tells the NERDTree whether to display the
" bookmarks table on startup.
let NERDTreeShowBookmarks=0
" If set to 1 then a double click on a node is required to open it.
" If set to 2 then a single click will open directory nodes, while
" a double click will still be required for file nodes.
" If set to 3 then a single click will open any node.
let NERDTreeMouseMode=2
" Sets the window size when the NERDTree is opened.
let NERDTreeWinSize=25
" Tells the NERDTree which files to ignore.
let NERDTreeIgnore = ['\.pyc$']
" Disables display of the 'Bookmarks' label and 'Press ? for help' text.
let NERDTreeMinimalUI=0
" -------------------------------------

" LightLine Config --------------------
" 不显示输入模式(与状态栏信息冗余)
set noshowmode
" 防止状态栏显示异常
set laststatus=2
" 设置状态栏内容
let g:lightline = {
	\   'active': {
	\     'left':[ [ 'mode', 'paste' ],
	\              [ 'cocstatus', 'readonly', 'filename', 'modified' ]
	\     ]
	\   },
	\   'component': {
	\     'lineinfo': ' %3l:%-2v',
	\   },
	\ 'component_function': {
	\   'cocstatus': 'coc#status',
	\ },
	\ }
let g:lightline.separator = {
	\   'left': '', 'right': ''
	\}
let g:lightline.subseparator = {
	\   'left': '', 'right': '' 
	\}
" -------------------------------------

" Tag Bar Config ----------------------
let g:tagbar_width = 30
nmap tb :TagbarToggle<cr>
" -------------------------------------

" Rainbow Parentheses Config ----------
let g:rbpt_colorpairs = [
	\ [158, '#00ceb3'],
	\ [081, '#00a3ff'],
	\ [214, '#ff8d00'],
	\ [123, '#3fffc9'],
	\ [045, '#29b9ec'],
	\ [190, '#bfec29'],
	\ [208, '#ffad00'],
	\ [117, '#48bde0'],
	\ ]

let g:rbpt_max = 8
let g:rbpt_loadcmd_toggle = 0

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax c,cpp,go,h,java,python,javascript,scala,coffee RainbowParenthesesLoadSquare
au Syntax c,cpp,go,h,java,python,javascript,scala,coffee,scss  RainbowParenthesesLoadBraces
" --------------------------------------

" Python Syntax Config -----------------
let python_highlight_all = 1
" --------------------------------------

" CoC Config ---------------------------
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

set completeopt=noinsert,menuone,noselect

let g:coc_auto_copen=1

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Use <C-j> for both expand and jump (make expand higher priority.)

" Use <cr> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Use <c-space> to trigger completion
inoremap <silent><expr> <leader><space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Update signature help on jump placeholder.
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

highlight CocErrorSign ctermfg=215 guifg=#ffaf5f
highlight default CocHighlightText guibg=#767676 ctermbg=243 cterm=underline
" --------------------------------------

" Auto Format Config -------------------
noremap <silent> <F3> :Autoformat<CR>
" --------------------------------------

" Nerd Commentor Config ----------------
nmap // <leader>c<space>
vmap // <leader>c<space>
" --------------------------------------

" Python Config ------------------------
" 删除行末多余字符
autocmd BufWritePre *.py :%s/\s\+$//e
au FileType python setlocal cc=80
" --------------------------------------
