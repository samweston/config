" Neovim config
"
set nocompatible " Don't know if this is necessary

" vim-plug commands (see https://github.com/junegunn/vim-plug):
"   PlugInstall - Install plugins
"   PlugUpdate - Install/update plugins
"   PlugUpgrade - Upgrade vim-plug

" Auto install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Specify the directory for vim-plug
call plug#begin('~/.config/nvim/autoload/plugged')

    " Tokyo night colorscheme - https://github.com/folke/tokyonight.nvim
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
    " Remember last cursor position
    Plug 'farmergreg/vim-lastplace'
    " Show trailing whitespace
    Plug 'ntpeters/vim-better-whitespace'
    " Polyglot thing, includes stuff for lots of langs.
    Plug 'sheerun/vim-polyglot'

call plug#end()

" Install Plugs if this is the first time.
if empty(glob('~/.config/nvim/autoload/plugged'))
    PlugInstall
endif

filetype on
filetype plugin on

" Default colourscheme
colorscheme elflord

" Tokyo night colour scheme
let g:tokyonight_style = "night"
silent! colorscheme tokyonight

" Automatically update the binary spell files .spl
for d in glob('~/.config/nvim/spell/*.add', 1, 1)
    if filereadable(d) && (!filereadable(d . '.spl') || getftime(d) > getftime(d . '.spl'))
        exec 'mkspell! ' . fnameescape(d)
    endif
endfor

" Show row numbers
set number

" Use block cursor on insert mode
set guicursor=i:block

" Remap JJ to ESC
imap jj <Esc>

" Paste toggle
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Clear current search on pressing Esc Esc. (:noh also works)
nnoremap <Esc><Esc> :let @/=""<CR>

" Always show vim tabs (at top)
set showtabline=2

" Show tabs
set list
set listchars=tab:»-

" Backspace over various things
set backspace=indent,eol,start

" Tab size
set tabstop=4
set shiftwidth=4
" Expand tabs (to spaces)
set expandtab
" Auto and smart indent.
set autoindent
set smartindent

" Set tex filetype.
au BufNewFile,BufRead *.tex setf tex

" Prefer latex as default tex file type.
let g:tex_flavor = "latex"

