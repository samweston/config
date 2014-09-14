
" vim-pathogen
call pathogen#infect()

:syntax on
:colorscheme elflord
:set cursorline " show cursor line
:set cursorcolumn " show cursor column
":set spell
":filetype plugin on
":filetype indent on

" Auto write files when you leave the buffer
"set autowrite

:set number

set nocompatible    " vim, not vi.. must be first, because it changes other options as a side effect

"set background=dark
"set modeline

"set statusline=%M%h%y\ %t\ %F\ %p%%\ %l/%L\ %=[%{&ff},%{&ft}]\ [a=\%03.3b]\ [h=\%02.2B]\ [%l,%v]
"set title titlelen=150 titlestring=%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)\ -\ %{v:servername}

"set nowrap

set backspace=indent,eol,start  " backspace over all kinds of things

"set cmdheight=1         " command line two lines high
"set complete=.,w,b,u,U,t,i,d  " do lots of scanning on tab completion

set enc=utf-8 fenc=utf-8   " utf-8 encoding
set ffs=unix,dos,mac       " default fileformats

set history=3000        " keep 3000 lines of command line history
set maxmem=25123  " 24 MB -  max mem in Kbyte to use for one buffer.  Max is 2000000

set noautowrite         " don't automagically write on :next

"set showcmd         " Show us the command we're typing
"set showfulltag       " show full completion tags

set tabstop=4
set shiftwidth=4
set smartindent
set smarttab
set expandtab

" show cool tab and dot thing
set list listchars=tab:»·,trail:·,extends:$,nbsp:=

" Latex specific
au BufEnter *.tex,*.bib set tabstop=2 | set shiftwidth=2 | set spell

" SQL specific
au BufRead,BufNewFile *.prc setfiletype sql
au BufEnter *.sql,*.prc,*.pas set tabstop=2 | set shiftwidth=2

" Makefile specific
au BufEnter Makefile,*.mk set noexpandtab

"Always show tabs
set showtabline=2

" jj = esc in insert mode
:imap jj <Esc>

" Paste toggle
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" F12 toggles NERDTree
map <F12> :NERDTreeToggle<CR>

" Highlight characters past column 80
if version >= 703
    set cc=80
elseif version >= 702
    :au BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
    :au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
else
    :match ErrorMsg '\%>80v.\+'
endif
syntax on

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd BufWinLeave * call clearmatches()

" Some sort of silent thing
command! -nargs=1 Silent
\ | execute ':silent !'.<q-args>
\ | execute ':redraw!'

" VimTip 80: Restore cursor to file position in previous editing session
" for unix/linux/solaris
set viminfo='10,\"100,:20,%,n~/.viminfo

" Return to last edit position when opening files.
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

if version >= 703
    "store undo changes even after you close the file
    set undofile
    set undodir=/tmp
    "Maximum number of changes that can be undone.
    set undolevels=1000
    "Maximum number lines to save for undo on a buffer reload.
    set undoreload=10000
endif

:set ruler
:set nopaste               " don't indent blocks of pasted text
