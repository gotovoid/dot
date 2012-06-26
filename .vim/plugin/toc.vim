" Toggle Markdown TOC quickfix
" Modified by Kev++ @2012-06-25
" Created by Donald Ephraim Curtis (2011)
"

if exists("g:loaded_toggle_list")
  finish
endif

function! s:GetBufferList() 
  redir =>buflist 
  silent! ls 
  redir END 
  return buflist 
endfunction

function! ToggleLocationList()
  let curbufnr = winbufnr(0)
  for bufnum in map(filter(split(s:GetBufferList(), '\n'), 'v:val =~ "Location List"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if curbufnr == bufnum
      lclose
      return
    endif
  endfor

  let winnr = winnr()
  let prevwinnr = winnr("#")

  let nextbufnr = winbufnr(winnr + 1)
  try
    lopen
  catch /E776/
      echohl ErrorMsg 
      echo "Location List is Empty."
      echohl None
      return
  endtry
  if winbufnr(0) == nextbufnr
    lclose
    if prevwinnr > winnr
      let prevwinnr-=1
    endif
  else
    if prevwinnr > winnr
      let prevwinnr+=1
    endif
  endif
  " restore previous window
  exec prevwinnr."wincmd w"
  exec winnr."wincmd w"
endfunction

function! ToggleQuickfixList()
  for bufnum in map(filter(split(s:GetBufferList(), '\n'), 'v:val =~ "Quickfix List"'), 'str2nr(matchstr(v:val, "\\d\\+"))') 
    if bufwinnr(bufnum) != -1
      cclose
      return
    endif
  endfor
  let winnr = winnr()
  copen
  if winnr() != winnr
    wincmd p
  endif
endfunction

fun! TOC()
    call setloclist(0, [])
    let save_cursor = getpos(".")
    call cursor(1, 1)
    while search("^#", 'W') > 0
       let msg = printf('%s:%d:%s', expand('%'), line('.'), substitute(getline('.'), '#', '»', 'g'))
       laddexpr msg
    endwhile
    call setpos('.', save_cursor)
    silent! call ToggleLocationList()
endfun

" nmap <script> <silent> <leader>l :call ToggleLocationList()<CR>
" nmap <script> <silent> <leader>q :call ToggleQuickfixList()<CR>
com! -bar TOC call TOC()

