"=============================================================================
" FILE: markdown_quote_syntax.vim
" AUTHOR:  Tomohiro Hashidate <kakyoin.hierophant@gmail.com>
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================

if exists('g:loaded_markdown_quote_syntax')
  finish
endif

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:markdown_quote_syntax_defaults')
  let g:markdown_quote_syntax_defaults = {
        \ "vim" : {
        \   "start" : "^\\s*```vim$",
        \   "end"   : "^\\s*```\\ze\\s*$"
        \},
        \ "diff" : {
        \   "start" : "^\\s*```diff$",
        \   "end"   : "^\\s*```\\ze\\s*$"
        \},
        \ "c" : {
        \   "start" : "^\\s*```c$",
        \   "end"   : "^\\s*```\\ze\\s*$"
        \},
        \ "cpp" : {
        \   "start" : "^\\s*```cpp$",
        \   "end"   : "^\\s*```\\ze\\s*$"
        \},
        \ "java" : {
        \   "start" : "^\\s*```java$",
        \   "end"   : "^\\s*```\\ze\\s*$"
        \},
        \ "ruby" : {
        \   "start" : "^\\s*```\\%(ruby\\|rb\\)$",
        \   "end"   : "^\\s*```\\ze\\s*$"
        \},
        \ "haskell" : {
        \   "start" : "^\\s*```\\%(haskell\\|hs\\)$",
        \   "end"   : "^\\s*```\\ze\\s*$"
        \},
        \ "python" : {
        \   "start" : "^\\s*```\\%(python\\|py\\)$",
        \   "end"   : "^\\s*```\\ze\\s*$"
        \},
        \ "perl" : {
        \   "start" : "^\\s*```\\%(perl\\|pl\\)$",
        \   "end"   : "^\\s*```\\ze\\s*$"
        \},
        \ "javascript" : {
        \   "start" : "^\\s*```\\%(javascript\\|js\\)$",
        \   "end"   : "^\\s*```\\ze\\s*$"
        \},
        \ "html" : {
        \   "start" : "^\\s*```html$",
        \   "end"   : "^\\s*```\\ze\\s*$"
        \},
        \ "sh" : {
        \   "start" : "^\\s*```sh$",
        \   "end"   : "^\\s*```\\ze\\s*$"
        \},
        \ "sql" : {
        \   "start" : "^\\s*```sql$",
        \   "end"   : "^\\s*```\\ze\\s*$"
        \},
        \ "ocaml" : {
        \   "start" : "^\\s*```ocaml$",
        \   "end"   : "^\\s*```\\ze\\s*$"
        \},
        \ "erlang" : {
        \   "start" : "^\\s*```erlang$",
        \   "end"   : "^\\s*```\\ze\\s*$"
        \},
  \}
endif

if !exists('g:markdown_quote_syntax_filetypes')
  let g:markdown_quote_syntax_filetypes = {}
endif

function! s:enable_quote_syntax()
  let defaults = deepcopy(g:markdown_quote_syntax_defaults)
  let filetype_dic = extend(defaults, g:markdown_quote_syntax_filetypes)


  for [filetype, option] in items(filetype_dic)
    call markdown_quote_syntax#include_other_syntax(filetype)
    call markdown_quote_syntax#enable_quote_highlight(filetype, option.start, option.end)
  endfor
endfunction

augroup markdown_quote_syntax
  autocmd!
  autocmd Syntax markdown call s:enable_quote_syntax()
augroup END

let g:loaded_markdown_quote_syntax = 1

let &cpo = s:save_cpo
unlet s:save_cpo
