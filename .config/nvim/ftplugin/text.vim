setlocal spell spelllang=en_au
setlocal wrap
"
" keybindings for bold, italics, code blocks, lists, [image] links
inoremap <c-b> ****<esc>hi
inoremap <c-e> **<esc>i
inoremap <c-c><c-b> ```<enter>```<esc>ka
inoremap <c-u><c-l> * 
inoremap <c-o><c-l> 1. 
inoremap <c-q><c-b> > 
inoremap <c-l> []()<esc>2hi
inoremap <c-i><c-l> ![]()<esc>2hi

vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
