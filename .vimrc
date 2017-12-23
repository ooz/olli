" Excellent reference: http://nvie.com/posts/how-i-boosted-my-vim/

set number " set line numbering, short: set nu

if &t_Co >= 256 || has('gui_running')
    colorscheme slate
endif
set guicursor+=a:blinkon0
set visualbell           " don't beep
set noerrorbells         " don't beep
set shortmess+=I " Disable welcome message

" Backup, swp and Jesus
set nobackup
set noswapfile
set autowrite
"set backupdir=~/.vim/swp
"set directory=~/.vim/swp

set wildignore=*.swp,*.bak,*.pyc,*.class " Ignore certain file types for autocompletion

" Informative status line
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]

" Plugin management with pathogen
execute pathogen#infect()
if &t_Co > 2 || has('gui_running')
    syntax on " only highlight syntax if terminal has colors
endif
filetype indent on

set hidden " Keep unsaved buffer even when opening new file

set smartindent
set showmatch               " show matching parenthesis
set shiftwidth=4                                              "indent width for auto indent
"set shiftround              " use multiple of shiftwidth when indenting with '<' or '>'
set tabstop=4                                                 "tabstop, abbr: ts
"Use tabs only in makefiles, expand tabs everywhere else
let _curfile = expand("%:t")
if _curfile =~ "Makefile" || _curfile =~ "makefile" || _curfile =~ ".*\.mk"
    set noexpandtab
else
    set expandtab                                                 "turn tabs into spaces
endif

"Modeline support
set modeline
set modelines=5

"Enable indent folding
"set foldenable
"set fdm=indent
"Set space to toggle a fold
"nnoremap <space> za

" Text width
set tw=0 wrap linebreak
"set tw=80 wrap

"set hlsearch " highlight search terms, hard to read with some themes, so disabled for now
set incsearch " incremental search showing matches while typing

" search with ignore case (except explicit caps)
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

" # GVim options ############################################################
"set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
"set guioptions-=r  "remove right-hand scroll bar


" # Custom keybinds #########################################################
" use comma instead of shift + . for :
nnoremap , :

" ## Avoiding Esc key ##
inoremap jj <Esc>
inoremap <C-c> <Esc>
nnoremap <C-c> i
nnoremap <Space> i

" ## Tab behaviour ##
nnoremap <Tab> >>
nnoremap <S-Tab> <<
inoremap <S-Tab> <Esc><<i
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

"nnoremap <C-s> :w
noremap <F2> "+d
noremap <F3> "+y
noremap <F4> "+p
set pastetoggle=<F5> " for pasting into vim without autoindent
noremap <F6> "+d
noremap <F7> "+y
noremap <F8> "+p

" ## Shortcuts for movement ##
noremap <C-j> <Down>
noremap <C-k> <Up>
noremap <C-h> <Left>
noremap <C-l> <Right>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
"noremap <C-w> ^
noremap ° ^
noremap <C-e> <End>
noremap <C-d> <Del>
inoremap <C-w> <Esc>^i
inoremap <C-e> <End>
inoremap <C-d> <Del>

" ## Line movement ##
" source: http://vim.wikia.com/wiki/Moving_lines_up_or_down
" just using Shift instead of Alt
nnoremap <S-j> :m+<CR>==
nnoremap <S-k> :m-2<CR>==
"inoremap <S-j> <Esc>:m+<CR>==gi
"inoremap <S-k> <Esc>:m-2<CR>==gi
vnoremap <S-j> :m'>+<CR>gv=gv
vnoremap <S-k> :m-2<CR>gv=gv

" Use w!! to sudo write a file that was not opened with su privileges
cmap w!! w !sudo tee % >/dev/null


" AUTOCMDs (checked for older vim versions)
if has('autocmd')
    " Change working directory to the directory containing the current file.
    autocmd BufEnter * silent! lcd %:p:h

    " Remove trailing white space from files
    " http://thanthese.wordpress.com/2010/05/07/automatically-trim-trailing-whitespace-in-vim/
    " http://stackoverflow.com/questions/356126/how-can-you-automatically-remove-trailing-whitespace-in-vim
    autocmd! BufWritePre * mark ' | silent! %s/\s\+$// | norm ''
    "autocmd! BufWritePre *.py mark ' | silent! %s/\s\+$// | norm '' " just for Python files
endif
