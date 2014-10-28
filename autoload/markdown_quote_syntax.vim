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

let s:save_cpo = &cpo
set cpo&vim

function! markdown_quote_syntax#syntax_group(filetype)
  let ft = toupper(a:filetype)
  return 'markdownCodeGroup'.ft
endfunction

function! markdown_quote_syntax#syntax_region(filetype)
  let ft = toupper(a:filetype)
  return 'markdownCodeRegion'.ft
endfunction

function! markdown_quote_syntax#include_other_syntax(filetype)
  let group = markdown_quote_syntax#syntax_group(a:filetype)

  " syntax save
  if exists('b:current_syntax')
    let s:current_syntax = b:current_syntax
    unlet b:current_syntax
  endif

  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'

  " syntax restore
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif

  return group
endfunction

function! markdown_quote_syntax#enable_quote_highlight(filetype, start)
  let group = markdown_quote_syntax#syntax_group(a:filetype)
  let region = markdown_quote_syntax#syntax_region(a:filetype)

  let regexp_start = "^\\s*\\(>\\s*\\)\\?```".a:start."\\(\\s*:.*\\)\\?$"
  let regexp_end = "^\\s*\\(>\\s*\\)\\?```\\ze\\s*$"

  execute 'syntax region '.region.'
  \ matchgroup=markdownCodeDelimiter
  \ start="'.regexp_start.'" end="'.regexp_end.'"
  \ keepend contains=@'.group
endfunction

function! markdown_quote_syntax#enable_quote_syntax()
  let defaults = deepcopy(g:markdown_quote_syntax_defaults)
  let filetype_dic = extend(defaults, g:markdown_quote_syntax_filetypes)

  for [filetype, option] in items(filetype_dic)
    call markdown_quote_syntax#include_other_syntax(filetype)
    call markdown_quote_syntax#enable_quote_highlight(filetype, option.start)
  endfor
  " Fix spell check (needed if such java is included)
  syntax spell toplevel
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
