setlocal spell spelllang=en_au
setlocal wrap

" keybindings for bold, italics, code blocks, lists, [image] links
inoremap <c-b> ****<esc>hi
inoremap <c-e> **<esc>i
inoremap <c-c><c-b> ```<enter>```<esc>ka<space>
inoremap <c-u><c-l> * 
inoremap <c-o><c-l> 0. 
inoremap <c-l> []()<esc>2hi
inoremap <c-i><c-l> ![]()<esc>2hi

let g:markdown_fenced_languages = [
    \ 'bash=sh', 'c', 'cmake', 'cpp', 'cs', 'csharp=cs', 'css', 'diff',
    \ 'django', 'go', 'html', 'haskell', 'hs=haskell', 'java', 'javascript',
    \ 'js=javascript', 'json', 'less', 'make', 'php', 'python', 'ruby',
    \ 'rust', 'scss', 'sh', 'shell=sh', 'sql', 'vim', 'xml', 'yaml', 'zsh']

vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

let b:sleuth_automatic = 0      " disable vim-sleuth
