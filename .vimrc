"
" truely understand every line of ~/.vimrc!
" 2012-06-01 13:09:56
"

"{{{ options
set nocompatible
set autoindent
set backspace=indent,eol,start
set clipboard=unnamedplus
set colorcolumn=100
set cryptmethod=blowfish
" I don't want auto wrap long text, and I don't use 坏企鹅!
set formatoptions=noqq
" gVim will load `$VIM/vimrc` before loading `~/.vimrc`,
" add `finish` at the beginning of `$VIM/vimrc` to hide `Menu`,
" because `$VIM/vimrc` calls `syntax on` which will build menu!
set guioptions+=aM guioptions-=T
set hidden
set hlsearch incsearch
set isfname-==
set laststatus=2
set listchars=precedes:«,extends:»,tab:▸·,trail:·,eol:¶
set mouse=a
set nowrap
set number
set pastetoggle=<F12>
set ruler
set shiftwidth=4 tabstop=4 softtabstop=4 expandtab
set showcmd
set sidescroll=1 sidescrolloff=1
set timeoutlen=500
set virtualedit=block
set wildignore=*.swp,*.bak,*.pyc
set wildignorecase
set wildmenu
"}}}

"{{{ shortcuts
let mapleader = ","
nnoremap <C-l>           gt
nnoremap <C-h>           gT
nnoremap <C-j>           <C-e>
nnoremap <C-k>           <C-y>
nnoremap <leader>s     : so $MYVIMRC<CR>
nnoremap <leader>v     : tabe $MYVIMRC<CR>
nnoremap <leader>t     : tabe<CR>
nnoremap <leader>q     : q<CR>
nnoremap <leader>f     : !firefox %<CR>
nnoremap <backspace>   : noh<CR>
nnoremap <S-leftmouse> : echo synIDattr(synstack(line('.'), col('.'))[0], 'name')<CR>
nnoremap <s-leftmouse> : echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>
nnoremap <C-kPlus>     : call IncFontSize(+1)<CR>
nnoremap <C-kMinus>    : call IncFontSize(-1)<CR>
nnoremap <C-k0>        : call IncFontSize(0)<CR>
nnoremap <leader><space> : NERDTreeToggle<CR>
nnoremap <leader><enter> : NERDTreeToggle<CR>
inoremap <C-d>           <C-r>=strftime('%Y-%m-%d %H:%M:%S')<CR>
inoremap <C-t>           <C-r>=strftime('%H:%M:%S')<CR>
"}}}

"{{{ functions
fun! IncFontSize(inc)
    if !exists('+guifont')
        return
    endif
    let s:defaultfont = 'Ubuntu Mono 12'
    if a:inc==0 || empty(&guifont)
        let &guifont = s:defaultfont
        return
    endif
    let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)+'.a:inc, '')
endfun
"}}}

"{{{ custom commands
com! HJKL :lcd ~/github/hjkl
com! HT :helptags ~/.vim/doc
com! CD :lcd %:h
com! -nargs=1 -complete=help H :tab help <args>
com! -nargs=* T :VimwikiTable <args>
"}}}

"{{{ plugin configurations
call pathogen#infect()
let g:Powerline_symbols = 'fancy'
let g:solarized_menu=0
let g:vimwiki_menu=0
let g:vimwiki_folding=0
let g:vimwiki_html_header_numbering=2
let g:vimwiki_html_header_numbering_sym='.'
"let g:vimwiki_list = [{'path': '~/vimwiki/',
"               \ 'path_html': '~/github/hjkl/posts/'}]
"}}}

"{{{ syntax highlighting
if &term =~ "xterm"
    set t_Co=256
    set t_SI=]12;red
    "let &t_SI = "\<Esc>]12;red\x7"
    set t_EI=]12;purple
    "let &t_EI = "\<Esc>]12;purple\x7"
endif

if has('gui_running')
    set background=light
    colorscheme solarized
endif

" `:syntax on` will call `:filetype on`,
" if you don't need plugin/indent, `:filetype on` is not required.
" type `:syntax-loading` to read more
syntax on
filetype plugin indent on

" custom highlight should come after calling `syntax on`, otherwize get overrided.
hi ColorColumn  ctermbg=yellow
hi IncSearch    cterm=reverse,bold ctermfg=red guifg=red
hi LineNr       cterm=reverse,bold ctermfg=gray ctermbg=white gui=reverse,bold guifg=gray guibg=white
hi Search       cterm=reverse,bold ctermfg=blue ctermbg=white gui=reverse,bold guifg=blue guibg=white
hi Cursor       gui=reverse,bold guifg=purple guibg=white

"}}}

