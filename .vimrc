"
" Truly understand ~/.vimrc!
" Owner:    Kev++
" Updated:  2012-06-15 14:24:48
"

" options {{{
" If `$VIM/vimrc` didn't `set cp`, we don't need to `set nocp` here.
" Please read the manual!
set nocompatible
set nolinebreak nowrap nocursorline
set autoindent smartindent
set autoread
set backspace=indent,eol,start
set clipboard=unnamedplus
set colorcolumn=100
set complete+=kspell
set cryptmethod=blowfish
set fencs=utf-8,chinese,latin1 fenc=utf-8 enc=utf-8
set foldnestmax=2
" don't auto wrap long text
"set formatoptions=mnoq
" mbyte support when <gq>
set formatoptions+=m
" gVim will load `$VIM/vimrc` before loading `~/.vimrc`,
" add `finish` at the beginning of `$VIM/vimrc` to hide `Menu`,
" because `$VIM/vimrc` calls `syntax on` which will build menu!
set guioptions+=aM guioptions-=T
set guitablabel=(%N)\ %t\ %M
set hidden
set history=50
set hlsearch incsearch
set ignorecase smartcase
set isfname-==
set laststatus=2
set listchars=precedes:«,extends:»,tab:▸·,trail:∙,eol:¶
set modeline
set mouse=a
set number numberwidth=4 showbreak=\ \ \ ↳ cpo+=n
"set pastetoggle=<F7>
set ruler
set shiftwidth=4 tabstop=4 softtabstop=4 expandtab
set showcmd
set showmatch matchpairs+=<:> matchtime=2
set sidescroll=1 sidescrolloff=1
set spelllang=en
set splitright splitbelow
set tabpagemax=50
set tags=./tags;/,~/.vim/tags path=.,/usr/local/include,/usr/include
set timeoutlen=500
set titlestring=%F\ %M
set virtualedit=block
set wrapscan
set wildignore=*.swp,*.bak,*.pyc,*~
set wildignorecase
set wildmenu
"}}}

" mappings {{{
let mapleader = ','
" normal mode
nnoremap <C-l>           gt
nnoremap <C-h>           gT
nnoremap <C-j>           <C-e>
nnoremap <C-k>           <C-y>
nnoremap <leader>s       : so $MYVIMRC<CR>
nnoremap <leader>v       : tabe $MYVIMRC<CR>
nnoremap <leader>t       : tabe<CR>
nnoremap <leader>q       : q<CR>
nnoremap <leader>f       : !firefox %<CR>
nnoremap <leader>z       : setl fdm=indent fdc=1 fdn=1<CR>
nnoremap <backspace>     : noh<CR>
nnoremap <leader><space> : NERDTreeToggle<CR>
nnoremap <leader><enter> : NERDTreeToggle<CR>
" insert mode
inoremap <leader>dt      <C-r>=strftime('%Y-%m-%d %H:%M:%S')<CR>
inoremap <leader>tm      <C-r>=strftime('%H:%M:%S')<CR>
inoremap <leader>fn      <C-r>=expand('%:p')<CR>
inoremap <C-space>       <C-x><C-u>
inoremap <C-a>           <C-o>^
inoremap <C-e>           <C-o>$
inoremap <C-b>           <left>
inoremap <C-f>           <right>
inoremap <C-d>           <del>
"}}}

" commands {{{
com! HJKL :lcd ~/github/hjkl
com! HT :helptags ~/.vim/doc
com! CD :lcd %:h
com! -nargs=1 -complete=help H :tab help <args>
com! -nargs=* T :VimwikiTable <args>
"}}}

" autocmds {{{
if has('autocmd')
    au FileType text setl spell
    au FileType help setl number nospell
    au FileType html setl equalprg=tidy\ -q\ -i\ --indent-spaces\ 4\ --doctype\ omit\ --tidy-mark\ 0\ --show-errors\ 0\|\|true
    au FileType *    setl textwidth=0
endif
"}}}

" functions {{{

