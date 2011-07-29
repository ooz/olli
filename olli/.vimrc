set number                                                    "set line numbering, abbr: nu
colorscheme slate
set guicursor+=a:blinkon0
"set spell

"Backup and swp directories
set backupdir=~/.vim/swp
set directory=~/.vim/swp

set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)] "Informative status line
set autochdir                                                 " Change working directory to the directory containing the current file.
set shortmess+=I " Disable welcome message

set smartindent
set shiftwidth=4                                              "indent width for auto indent
filetype indent on
set tabstop=4                                                 "tabstop, abbr: ts
set expandtab                                                 "turn tabs into spaces

"Modeline support
set modeline
set modelines=5

"Enable indent folding
"set foldenable
"set fdm=indent
"Set space to toggle a fold
"nnoremap <space> za

"Text width
set tw=0 wrap linebreak
"set tw=80 wrap

"set hlsearch "highlight search
"Turn on incremental search with ignore case (except explicit caps)
"set incsearch
"set ignorecase
"set smartcase

"Have 3 lines of offset (or buffer) when scrolling
set scrolloff=3

"Needs Vim 7
"===========
"Set line numbering to take up 5 spaces
"set numberwidth=5
"set cursorline "highlight current line

"Turn on spell checking with English dictionary
"set spell
"set spelllang=en
"set spellsuggest=9 "show only 9 suggestions for misspelled words

" GVim options
"set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
"set guioptions-=r  "remove right-hand scroll bar


