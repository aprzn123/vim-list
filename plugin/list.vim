" Get config variables
let s:path = get(g:, "list#path", $HOME . "/.vimlist")
let s:size = get(g:, "list#size", 40)
let s:default_file = get(g:, "list#default_file", "todo")

" Ensure directory exists
if isdirectory(s:path)
else
    call mkdir(s:path)
endif

" Opens a new vertical split with either the given file or the default file
function! s:OpenList(...)
    if a:0
        execute "vsplit " . s:path . "/" . a:1 . ".todo"
        execute "vertical resize" . s:size
    else
        execute "vsplit " . s:path . "/" . s:default_file . ".todo"
        execute "vertical resize" . s:size
    endif
endfunction

" Adds title line to list file
function! s:InitList()
    set modifiable
    call append(0, split(split(expand('%'), '/')[-1], '\.')[0])
    normal! ddyypVr=
    set nomodifiable
endfunction

" TODO: Replace checks with the correct character
function! s:CleanupList()
endfunction

" Adds List command
if !exists(":List")
    command -nargs=? List :call s:OpenList(<f-args>)
endif

" Trigger for s:InitList
augroup vimlist
    autocmd!
    autocmd BufNewFile *.todo :call s:InitList()
    autocmd BufRead *.todo :call s:CleanupList()
augroup END
