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

fun! MiniM(findstart, base)
    if a:findstart
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && line[start - 1] =~ '\a'
            let start -= 1
        endwhile
        return start
    else
        let res = []
" python code {{{
python <<_EOF_
try:
    import vim
    import json
    from urllib2 import urlopen
    from urllib import urlencode
    py = vim.eval('a:base')
    url = 'http://www.google.com/inputtools/request?' + urlencode({'ime':'pinyin', 'num':'5', 'text':py})
    js = json.load(urlopen(url, timeout=3))
    if 'SUCCESS' in js:
        words = ['"{0}"'.format(i.encode('utf8')) for i in js[1][0][1]]
        vim.command('let res = [%s]' % ','.join(words))
    else:
        raise Exception('not found')
except Exception as e:
    vim.command('echomsg "MiniM: %s"' % e)
_EOF_
" }}}
        return res
    endif
endfun

set completefunc=MiniM

" vim:set et fdm=marker fdc=1:
