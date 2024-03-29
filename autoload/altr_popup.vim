let s:save_cpo = &cpo
set cpo&vim


function! altr_popup#run(...) abort
  if !exists('*popup_menu')
    throw 'altr_popup: require popup_menu()'
  endif
  let items = s:gather_items()
  if empty(items)
    call popup_notification('altr_popup: No files.', {'pos' : 'center'})
    return
  endif
  let ctx = extend({'opener' : {file -> execute('edit `=file`')}}, get(a:, '1', {}))
  call popup_menu(items, {
        \ 'title' : 'altr',
        \ 'callback' : function('s:callback', [ctx, items]),
        \})
endfunction


function! s:callback(ctx, items, winid, idx) abort
  if a:idx == -1
    return
  endif
  call a:ctx.opener(a:items[a:idx - 1])
endfunction


function! s:gather_items() abort
  let current_bufname = bufname('%')
  if empty(current_bufname)
    return []
  endif
  let bufname_list = []
  let direction = 'back'
  let bufname = current_bufname
  while !0
    let bufname = altr#_infer_the_missing_path(bufname, direction, altr#_rule_table())
    if type(bufname) != v:t_string
      if direction ==# 'back'
        let direction = 'forward'
        let bufname = current_bufname
        continue
      elseif direction ==# 'forward'
        break
      endif
    elseif bufname ==# current_bufname
      break
    endif
    call add(bufname_list, bufname)
  endwhile
  return bufname_list
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
