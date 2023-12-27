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

call plug#begin('~/.vim/plugged')

" Auto-installs Vim-Plug and all plugins if not installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

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

" Better language support
Plug 'sheerun/vim-polyglot'

" COC-vim language server for auto-complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Code formatting
Plug 'vim-autoformat/vim-autoformat'

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

" Synxtax checker
Plug 'vim-syntastic/syntastic'

" Search and open previous Files
Plug 'https://github.com/yegappan/mru.git'

" Fancy start screen
Plug 'mhinz/vim-startify'

" Floating screen
"Plug 'voldikss/vim-floaterm'

" Shows a line for each indent in a space separated file
Plug 'Yggdroot/indentLine'

" Auto bracket pairs
Plug 'jiangmiao/auto-pairs'

" Autocomplete for tailwindcss
Plug 'rodrigore/coc-tailwind-intellisense', {'do': 'npm install'}

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
Plug 'joshdick/onedark.vim'
Plug 'ghifarit53/daycula-vim' , {'branch' : 'main'}
" Plug 'morhetz/gruvbox.git'
Plug 'crusoexia/vim-monokai'
Plug 'arcticicestudio/nord-vim'
Plug 'mhartington/oceanic-next'
Plug 'wuelnerdotexe/vim-enfocado'

call plug#end()

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

" Auto-installs these extensions on startup if they're missing
let g:coc_global_extensions = [
            \ 'coc-pyright', 'coc-clangd', 'coc-tsserver', 'coc-word',
            \ 'coc-prettier'
            \ ]


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
            \ startify#pad(split(system('figlet -w 100 Vim of Musa'), '\n'))
"Incase you are insane and want to open a new tab with Goyo enabled
autocmd BufEnter *
            \ if !exists('t:startify_new_tab') && empty(expand('%')) && !exists('t:goyo_master') |
            \   let t:startify_new_tab = 1 |
            \   Startify |
            \ endif
"Bookmarks. Syntax is clear.add yours
let g:startify_bookmarks = [ {'I': '~/i3/i3/config'},{'L': '~/.blerc'},{'Z': '~/.zshrc'},{'B': '~/.bashrc'},{'V': '~/.vimrc'}]
let g:startify_lists = [
            \ { 'type': 'bookmarks' , 'header': ['   Bookmarks']      } ,
            \ { 'type': 'files'     , 'header': ['   Recent'   ]      } ,
            \ { 'type': 'sessions'  , 'header': ['   Sessions' ]      } ,
            \ { 'type': 'commands'  , 'header': ['   Commands' ]      } ,
            \ ]
"cant tell wtf it does so its commented
" \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },

hi StartifyBracket ctermfg=240
hi StartifyFile    ctermfg=147
hi StartifyFooter  ctermfg=240
hi StartifyHeader  ctermfg=114
hi StartifyNumber  ctermfg=215
hi StartifyPath    ctermfg=245
hi StartifySlash   ctermfg=240
hi StartifySpecial ctermfg=240

" --------------
" vim-autoformat
" --------------

" Autosaving & Disable autoformat on text files
autocmd FileType vim,text let b:autoformat_autoindent=0
au BufWrite * :Autoformat

" ----------------
" Daycula Settings
" ----------------
let g:daycula_enable_italic = 1

" ----------------
" vim-signify Settings
" ----------------
set updatetime=100

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
set autoindent " Automatically indent the next line
set background=dark " Use dark a the background colour
set expandtab " Use spaces instead of tabs
set smarttab " Not sure DT uses it
set shiftwidth=4 " One tab == 4 spaces
set tabstop=4 " One tab == 4 spaces

filetype plugin on " Enable loading the plugin files for specific file types

" Make comments italic
highlight Comment cterm=italic

" Jump to last position when reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" -----------------------
" --- Custom Mappings ---
" -----------------------
let mapleader =" "
nnoremap <silent> <expr> <leader>n g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
nnoremap <leader>t :tabnew file <CR>
nnoremap <leader>m :MRU <Cr>
nnoremap <leader>i :Startify <Cr>
" <leader>p runs Prettier
" Toggle spelling errors
nnoremap <leader>sp :setlocal spell! spelllang=en_us<Cr>
hi SpellBad ctermfg=red guifg=red
" Fix spelling errors
nnoremap <leader>fs :normal! 1z=<Cr>
" Open fzf file explorer
noremap <leader>f :Files<Cr>
" CRTL+A selects all text
map <C-a> <esc>ggVG
" CTRL+C copy selected text to clipboard (only works with gvim install)<CR>
vnoremap <C-c> "+y
" Home and End keys
" map 1 ^
" map 0 $
" Map 'jk' as escape
imap jk <Esc>
" Using CTRL-e and CTRL-y work to scroll in insert mode
inoremap <C-e> <C-O><C-E>
inoremap <C-y> <C-O><C-Y>
" CTRL-S saves (second one saves in insert mode)
noremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>
" CTRL-Q saves and quits (second one saves in insert mode)
noremap <C-q> :wq<CR>
inoremap <C-q> <c-o>:wq<CR>
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

nnoremap <leader>h :tabprevious<CR>
nnoremap <leader>l :tabnext<CR>
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

" noremap <leader>0 :tablast<cr>
nnoremap <leader>x :tabclose<Cr>
map <leader>tm :tabmove<Cr>


