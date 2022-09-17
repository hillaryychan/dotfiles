setlocal spell spelllang=en_au
setlocal wrap

" bold
inoremap <c-b> ****<esc>hi
" italics
inoremap <c-e> **<esc>i
" equations
inoremap <c-q> $$<esc>i
" code blocks
inoremap <c-c><c-b> ```<enter>```<esc>ka
" unordered list
inoremap <c-u><c-l> * 
" ordered list
inoremap <c-o><c-l> 1. 
" quote block
inoremap <c-q><c-b> > 
" link
inoremap <c-l><c-k> []()<esc>2hi
" link reference
inoremap <c-l><c-r> [][]<esc>2hi
" link label
inoremap <c-l><c-l> []:<esc>hi
" image link
inoremap <c-i><c-l> ![]()<esc>2hi

let g:markdown_fenced_languages = [
    \ 'bash=sh', 'c', 'cmake', 'cpp', 'cs', 'csharp=cs', 'css', 'diff',
    \ 'django', 'go', 'html', 'haskell', 'hs=haskell', 'java', 'javascript',
    \ 'js=javascript', 'json', 'less', 'make', 'php', 'python', 'ruby',
    \ 'rust', 'scss', 'sh', 'shell=sh', 'sql', 'vim', 'xml', 'yaml', 'zsh']

let b:sleuth_automatic = 0      " disable vim-sleuth
