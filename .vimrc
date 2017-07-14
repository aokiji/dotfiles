" ============================================================================
" Plugins
" ============================================================================
" Specify a directory for plugins
silent! if plug#begin('~/.vim/plugged')

" ----------------------------------------------------------------------------
" Integrations
" ----------------------------------------------------------------------------
" Git plugin
Plug 'tpope/vim-fugitive'
" A git commit browser.
Plug 'junegunn/gv.vim'

" ----------------------------------------------------------------------------
" Language support
" ----------------------------------------------------------------------------
Plug 'vim-ruby/vim-ruby'
" This adds #{} in surround
" this means that we can select text and use S# to interpolate selection
Plug 'p0deje/vim-ruby-interpolation', {'for': 'ruby'}
" use ar (external) and ir (internal) to select blocks in visual mode
Plug 'nelstrom/vim-textobj-rubyblock', {'for': 'ruby'} " depends: vim-textobj-user
Plug 'tpope/vim-endwise', {'for': 'ruby'}

" ----------------------------------------------------------------------------
" Navigation
" ----------------------------------------------------------------------------
" use fzf on vim
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Improves search experience
Plug 'junegunn/vim-slash'
" Automatically change root directory
Plug 'airblade/vim-rooter'

" ----------------------------------------------------------------------------
" Edit Steroids
" ----------------------------------------------------------------------------
Plug 'kana/vim-textobj-user'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
" use cs<DEL1><DEL2>
Plug 'tpope/vim-surround'
" use gcc or gc in visual mode to comment
Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
Plug 'vim-scripts/DeleteTrailingWhitespace'
" gS split one-liner into multiple lines
" gJ (with the cursor on the first line of the block) join a block
Plug 'AndrewRadev/splitjoin.vim'
" Plug 'terryma/vim-multiple-cursors'
Plug 'mattn/sonictemplate-vim'
" Add matching pairs [], (), etc
Plug 'jiangmiao/auto-pairs'
" Abbreviation, substitution and coercion
Plug 'tpope/tpope-vim-abolish'

" ----------------------------------------------------------------------------
" Linters, testers
" ----------------------------------------------------------------------------
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-dispatch'
Plug 'thoughtbot/vim-rspec'
" adds several useful mappings with ([|])<sequence> pattern
" [b or ]b to map buffer navigation
" [e or ]e to exchange lines
" [u ]u encode and decode url
" [f ]f next/previous file
" [n ]n navigate conflicts in SCM
Plug 'tpope/vim-unimpaired'

" ----------------------------------------------------------------------------
" Vim improved
" ----------------------------------------------------------------------------
Plug 'tpope/vim-repeat'

call plug#end()
endif

" ============================================================================
" Basic Settings
" ============================================================================
" Change leader key to <Space>
let mapleader      = ' '
let maplocalleader = ' '

" Basic settings
set nu                   " show line numbers
set autoindent           " copy indent from current line when starting a new line
set smartindent          " smart autoindenting for C-like programs
set hlsearch             " highlight search results
set incsearch            " go to first match on search result as is typed
set tabstop=2            " how many space a tab is equal to
set shiftwidth=2         " number of spaces used in indent (<<, >>)
set expandtab smarttab   " use spaces instead of tabs in insert mode
set ignorecase smartcase " ignore case in searches, unless explicit case given

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

" <tab> / <s-tab> | Circular windows navigation
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

inoremap jj <Esc>

" ============================================================================
" Plugin Settings
" ============================================================================
" ----------------------------------------------------------------------------
" unimpaired
" ----------------------------------------------------------------------------
nmap - [
nmap + ]
omap - [
omap + ]
xmap - [
xmap + ]

" ----------------------------------------------------------------------------
" auto-pairs
" ----------------------------------------------------------------------------
" Clear <M-p> mapping
let g:AutoPairsShortcutToggle = ''

" Autoclose pipe in Ruby
autocmd FileType ruby
      \ let b:AutoPairs = {'|': '|'} |
      \ for key in keys(g:AutoPairs) |
      \   let b:AutoPairs[key] = g:AutoPairs[key] |
\ endfor

" ----------------------------------------------------------------------------
" DeleteTrailingWhitespace
" ----------------------------------------------------------------------------
let g:DeleteTrailingWhitespace = 1
let g:DeleteTrailingWhitespace_Action = 'delete'

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

" ----------------------------------------------------------------------------
" vim-rspec
" ----------------------------------------------------------------------------
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
let g:rspec_command = "Dispatch bin/rspec_docker {spec}"

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
