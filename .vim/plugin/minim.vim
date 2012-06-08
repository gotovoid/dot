"""""""""""""""""""""""""""""""""""""""""""
" Name:     Minimal Input Method
" File:     minim.vim
" Author:   Kev++ <www.hjkl.me@gmail.com>
" Updated:  2012-06-07 13:43:30
" Version:  1.0
" License:  GPL3
"""""""""""""""""""""""""""""""""""""""""""
" Warning:  Google will get everything!
"""""""""""""""""""""""""""""""""""""""""""

if &cp || exists('g:minim_loaded') || !has('python')
    finish
endif

let g:minim_loaded = 1

fun! MiniM()
python <<_EOF_
try:
    import vim
    import json
    from urllib2 import urlopen
    from urllib import urlencode
    py = vim.eval('@"')
    url = 'http://www.google.com/inputtools/request?' + urlencode({'ime':'pinyin', 'num':'1', 'text':py})
    js = json.load(urlopen(url, timeout=3))
    if 'SUCCESS' in js:
        hz = js[1][0][1][0]
        vim.command('return "%s"' % hz.encode('utf8'))
    else:
        raise Exception('not found')
except Exception as e:
    vim.command('echomsg "MiniM: %s"' % e)
    vim.command('return "%s"' % py)
_EOF_
endfun

" type <C-space> to expand pinyin to hanzi
inoremap <buffer> <C-space> <ESC>ciw<C-r>=MiniM()<CR>
