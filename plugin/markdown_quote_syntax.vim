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
        \   "start" : "vim",
        \},
        \ "diff" : {
        \   "start" : "diff",
        \},
        \ "c" : {
        \   "start" : "c",
        \},
        \ "cpp" : {
        \   "start" : "cpp",
        \},
        \ "java" : {
        \   "start" : "java",
        \},
        \ "ruby" : {
        \   "start" : "\\%(ruby\\|rb\\)",
        \},
        \ "haskell" : {
        \   "start" : "\\%(haskell\\|hs\\)",
        \},
        \ "python" : {
        \   "start" : "\\%(python\\|py\\)",
        \},
        \ "perl" : {
        \   "start" : "\\%(perl\\|pl\\)",
        \},
        \ "javascript" : {
        \   "start" : "\\%(javascript\\|js\\)",
        \},
        \ "html" : {
        \   "start" : "html",
        \},
        \ "sh" : {
        \   "start" : "sh",
        \},
        \ "sql" : {
        \   "start" : "sql",
        \},
        \ "ocaml" : {
        \   "start" : "ocaml",
        \},
        \ "erlang" : {
        \   "start" : "erlang",
        \},
  \}
endif

if !exists('g:markdown_quote_syntax_filetypes')
  let g:markdown_quote_syntax_filetypes = {}
endif

if !exists('g:markdown_quote_syntax_codeblocks_default')
  " Triple backtick, Triple wave, Liquid highlight,
  " Octopress codeblock (w/ and w/o lang:)
  "
  " Each codeblock is defined as:
  "  'codeblock[0].filetype.codeblock[1]<code lines>codeblock[2]'
  let g:markdown_quote_syntax_codeblocks_default = [
    \["^\\s*\\(>\\s*\\)\\?```", "\\(\\s*:.*\\)\\?$",
      \"^\\s*\\(>\\s*\\)\\?```\\ze\\s*$"],
    \["^\\s*\\~\\{3,}\.*\\.", ".*$","^\\s*\\~\\{3,}\\ze\\s*$"],
    \["^\\s*{% *highlight \\+", "\\( .*%\\|%\\)}", "^\\s*{% *endhighlight\\( .*%\\|%\\)}"],
    \["^\\s*{% *codeblock \\( *\\|.* \\)lang:", "\\( .*%\\|%\\)}", "^\\s*{% *endcodeblock\\( .*%\\|%\\)}"],
    \["^\\s*{% *codeblock \\(.*lang:.*\\)\\@!.*\\.", "\\( *%\\| .*%\\)}", "^\\s*{% *endcodeblock\\( .*%\\|%\\)}"],
  \]
endif

if !exists('g:markdown_quote_syntax_codeblocks')
  let g:markdown_quote_syntax_codeblocks = []
endif

if !exists('g:markdown_quote_syntax_on_filetypes_default')
  let g:markdown_quote_syntax_on_filetypes_default = ['markdown', 'mkd']
endif

if !exists('g:markdown_quote_syntax_on_filetypes')
  let g:markdown_quote_syntax_on_filetypes = []
endif

augroup markdown_quote_syntax
  autocmd!
  let on_filetypes = deepcopy(g:markdown_quote_syntax_on_filetypes_default)
  let on_filetypes = extend(on_filetypes, g:markdown_quote_syntax_on_filetypes)
  for ft in on_filetypes
    execute "autocmd Syntax" ft "call markdown_quote_syntax#enable_quote_syntax()"
  endfor
augroup END

let g:loaded_markdown_quote_syntax = 1

let &cpo = s:save_cpo
unlet s:save_cpo
