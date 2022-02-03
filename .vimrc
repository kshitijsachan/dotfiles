" General
set number	 "Show line numbers
set linebreak	 "Break lines at word (requires Wrap lines)
set showbreak=+++	 "Wrap-broken line prefix
set textwidth=100	 "Line wrap (number of cols)
set showmatch	 "Highlight matching brace
set visualbell	 "Use visual bell (no beeping)

set hlsearch	 "Highlight all search results
set smartcase	 "Enable smart-case search
set ignorecase	 "Always case-insensitive
set incsearch	 "Searches for strings incrementally

set autoindent	 "Auto-indent new lines
set shiftwidth=4	" Number of auto-indent spaces
set smartindent	 "Enable smart-indent
set smarttab	 "Enable smart-tabs
set softtabstop=4	 "Number of spaces per Tab

" Advanced
set ruler	 "Show row and column ruler information

set undolevels=1000	 "Number of undo levels
set backspace=indent,eol,start	 "Backspace behaviour
syntax on	" syntax highlighting

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Declare the list of plugins
Plug 'https://github.com/kshenoy/vim-signature'

Plug 'lervag/vimtex'
    filetype plugin indent on
    syntax enable
    " Set vimtex default file type to latex
    let g:tex_flavor = 'latex'
    let g:vimtex_view_method ='skim'
    " NOTE: Local leader default is "\"

Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
    set conceallevel=2
    let g:tex_conceal='abdmg'
    " get ready of highlighting around concealed words
    hi Conceal ctermbg=none

Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
    let g:UltiSnipsExpandTrigger="å"
    let g:UltiSnipsJumpForwardTrigger="<tab>"
    let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
    let g:UltiSnipsListSnippets="<C-space>"

Plug 'valloric/youcompleteme'
    " Uncomment the following line to turn off youcompleteme
    " let g:loaded_youcompleteme = 1
    let g:ycm_key_list_select_completion = ['<tab>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<s-tab>', '<Up>']
    let g:ycm_key_list_stop_completion = ['<esc>']

Plug 'dense-analysis/ale'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