" Top ruler
nnoremap <F6> :call ToggleRuler()<CR>
fun! ToggleRuler()
    if has('gui_running')
        return
    endif

    if !exists('g:ruler')
        let g:ruler = 0
    endif

    let g:ruler = !g:ruler
    if g:ruler
        set showtabline=2 
        let l:padding = &nu*&nuw+&fdc
        let &tabline=printf('%*.*s%s', l:padding, l:padding, '0',
                    \repeat('%#TabLine#123456789%#TabLineFill#0', &columns/10))
    else
        set showtabline&
        set tabline&
    endif
endfun

" Zoom in/out
" nnoremap <C-kPlus>     : call IncFontSize(+1)<CR>
" nnoremap <C-kMinus>    : call IncFontSize(-1)<CR>
" nnoremap <C-k0>        : call IncFontSize(0)<CR>
" fun! IncFontSize(inc)
"     if !exists('+guifont')
"         return
"     endif
"     let s:defaultfont = 'Ubuntu Mono 12'
"     if a:inc==0 || empty(&guifont)
"         let &guifont = s:defaultfont
"         return
"     endif
"     let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)+'.a:inc, '')
" endfun

" Weather report
com! -nargs=1 W echo Weather(<f-args>)
fun! Weather(city)
    if !has('python')
        echoerr 'python is not supported!'
        return
    endif
python <<_EOF_
try:
    import vim
    import xml.etree.ElementTree as ET
    from urllib2 import urlopen
    from urllib import urlencode
    url = 'http://www.google.com/ig/api?' + urlencode({'hl':'zh-cn', 'weather':vim.eval('a:city')})
    xml = ET.XML(unicode(urlopen(url).read() ,'gb2312').encode('utf-8')).find('.//forecast_conditions')
    if xml is None:
        raise Exception('city not found!')
    weather = dict((x.tag, x.get('data').encode('utf-8')) for x in xml.getchildren())
    vim.command('return "%s(%s°C~%s°C)"' % (weather['condition'], weather['low'], weather['high']))
except Exception, e:
    vim.command('return "Error: %s"' % e)
_EOF_
endfun
"}}}

" plugins {{{
call pathogen#infect()
let g:Powerline_symbols = 'fancy'
let g:solarized_menu=0
let g:vimwiki_menu=0
let g:vimwiki_folding=0
let g:vimwiki_html_header_numbering=2
let g:vimwiki_html_header_numbering_sym='.'
let g:vimwiki_list = [{'path': '~/github/hjkl/_posts', 
                   \ 'syntax': 'markdown', 'ext': '.md'}]
"}}}

" syntaxs {{{
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
" type `:help syntax-loading` to read more
syntax on
filetype plugin indent on

" fix colorscheme
hi ColorColumn  ctermbg=yellow
hi IncSearch    cterm=bold ctermbg=red ctermfg=white gui=bold guibg=red guifg=white
hi LineNr       cterm=bold ctermbg=gray ctermfg=black gui=bold guibg=gray guifg=white
hi Search       cterm=bold ctermbg=blue ctermfg=white gui=bold guibg=blue guifg=white
hi Cursor       gui=bold guibg=purple guifg=white
hi Pmenu        ctermfg=white ctermbg=black gui=NONE guifg=white guibg=black
hi PmenuSel     ctermfg=white ctermbg=blue gui=bold guifg=white guibg=purple
"hi! link NonText LineNr

"}}}

" diagnostics {{{
if has('balloon_eval')
    nnoremap <F12>           : setl beval!<CR>
    set bexpr=InspectSynHL()
endif
fun! InspectSynHL()
    let l:synNames = []
    let l:idx = 0
    for id in synstack(v:beval_lnum, v:beval_col)
        call add(l:synNames, printf('%s%s', repeat(' ', idx), synIDattr(id, 'name')))
        let l:idx+=1
    endfor
    return join(l:synNames, "\n")
endfun
"}}}

" vim:set tw=0 et ts=4 sw=4 sts=4 fdm=marker fdc=1 fdn=1:
