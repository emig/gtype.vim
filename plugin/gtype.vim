" Exit quickly when already loaded.
if exists("g:loaded_gtype")
  finish
endif

" Exit quicky if running in compatible mode
if &compatible
  echohl ErrorMsg
  echohl none
  finish
endif

" Check for Ruby functionality.
if !has("ruby")
    echohl ErrorMsg
    echon "Sorry, Gtype requires ruby support."
  finish
endif

let g:loaded_gtype = "true"

function! Gtype()
  silent execute '. write !ruby ./gtype.rb' | silent !gtypist /tmp/selectionXXX.typ
  redraw!
endfunction


command Gtype :call Gtype()
