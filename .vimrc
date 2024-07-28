"_
"_   __(_)___ ___  __________
"| | / / / __ `__ \/ ___/ ___/
"_| |/ / / / / / / / /  / /__
"____/_/_/ /_/ /_/_/   \___/
"
" By:            | Musa Ahmed
" Created On:    | August 20, 2021
" Last Modified: | Constantly

" ----------------
" --- Encoding ---
" ----------------

set encoding=utf-8

" --------------------------------
" --- Plugins - Using Vim-Plug ---
" --------------------------------

" Auto-installs Vim-Plug and all plugins if not installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \| PlugInstall --sync | source $MYVIMRC
            \| endif

call plug#begin('~/.vim/plugged')

" -------------------
" -- Functionality --
" -------------------

" Smooth Scrolling
Plug 'psliwka/vim-smoothie'

" Distraction-free writing
Plug 'junegunn/goyo.vim'

" JS and JSX Syntax
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

" C / C++ Extended Highlighting
Plug 'bfrg/vim-cpp-modern'

" Razor page highlighting
Plug 'jlcrochet/vim-razor'

" Latex support
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" Better language support
Plug 'sheerun/vim-polyglot'

" COC-vim language server for auto-complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fix copy & past problem
Plug 'christoomey/vim-system-copy'

" Easy commenting and uncommenting
Plug 'preservim/nerdcommenter'

" Visual system file explorer
Plug 'preservim/nerdtree'

" Synxtax highlighting and icons for nerdtree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'

" Fuzzy search
Plug 'junegunn/fzf.vim'

" Show registers/macros when using them
Plug 'junegunn/vim-peekaboo'

" Synxtax checker
Plug 'vim-syntastic/syntastic'

" Search and open previous Files
Plug 'https://github.com/yegappan/mru.git'

" Highlighting when using f,t,F,T motions
Plug 'girishji/fFtT.vim'

" Fancy start screen
Plug 'mhinz/vim-startify'

" Auto code formatting
Plug 'vim-autoformat/vim-autoformat'

" Floating screen
"Plug 'voldikss/vim-floaterm'

" Shows a line for each indent in a space separated file
Plug 'Yggdroot/indentLine'

" Auto bracket pairs
Plug 'jiangmiao/auto-pairs'

" Git Changes Displayer (requires vim 8.0.902+)
Plug 'mhinz/vim-signify'

" ---------------
" -- Aesthetic --
" ---------------

" Status line at the bottom
Plug 'itchyny/lightline.vim'

" Color previews for CSS
Plug 'ap/vim-css-color'


" ------------
" -- Themes --
" ------------
Plug 'ghifarit53/daycula-vim' , {'branch' : 'main'}
" Plug 'joshdick/onedark.vim'
" Plug 'morhetz/gruvbox.git'
" Plug 'crusoexia/vim-monokai'
" Plug 'arcticicestudio/nord-vim'
" Plug 'mhartington/oceanic-next'
" Plug 'wuelnerdotexe/vim-enfocado'

call plug#end()

filetype indent plugin on

" -----------------------
" --- Plugin Settings ---
" -----------------------

" ----------------------------------
" -- Lightline status line config --
" ----------------------------------
let g:lightline = {
            \ 'colorscheme': 'daycula',
            \ 'separator': { 'left': '', 'right': '' },
            \ 'subseparator': { 'left': '', 'right': '' },
            \ }
set laststatus=2
set noshowmode


" No statusline in nerdtree window
augroup filetype_nerdtree
    au!
    au FileType nerdtree call s:disable_lightline_on_nerdtree()
    au WinEnter,BufWinEnter,TabEnter * call s:disable_lightline_on_nerdtree()
augroup END

fu s:disable_lightline_on_nerdtree() abort
    let nerdtree_winnr = index(map(range(1, winnr('$')), {_,v -> getbufvar(winbufnr(v), '&ft')}), 'nerdtree') + 1
    call timer_start(0, {-> nerdtree_winnr && setwinvar(nerdtree_winnr, '&stl', '%#Normal#')})
endfu

" --------------------
" -- Coc-vim config --
" --------------------

" Allows tab completion by pressing tab to select items
inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1):
            \ CheckBackspace() ? "\<Tab>" :
            \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> M :call ShowDocumentation()<CR>

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('M', 'in')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')


" Auto-installs these extensions on startup if they're missin" g
let g:coc_global_extensions = [
            \ 'coc-pyright', 'coc-clangd', 'coc-tsserver',
            \ 'coc-prettier', 'coc-emoji', 'coc-rust-analyzer',
            \ ]
