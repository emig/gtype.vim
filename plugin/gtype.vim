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

rubyfile %:h/../ruby/gtype.rb

function! Gtype()
ruby << EOF
  current_line_content =  VIM::Buffer.current.line
  if current_line_content.length > 0
    Gtype.new([current_line_content], '/tmp/selectionXXX.typ').write()
    VIM.command(':silent !gtypist /tmp/selectionXXX.typ')
    VIM.command(':redraw!')
  else 
    print "current line is empty"
  end
EOF
endfunction


command Gtype :call Gtype()
