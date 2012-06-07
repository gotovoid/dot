""""""""""""""""""""""""""""""""""""""""""
" Name:     Toggle bookmark
" File:     bookmark.vim
" Author:   Kev++ <www.hjkl.me@gmail.com>
" Updated:  2012-06-07 13:43:30
" Version:  1.0
" License:  GPL3
""""""""""""""""""""""""""""""""""""""""""
" Shortcuts:
" <F9>:     place
" <S-F9>:   unplace
" <F8>:     next
" <S-F8>:   previous
""""""""""""""""""""""""""""""""""""""""""
" Notes:
" b:bks: (list) bookmark set
" b:bkc: (int) bookmark counter
" b:bki: (int) bookmark index
" b:bkl: (string) bookmark list
""""""""""""""""""""""""""""""""""""""""""

if &cp || exists('g:bookmark_loaded')
    finish
endif

let g:bookmark_loaded = 1

" place/unplace bookmark
fun! ToggleBookmark()
    if empty(expand('%'))
        echohl Error
        echo 'file name is empty'
        echohl NONE
        return
    endif

    if !exists('b:bks')
        let b:bks = []
        let b:bkc = 0
    endif

    let l:n = line('.')

    try
        sign unplace
    catch
        let b:bkc += 1
        call add(b:bks, b:bkc)
        exe printf('sign place %d name=Bookmark line=%d file=%s', b:bkc, line('.'), expand('%:p'))
    endtry
endfun

" move to next/previous bookmark
fun! NextBookmark(rev)
    if empty(expand('%'))
        echohl Error
        echo 'file name is empty'
        echohl NONE
        return
    endif

    redir => b:bkl
    silent exe 'sign place file='.expand('%:p')
    redir END

    if match(b:bkl, 'line') == -1
        echohl Error
        echo 'no bookmarks yet'
        echohl NONE
        return
    endif

    if !exists('b:bki')
        let b:bki = 0
    endif

    for i in a:rev ? reverse(copy(b:bks)) : b:bks
        if a:rev ? i<b:bki : i>b:bki
            let b:bki = i
            try
                exe printf('sign jump %d file=%s', b:bki, expand('%:p'))
                norm 0
                return
            catch
                call remove(b:bks, index(b:bks, b:bki))
            endtry
        endif
    endfor

    let b:bki = a:rev ? b:bks[-1]+1 : 0
    echohl Error
    echo printf('search hit %s, continuing at %s', a:rev ? 'FIRST' : 'LAST', a:rev ? 'LAST' : 'FIRST')
    echohl NONE
    call NextBookmark(a:rev)
endfun

" get color code of LineNr
let s:hl = hlID('LineNr')
let s:bgt = synIDattr(s:hl, 'bg')
let s:bgg = synIDattr(s:hl, 'bg#')

if empty(s:bgt) || s:bgt==-1
    let s:bgt = 'gray'
endif

if empty(s:bgg) || s:bgg==-1
    let s:bgg = 'gray'
endif

exe printf('hi BookmarkSign cterm=bold ctermbg=%s ctermfg=red gui=bold guibg=%s guifg=red', s:bgt, s:bgg)
sign define Bookmark text=● texthl=BookmarkSign linehl=NONE
nnoremap <S-F9> :unlet! b:bks b:bkc b:bki b:bkl \| :sign unplace *<CR>
nnoremap <F9> :call ToggleBookmark()<CR>
nnoremap <F8> :call NextBookmark(0)<CR>
nnoremap <S-F8> :call NextBookmark(1)<CR>

unlet! s:hl s:bgt s:bgg
