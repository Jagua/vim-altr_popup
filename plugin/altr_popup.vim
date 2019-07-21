if exists('g:loaded_altr_popup')
  finish
endif
let g:loaded_altr_popup = 1


let s:save_cpo = &cpo
set cpo&vim


nnoremap <silent> <Plug>(altr_popup) :<C-u>call altr_popup#run()<CR>


let &cpo = s:save_cpo
unlet s:save_cpo
