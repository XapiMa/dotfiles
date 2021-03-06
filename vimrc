call plug#begin()
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'flazz/vim-colorschemes'
Plug 'Shougo/neocomplete.vim'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'mattn/emmet-vim', {'for': ['htmldjango', 'html', 'css']}
Plug 'thinca/vim-quickrun'
Plug 'tpope/vim-surround'
Plug 'othree/html5.vim', {'for': 'html'}
Plug 'hail2u/vim-css3-syntax', {'for': 'css'}
Plug 'pangloss/vim-javascript', {'for': 'js'}
Plug 'jiangmiao/auto-pairs'
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'scrooloose/syntastic'
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'Shougo/unite.vim'
Plug 'osyo-manga/unite-quickfix'
Plug 'osyo-manga/shabadou.vim'
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'Konfekt/FastFold'
Plug 'Shougo/vimshell'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'kannokanno/previm', {'for': 'markdown'}
Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}
Plug 'itchyny/lightline.vim'
Plug 'tomtom/tcomment_vim'
Plug 'szw/vim-tags'
Plug 'vim-jp/vim-cpp', {'for': ['c', 'cpp']}
Plug 'osyo-manga/vim-marching', {'for': ['c', 'cpp']}
call plug#end()


filetype off

augroup vimrc
    autocmd!
augroup END

" iTerm settings
let g:hybrid_use_iTerm_colors = 1
set background=dark
colorscheme hybrid

set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis

set backupdir=$HOME/.vimbackup
set directory=$HOME/.vimbackup
set hidden

set smartcase
set incsearch
set hlsearch

set tabstop=4
set shiftwidth=4
set cindent
set smarttab
set expandtab
set ambiwidth=double
set backspace=indent,eol,start

set list
set number
set showmatch
set matchpairs& matchpairs+=<:>
set grepformat=%f:%l:%m,%f,%l%m,%f\ \ %l%m
set grepprg=grep\ -nh
set clipboard=unnamed,autoselect
set ruler
set cursorline
set laststatus=2    " show bottom status line always
set wildmenu wildmode=list:full

set visualbell t_vb=
set noerrorbells

set tags=./tags;

nnoremap j gj
nnoremap k gk
nnoremap <silent><ESC><ESC> :nohlsearch<CR>
" for ctags
nnoremap <C-]> g<C-]>

" disable expandtab in Makefile
autocmd vimrc FileType make setlocal noexpandtab

" remove trailing space
function! s:remove_space()
    let cursor = getpos(".")
    %s/\s\+$//ge
    call setpos(".", cursor)
    unlet cursor
endfunction
autocmd vimrc BufWritePre * call <SID>remove_space()


" Filetype settings
autocmd vimrc BufNewFile,BufRead *.html set filetype=htmldjango


" Template File setting
autocmd vimrc BufNewFile *.ly 0r $HOME/.vim/template/lilypond.txt
autocmd vimrc BufNewFile *.py 0r $HOME/.vim/template/python.txt


" lilypond settings
set runtimepath+=/usr/local/share/lilypond/2.18.2/vim/


" vim-marching settings
let g:marching_clang_command = "/usr/bin/clang"
let g:marching#clang_command#options = {
\   "cpp" : " -std=c++11 -stdlib=libc++"
\}
let g:marching_include_paths = [
\   "/usr/include",
\   "/usr/local/include",
\   "/usr/local/Cellar/boost/1.62.0/include"
\]
let g:marching_enable_neocomplete = 1


" NeoComplete Settings ===============================
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
augroup neocomplete
    autocmd!
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.cpp =
        \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'


" jedi-vim
augroup jedi
    autocmd!
    autocmd FileType python setlocal completeopt-=preview
    autocmd FileType python setlocal omnifunc=jedi#completions
augroup END


" integrate jedi-vim and neocomplete
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'


" NERDTree Settings =========================
nnoremap <silent><C-e> :NERDTreeToggle<CR>
autocmd vimrc bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" emmet-vim Settings ========================
let g:user_emmet_settings = {
			\ 'variables': {
			\ 'lang' : 'ja'
			\ }
			\}


" syntastic Settings =========================
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" syntastic checkers
" let g:syntastic_<filetype>_checkers = ['<checker-name>']
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_python_checkers = ['pyflakes', 'pep8']


" Tex settings ================================
" disable the conceal function
let g:tex_conceal=''


" vim-quickrun settings ========================
let g:quickrun_config = {
\   "_" : {
\       "runner": "vimproc",
\       "runner/vimproc/updatetime": 40,
\       "outputter" : "error",
\       "outputter/error/success" : "buffer",
\       'outputter/error/error' : 'quickfix',
\       "outputter/buffer/split" : ":botright 10sp",
\       "outputter/buffer/close_on_empty" : 1,
\   },
\   "cpp" : {
\       "command": "c++",
\       "cmdopt": "--std=c++11 -stdlib=libc++",
\   }
\}

" Press <C-c> to stop QuickRun
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"


" PreVim Settings ===========================
let g:previm_open_cmd = 'open -a "Google Chrome"'


" lightline settings ========================
set noshowmode
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive', 'filename' ] ]
    \ },
    \ 'component_function': {
    \   'fugitive': 'LightLineFugitive',
    \   'readonly': 'LightLineReadonly',
    \   'modified': 'LightLineModified',
    \   'filename': 'LightLineFilename'
    \ },
    \ 'separator': { 'left': "\u2b80", 'right': "\u2b82" },
    \ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" }
    \ }

function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "\u2b64"
  else
    return ""
  endif
endfunction

function! LightLineFugitive()
  if exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? "\u2b60 ".branch : ''
  endif
  return ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction


" vim-tags settings =========================
let g:vim_tags_auto_generate = 1
let g:vim_tags_ctags_binary = "/usr/local/bin/ctags"


" vim-markdown settings =====================
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1


filetype indent on
syntax on
