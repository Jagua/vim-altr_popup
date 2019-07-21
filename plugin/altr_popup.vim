if exists('g:loaded_altr_popup')
  finish
endif
let g:loaded_altr_popup = 1


let s:save_cpo = &cpo
set cpo&vim


nnoremap <silent><expr> <Plug>(altr_popup) altr_popup#run()


let &cpo = s:save_cpo
unlet s:save_cpo
