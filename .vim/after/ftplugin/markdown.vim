setlocal spell spelllang=en_au

" keybindings for bold, italics, code blocks, lists, [image] links
inoremap <c-b> ****<esc>hi
inoremap <c-e> __<esc>i
inoremap <c-c><c-l> ``<esc>i
inoremap <c-c><c-b> ```<enter>```<esc>ka<space>
inoremap <c-u><c-l> * 
inoremap <c-o><c-l> 0. 
inoremap <c-l> []()<esc>2hi
inoremap <c-i><c-l> ![]()<esc>2hi
