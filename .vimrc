          "_                    
   "_   __(_)___ ___  __________
  "| | / / / __ `__ \/ ___/ ___/
 "_| |/ / / / / / / / /  / /__  
"(_)___/_/_/ /_/ /_/_/   \___/  
"
" By:            | Musa Ahmed
" Created On:    | August 20, 2021
" Last Modified: | Constantly

" VIM-PLUG
" -----------
call plug#begin('~/.vim/plugged')

" Status line at the bottom
Plug 'itchyny/lightline.vim' 

" Smooth Scrolling
Plug 'psliwka/vim-smoothie'

" Easy commenting and uncommenting
Plug 'preservim/nerdcommenter'

" Distraction-free writing
Plug 'junegunn/goyo.vim'

" Color previews for CSS
Plug 'ap/vim-css-color'                            

" Brackets, Quotations, and anything surrounding a string manager
Plug 'tpope/vim-surround'

" One Dark Theme
Plug 'https://github.com/joshdick/onedark.vim'

" JS and JSX Syntax
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

" Fish Syntax
Plug 'dag/vim-fish'

" Markdown Preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

call plug#end()

" PLUGIN SETTINGS ------------

" --- Lightline status line config ---
" Needed to work, second one hides double 'insert'
set laststatus=2
set noshowmode

let g:lightline = {}
let g:lightline.colorscheme = 'molokai'


" GENERAL SETTINGS ------------

" THEMING
"packadd! dracula
"syntax enable
"colorscheme dracula

syntax on
colorscheme onedark

" Setting leader key
let mapleader = ","

" Enable mouse
set mouse=a 

" Line numbers
set nu

" Indentation
set smartindent

" CTRL+A selects all text
map <C-a> <esc>ggVG<CR> 

" CTRL+C copy selected text to clipboard (only works with gvim install)
vnoremap <C-c> "+y

" idk bro
filetype plugin on

" Highlight the line on which the cursor lives.
set nocursorline

" Remove timeout for partially typed commands
set notimeout

" Home and End keys
map 1 <home>
map 0 <end>

"Case insensitive searching 
set ignorecase

"Will automatically switch to case sensitive if you use any capitals
set smartcase

" WHERE TF IS MY CURSOR??
set cursorline