" \ 'coc-vimtex'


" " ----------------------
" -- Syntastic config --
" ----------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Error highlighting for error and line
hi SyntasticErrorSign ctermfg=red ctermbg=yellow
hi SyntasticErrorLine ctermbg=black

" ---------------------
" -- NERDTree config --
" ---------------------

" Auto start NERDTree and put cursor in empty buffer
" autocmd VimEnter * NERDTree | wincmd p

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
            \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

let g:NERDTreeWinSize=20 " Nerdtree width
let NERDTreeMinimalUI=1 "remove press ? for help on top of nerdtreedisable 80 extentions of nerdtree for less lag
let g:NERDTreeLimitedSyntax = 1
let g:NERDCreateDefaultMappings = 1 " Create default mappings
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs = 1 " Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign = 'left' " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDAltDelims_java = 1 " Set a language to use its alternate delimiters by default
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } } " Add your own custom formats or override the defaults
let g:NERDCommentEmptyLines = 1 " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting
let g:NERDToggleCheckAllLines = 1 " Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

" --------------
" -- Startify --
" --------------
let g:startify_custom_header =
            \ startify#pad(split(system('figlet -f ANSI welcome musa'), '\n'))
"Incase you are insane and want to open a new tab with Goyo enabled
autocmd BufEnter *
            \ if !exists('t:startify_new_tab') && empty(expand('%')) && !exists('t:goyo_master') |
            \   let t:startify_new_tab = 1 |
            \   Startify |
            \ endif
"Bookmarks. Syntax is clear.add yours
let g:startify_bookmarks = [ {'I': '~/.config/i3/config'},{'B': '~/.bashrc'},{'V': '~/.vimrc'}]
let g:startify_lists = [
            \ { 'type': 'bookmarks' , 'header': ['   Bookmarks']      } ,
            \ { 'type': 'files'     , 'header': ['   Recent'   ]      } ,
            \ { 'type': 'sessions'  , 'header': ['   Sessions' ]      } ,
            \ { 'type': 'commands'  , 'header': ['   Commands' ]      } ,
            \ ]
"cant tell wtf it does so its commented
" \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },

" This allows a custom header color but daycula overrides it and i can't
" figure it out
"hi StartifyHeader  guifg=#1f24de guibg=NONE

" ----------------
" Daycula Settings
" ----------------
let g:daycula_enable_italic = 1

" ----------------
" vim-signify Settings
" ----------------
set updatetime=5000

" ----------------
" vim-autoformat Settings
" ----------------
au BufWrite * :Autoformat " BufWritePost allows format to be run on auto-saved files
au FileType groovy,text,conf,python,dockerfile let b:autoformat_autoindent=0
" To make python not take 3 seconds to save, idk if its a good idea though
au FileType python let b:autoformat_retab=0
au FileType python let b:autoformat_remove_trailing_spaces=0

" Custom formatters for specific file types
let g:formatdef_custom_java = '"astyle --style=google --indent=spaces=4 --indent-switches --pad-oper --pad-header --unpad-paren --add-braces --convert-tabs"'
let g:formatters_java = ['custom_java']

let g:formatdef_custom_python = '"black"'
let g:formatters_python = ['custom_python']

let g:formatdef_custom_javascript = '"prettier --parser javascript"'
let g:formatters_javascript = [ 'custom_javascript' ]

let g:formatdef_custom_typescript = '"prettier --parser typescript"'
let g:formatters_typescript = [ 'custom_typescript' ]
" typescript jsx
let g:formatters_typescriptreact = [ 'custom_typescript' ]

let g:formatdef_custom_html = '"prettier --parser html"'
let g:formatters_html = [ 'custom_html' ]

" ----------------
" vim-latex-live-preview Settings / General latex settings
" ----------------
let g:tex_flavor = "latex"
let g:livepreview_previewer = 'zathura'
autocmd FileType tex,markdown :IndentLinesDisable

" ---------------------------------
" --- Colour and theme settings ---
" ---------------------------------
if &term =~ '256color'
    if has('termguicolors') " Enable true (24-bit) colors instead of (8-bit) 256 colors.
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        set termguicolors
    endif

    colorscheme daycula " Change colorscheme here
endif

" --------------------
" --- Vim Settings ---
" --------------------

