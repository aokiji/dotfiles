" Specify a directory for plugins
silent! if plug#begin('~/.vim/plugged')

" use fzf on vim
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Improves search experience
Plug 'junegunn/vim-slash'
" A git commit browser.
Plug 'junegunn/gv.vim'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-repeat'
" use cs<DEL1><DEL2>
Plug 'tpope/vim-surround'
" use gcc or gc in visual mode to comment
Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
Plug 'tpope/vim-endwise'
" gS split one-liner into multiple lines
" gJ (with the cursor on the first line of the block) join a block
Plug 'AndrewRadev/splitjoin.vim'
" Git plugin
Plug 'tpope/vim-fugitive'
" Plug 'terryma/vim-multiple-cursors'
Plug 'mattn/sonictemplate-vim'
" Use crc to modify word to camelcase and crs to snakecase
Plug 'tpope/tpope-vim-abolish'

call plug#end()
endif

" Change leader key to <Space>
let mapleader      = ' '
let maplocalleader = ' '

" Basic settings
set nu
set autoindent
set smartindent
set hlsearch
set incsearch
set tabstop=2
set shiftwidth=2
set expandtab smarttab
set ignorecase smartcase

" Save
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>
nnoremap <leader>s :update<cr>
nnoremap <leader>w :update<cr>

" Quit
inoremap <C-Q>     <esc>:q<cr>
nnoremap <C-Q>     :q<cr>
vnoremap <C-Q>     <esc>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>Q :qa!<cr>

" ----------------------------------------------------------------------------
" Buffers
" ----------------------------------------------------------------------------
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" Annoying temporary files
set backupdir=/tmp//,.
set directory=/tmp//,.
if v:version >= 703
  set undodir=/tmp//,.
endif

" Terminal settings
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif

" ----------------------------------------------------------------------------
" Tabs
" ----------------------------------------------------------------------------
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

" ----------------------------------------------------------------------------
" <tab> / <s-tab> | Circular windows navigation
" ----------------------------------------------------------------------------
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

" ----------------------------------------------------------------------------
" vim-commentary
" ----------------------------------------------------------------------------
map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine

map <Leader>c gc
nmap <Leader>c gcc

" ----------------------------------------------------------------------------
" vim-surround
" ----------------------------------------------------------------------------
nmap <Leader>2 cs'"
nmap <Leader>' cs"'

" ----------------------------------------------------------------------------
" vim-fzf
" ----------------------------------------------------------------------------
nnoremap <Leader>f :Files<cr>

if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
  " let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

" ----------------------------------------------------------------------------
" vim-easy-align
" ----------------------------------------------------------------------------
let g:easy_align_delimiters = {
\ '>': { 'pattern': '>>\|=>\|>' },
\ '\': { 'pattern': '\\' },
\ '/': { 'pattern': '//\+\|/\*\|\*/', 'delimiter_align': 'l', 'ignore_groups': ['!Comment'] },
\ ']': {
\     'pattern':       '\]\zs',
\     'left_margin':   0,
\     'right_margin':  1,
\     'stick_to_left': 0
\   },
\ ')': {
\     'pattern':       ')\zs',
\     'left_margin':   0,
\     'right_margin':  1,
\     'stick_to_left': 0
\   },
\ 'f': {
\     'pattern': ' \(\S\+(\)\@=',
\     'left_margin': 0,
\     'right_margin': 0
\   },
\ 'd': {
\     'pattern': ' \ze\S\+\s*[;=]',
\     'left_margin': 0,
\     'right_margin': 0
\   }
\ }

" Start interactive EasyAlign in visual mode
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign with a Vim movement
nmap ga <Plug>(EasyAlign)
nmap gaa ga_

" ----------------------------------------------------------------------------
" vim-fugitive
" ----------------------------------------------------------------------------
nmap     <Leader>g :Gstatus<CR>gg<c-n>
nnoremap <Leader>d :Gdiff<CR>

" ----------------------------------------------------------------------------
" vim-multiple-cursor
" ----------------------------------------------------------------------------
" nnoremap <silent> <M-j> :MultipleCursorsFind <C-R>/<CR>
" vnoremap <silent> <M-j> :MultipleCursorsFind <C-R>/<CR>


