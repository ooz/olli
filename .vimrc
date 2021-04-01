"Excellent reference:
" http://nvie.com/posts/how-i-boosted-my-vim/
"Further inspiration:
" https://vimuser.org/vimrc.txt

"UI
set nu "Line numbers
if &t_Co >= 256 || has('gui_running')
    colorscheme slate
endif
if &t_Co > 2 || has('gui_running')
    syntax on "Only highlight syntax if terminal has colors
endif
set guicursor+=a:blinkon0
set noerrorbells "Don't beep
"set visualbell   "Don't beep, but blink ;)
set shortmess+=I "Disable welcome message
"Informative status line
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]
"Text width
set tw=0 wrap linebreak
set colorcolumn=80
"set tw=80 wrap
set scrolloff=3 "Have 3 lines of offset (or buffer) when scrolling
"GVim options
set guioptions-=T  "remove toolbar
"set guioptions-=m  "remove menu bar
"set guioptions-=r  "remove right-hand scroll bar

"Search
set incsearch "Incremental search showing matches while typing
set hlsearch  "Highlight search terms, hard to read with some themes

"Backup, swap and buffers
set nobackup
set noswapfile
set autowrite
"set backupdir=~/.vim/swp
"set directory=~/.vim/swp
"set undofile "Undo between sessions
"set undodir=~/.vim/undo
set hidden "Keep unsaved buffer even when opening new file

"Plugin management with pathogen
execute pathogen#infect()

filetype indent on
set autoindent
set smartindent
set tabstop=4     "tabstop, abbr: ts
set shiftwidth=4  "indent width for auto indent
set showmatch     " show matching parenthesis
"set shiftround    " use multiple of shiftwidth when indenting with '<' or '>'
"Use tabs only in Makefiles, expand tabs everywhere else
let _curfile = expand("%:t")
if _curfile =~ "Makefile" || _curfile =~ "makefile" || _curfile =~ ".*\.mk"
    set noexpandtab
else
    set expandtab "Turn tabs into spaces
endif
set wildignore=*.swp,*.bak,*.pyc,*.class "Ignore certain files for autocomplete

"Modeline support
set modeline
set modelines=5

"Enable indent folding
"set foldenable
"set fdm=indent
"Set space to toggle a fold
"nnoremap <space> za

"Spell check
set spelllang=en,de
"set spell
"set spellsuggest=9 "show only 9 suggestions for misspelled words

"Custom keybinds
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
"Copy current buffer/file to clipboard
map <F5> :%y+<CR>
noremap <F6> "+d
noremap <F7> "+y
noremap <F8> "+p
set pastetoggle=<F9> "For pasting into vim without autoindent

"Shortcuts for movement ##
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

"Use w!! to sudo write a file that was not opened with su privileges
cmap w!! w !sudo tee % >/dev/null

"AUTOCMDs (checked for older vim versions)
if has('autocmd')
    "Change working directory to the directory containing the current file.
    autocmd BufEnter * silent! lcd %:p:h

    "Remove trailing white space from files
    " http://thanthese.wordpress.com/2010/05/07/automatically-trim-trailing-whitespace-in-vim/
    " http://stackoverflow.com/questions/356126/how-can-you-automatically-remove-trailing-whitespace-in-vim
    autocmd! BufWritePre * mark ' | silent! %s/\s\+$// | norm ''
    "autocmd! BufWritePre *.py mark ' | silent! %s/\s\+$// | norm '' " just for Python files
endif
