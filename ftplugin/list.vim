set nomodifiable

" Get relevant config variable
let s:completed_character = get(g:, "list#completed_character", "✓")

" Detect if currently selecting title
function! s:OnTitle()
    return line('.') <# 3
endfunction

" Enter closes current list item
inoremap <buffer> <silent> <CR> <esc>:set nomodifiable<CR>

" o opens a new list item
nnoremap <buffer> <silent> o :call <SID>NewItem()<CR>
function! s:NewItem()
    if line('.') ==# 1
        return
    endif
    set modifiable
    execute "normal! o\<cr>[ ]\<space>\<esc>"
    startinsert!
endfunction

" enter toggles completeness
nnoremap <buffer> <silent> <CR> :call <SID>ToggleComplete()<CR>
function! s:ToggleComplete()
    if s:OnTitle()
        return
    endif
    set modifiable
    if getline('.')[0:2] ==# "[ ]"
        call setline('.', "[" . s:completed_character . getline('.')[2:])
    else
        call setline('.', "[ ] " . split(getline('.'), "] ")[1])
    endif
    normal! 0l
    set nomodifiable
endfunction

" d removes item
nnoremap <buffer> <silent> d :call <SID>DeleteItem()<CR>
function! s:DeleteItem()
    if s:OnTitle()
        return
    endif
    set modifiable
    normal! dddd
    set nomodifiable
endfunction

" c edits an item
nnoremap <buffer> <silent> c :call <SID>EditItem()<CR>
function! s:EditItem()
    if s:OnTitle()
        return
    endif
    set modifiable
    normal! $T]c$ 
    startinsert!
endfunction

" up and down move twice
nnoremap <buffer> <silent> j :call <SID>Down()<CR>
nnoremap <buffer> <silent> k :call <SID>Up()<CR>
function! s:Down()
    normal! jj
    if line('.') ==# 3
        normal! j
    endif
endfunction
function!s:Up()
    if line('.') !=# 4
        normal! kk
    endif
endfunction

" q saves and quits
nnoremap <buffer> <silent> q :call <SID>Quit()<CR>
function! s:Quit()
    wq
endfunction

" ban some stuff
nnoremap <buffer> : <nop>
nnoremap <buffer> <esc> <nop>

" Allow undo
nnoremap <buffer> u :call <SID>Undo()<CR>
function! s:Undo()
    set modifiable
    normal! u
    set nomodifiable
endfunction
