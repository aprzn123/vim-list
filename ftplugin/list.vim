set nomodifiable

" Get relevant config variable
let s:completed_character = get(g:, "list#completed_character", "✓")

" Enter closes current list item
inoremap <buffer> <CR> <esc>:set nomodifiable<CR>

" o opens a new list item
nnoremap <buffer> o :call <SID>NewItem()<CR>
function! s:NewItem()
    set modifiable
    execute "normal! o\<cr>[ ]\<space>\<esc>"
    startinsert!
endfunction

" enter toggles completeness
nnoremap <buffer> <CR> :call <SID>ToggleComplete()<CR>
function! s:ToggleComplete()
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
nnoremap <buffer> d :call <SID>DeleteItem()<CR>
function! s:DeleteItem()
    set modifiable
    normal! dddd
    set nomodifiable
endfunction

" c edits an item
nnoremap <buffer> c :call <SID>EditItem()<CR>
function! s:EditItem()
    set modifiable
    normal! $T]c$ 
    startinsert!
endfunction

" up and down move twice
nnoremap <buffer> j :call <SID>Down()<CR>
nnoremap <buffer> k :call <SID>Up()<CR>
function! s:Down()
    normal! jj
    if line('.') ==# 3
        normal! k
    endif
endfunction
function!s:Up()
    normal! k
    if line('.') !=# 2
        normal! k
    endif
endfunction

" q saves and quits
nnoremap <buffer> q :call <SID>Quit()<CR>
function! s:Quit()
    wq
endfunction