" ----------------------------------------------------------------------------
" sonictemplate
" ----------------------------------------------------------------------------
let g:sonictemplate_vim_template_dir = '$HOME/.vim/templates'

" ============================================================================
" AUTOCMD {{{
" ============================================================================
augroup vimrc
  " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
  au BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
  au InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/
augroup END


" ----------------------------------------------------------------------------
" Todo
" ----------------------------------------------------------------------------
function! s:todo() abort
  let entries = []
  for cmd in ['git grep -niI -e TODO -e FIXME 2> /dev/null',
            \ 'grep -rniI -e TODO -e FIXME * 2> /dev/null']
    let lines = split(system(cmd), '\n')
    if v:shell_error != 0 | continue | endif
    for line in lines
      let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
      call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
    endfor
    break
  endfor

  if !empty(entries)
    call setqflist(entries)
    copen
  endif
endfunction
command! Todo call s:todo()


" ----------------------------------------------------------------------------
" #gi / #gpi | go to next/previous indentation level
" ----------------------------------------------------------------------------
function! s:indent_len(str)
  return type(a:str) == 1 ? len(matchstr(a:str, '^\s*')) : 0
endfunction

function! s:go_indent(times, dir)
  for _ in range(a:times)
    let l = line('.')
    let x = line('$')
    let i = s:indent_len(getline(l))
    let e = empty(getline(l))

    while l >= 1 && l <= x
      let line = getline(l + a:dir)
      let l += a:dir
      if s:indent_len(line) != i || empty(line) != e
        break
      endif
    endwhile
    let l = min([max([1, l]), x])
    execute 'normal! '. l .'G^'
  endfor
endfunction
nnoremap <silent> gi :<c-u>call <SID>go_indent(v:count1, 1)<cr>
nnoremap <silent> gpi :<c-u>call <SID>go_indent(v:count1, -1)<cr>


" Generates a ruby class definition based on the current file's path
function! GenerateRubyClassDefinition()
  " parse file path
  let l:path = expand("%:.:r")
  let l:path = substitute(l:path, "lib/", "", "")
  let l:parts = split(l:path, "/")

  " extract parts
  let l:class_name = l:parts[-1]
  let l:module_names = l:parts[0:-2]

  " generate
  let l:indentation = 0
  let l:output = ""

  " generate - module headers
  for m in l:module_names
    let l:output .= repeat(" ", l:indentation) . "module " . g:Abolish.mixedcase(m) . "\n"
    let l:indentation = l:indentation + 2
  endfor

  " generate - class
  let l:output .= repeat(" ", l:indentation) . "class " . g:Abolish.mixedcase(l:class_name) . "\n"
  let l:output .= repeat(" ", l:indentation) . "end\n"

  " generate - module footers
  for m in l:module_names
    let l:indentation = l:indentation - 2
    let l:output .= repeat(" ", l:indentation) . "end\n"
  endfor

  return l:output
endfunction

" Generates a rspec definition based on the current file's path
function! GenerateRubySpecDefinition()
  " parse file path
  let l:path = expand("%:.:r")
  let l:path = substitute(l:path, "spec/", "", "")
  let l:parts = split(l:path, "/")

  " extract parts
  let l:class_name = l:parts[-1]
  let l:class_name = substitute(l:class_name, "_spec", "", "")
  let l:module_names = l:parts[1:-2]
  call map(l:module_names, 'g:Abolish.mixedcase(v:val)') 

  " generate
  let l:class_name = g:Abolish.mixedcase(l:class_name)
  let l:output = "RSpec.describe " . join(l:module_names, "::") . "::" . l:class_name . " do"
  let l:output .= "\nend"

  return l:output
endfunction

" set statusline="%f%m%r%h%w [%Y] [0x%02.2B]%< %F%=%4v,%4l %3p%% of %L"
set statusline=%<[%n]\ %F\ %m%r%y\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}\ %=%-14.(%l,%c%V%)\ %P

" syntastic config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list            = 1
let g:syntastic_check_on_open            = 1
let g:syntastic_check_on_wq              = 0

let g:syntastic_ruby_checkers          = ['rubocop', 'mri', 'reek']
let g:syntastic_ruby_rubocop_exec      = '/home/nicolas.delossantos/.rbenv/shims/rubocop'

nmap fs i# frozen_string_literal: true<cr><cr><esc>