syntax on
set modifiable " Sets files to be modifiable by deafault
set autoread " Re-reads a file when edits in another editor are detected
set cmdheight=1 " Sets max height of commands when run
set foldenable " Allows folding
set incsearch " When searching, shows strings that match as you are typing
set mouse=a " Enable mouse
set rnu " Relative Line numbers
set smartindent " Indentation
set ignorecase " Case insensitive searching
set smartcase " Will automatically switch to case sensitive if you use any capitals
set cursorline " Highlights line cursor is on
set notimeout " Remove timeout for partially typed commands
set timeoutlen=100
set autoindent " Automatically indent the next line
set background=dark " Use dark a the background colour
set expandtab " Use spaces instead of tabs
set smarttab " Not sure DT uses it
set shiftwidth=4 " One tab == 4 spaces
set tabstop=4 " One tab == 4 spaces
set hlsearch " Show all matching when searching
set undofile " Creates undo files for all files
set undodir=~/.vim/undodir " Persistent undo files for all files edited in one location

filetype plugin on " Enable loading the plugin files for specific file types

" Make comments italic
highlight Comment cterm=italic

function! FormatOnUpdate()
    exe 'Autoformat'
    silent update
endfunction

if has("autocmd")
    " Jump to last position when reopening a file
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    " Save writeable files automatically 'updatetime' ms later after the cursor stops moving
    au CursorHold,CursorHoldI <buffer> if &readonly == 0 && filereadable(bufname('%')) | call FormatOnUpdate() | endif
endif

" -----------------------
" --- Custom Mappings ---
" -----------------------
nnoremap <SPACE> <Nop>
let mapleader = " "

" Open Nerdtree
nnoremap <silent> <expr> <leader>n g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

nnoremap <leader>m :MRU <Cr>
nnoremap <leader>i :Startify <Cr>
nnoremap <leader>p :LLPStartPreview<CR>
nnoremap <leader>u :IndentLinesToggle<CR>

" <leader>p runs Prettier
" Toggle spelling errors
nnoremap <leader>sp :setlocal spell! spelllang=en_us<Cr>
hi SpellBad ctermfg=red guifg=red
" Fix spelling errors (if this is active :Files requires a second input char
" to activate )
" nnoremap <leader>fs :normal! 1z=<Cr>
" Open fzf file explorer
noremap <Space>f :Files<Cr>
" Open fzf window explorer and switch to window on enter
noremap <Space>w :Windows<Cr>
" Open fzf window explorer and switch to window on enter
noremap <Space>b :Buffers<Cr>
" CRTL+A selects all text
map <C-a> <esc>ggVG
" CTRL+C copy selected text to clipboard (only works with gvim install)<CR>
vnoremap <C-c> "+y
" Home and End keys
" map 1 ^
" map 0 $
" Map 'jk' as escape
imap jk <Esc>
imap JK  <Esc> :echo "Turn off caps lock!"<CR>
" Using CTRL-e and CTRL-y work to scroll in insert mode
inoremap <C-e> <C-O><C-E>
inoremap <C-y> <C-O><C-Y>
" CTRL-S saves (second one saves in insert mode)
noremap <C-s> :update<CR>
inoremap <C-s> <ESC>:update<CR>
" CTRL-Q saves and quits (second one saves in insert mode)
noremap <C-q> :update<Bar>quit<CR>
inoremap <C-q> <c-o>:update<Bar>quit<CR>
" CTRL-X quits without saving
noremap <C-x> :q!<CR>
inoremap <C-x> <ESC>:q!<CR>
" Moving around in insert mode
" imap pp <right>
" imap qq <left>
" CTRL + L or H jumps one word
imap <C-l> <C-Right>
imap <C-h> <C-left>

" -----------------------
" -- Buffer navigation --
" -----------------------
set splitbelow splitright
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

map <C-LEFT> <C-w>h
map <C-DOWN> <C-w>j
map <C-UP> <C-w>k
map <C-RIGHT> <C-w>l

map <s-l> :vertical resize +5 <Cr>
map <s-h> :vertical resize -5 <Cr>
map <s-j> :resize +5 <Cr>
map <s-k> :resize -5 <Cr>

" Tabs (space is needed as using space as leader doesnt raelly work)
nnoremap <Space>t :tabnew<Cr>
nnoremap <Space>l :tabnext<CR>
nnoremap <Space>h :tabprevious<CR>

" Moving tabs around
nnoremap <Space>L :tabm +1<CR>
nnoremap <Space>H :tabm -1<CR>

"Keybindings for tab navigation with leader and number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt


