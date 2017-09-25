" ============================================================================
" Plugins
" ============================================================================
let g:has_async = v:version >= 800 || has('nvim')

if filereadable(expand("~/.vimrc.bundles"))
 source ~/.vimrc.bundles
endif

" ============================================================================
" Basic Settings
" ============================================================================
" Don't be compatible with vi
set nocompatible

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

" Move current line up/down
nnoremap <C-j> yyddp=
nnoremap <C-k> yyddkP=

" Backup files
if isdirectory($HOME . '/.vim/backup') == 0
    :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup/
set backupdir^=./.vim-backup/
set backup

" Save your swp files to a less annoying place than the current directory.
" " If you have .vim-swap in the current directory, it'll use that.
" " Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
    :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

" viminfo stores the the state of your previous editing session
set viminfo+=n~/.vim/viminfo

if exists("+undofile")
    " undofile - This allows you to use undos after exiting and restarting
    " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
    " :help undo-persistence
    " This is only present in 7.3+
    if isdirectory($HOME . '/.vim/undo') == 0
        :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
    endif
    set undodir=./.vim-undo//
    set undodir+=~/.vim/undo//
    set undofile
endif

" Terminal settings
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif

" <tab> / <s-tab> | Circular windows navigation
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

" Removing escape
ino jj <esc>
cno jj <c-c>
vno v <esc>

" Remap indentation, as will be using < and > for other purposes
nnoremap - <<
nnoremap + >>
" in visual mode maintain selection
vnoremap - <gv
vnoremap + >gv

" completion improvements
set completeopt+=menu
set completeopt+=menuone
set completeopt+=noinsert
set completeopt+=noselect
set shortmess+=c

" share clipboard with system
set clipboard=unnamed

" Disable terrible Ex mode
nnoremap Q <nop>

" return to previous cursor position when copying from visual selection
vnoremap y y`]

" duplicate selection
vnoremap D y'>p

" ============================================================================
" Plugin Settings
" ============================================================================
" ----------------------------------------------------------------------------
" airline
" ----------------------------------------------------------------------------
let g:airline_theme='aurora'

" ----------------------------------------------------------------------------
" ale
" ----------------------------------------------------------------------------
let g:ale_set_loclist = 1
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_fixers = {
      \   'ruby': ['rubocop'],
      \}
let g:ale_linters = {
      \   'ruby': ['rubocop', 'reek', 'ruby'],
      \   'javascript': ['eslint']
      \}
" if you with to setup you own rubocop executable, uncomment and setup the
" following line
" let g:ale_ruby_rubocop_executable = '/home/nicolas.delossantos/.rbenv/shims/rubocop'

nnoremap <Leader>F :ALEFix<cr>

" this mapping shadows unimpaired move up line
nmap <silent> <e <Plug>(ale_previous_wrap)
nmap <silent> >e <Plug>(ale_next_wrap)

" ----------------------------------------------------------------------------
" easyalign
" ----------------------------------------------------------------------------
let g:EasyClipAutoFormat = 1
let g:EasyClipDoSystemSync = 0

nmap M m$

nmap <M-p> <plug>EasyClipSwapPasteForward
nmap <M-S-p> <plug>EasyClipSwapPasteBackwards

" Substitute operator
nmap <silent> gr <plug>SubstituteOverMotionMap
nmap grr <plug>SubstituteLine
xmap gr <plug>XEasyClipPaste

" ----------------------------------------------------------------------------
" snipmate
" ----------------------------------------------------------------------------
:imap <c-s> <Plug>snipMateNextOrTrigger
:smap <c-s> <Plug>snipMateNextOrTrigger

" ----------------------------------------------------------------------------
" mucomplete
" ----------------------------------------------------------------------------
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#chains = {
      \ 'default': ['path', 'keyn', 'omni', 'dict'],
      \ 'cucumber' : ['keyn', 'dict', 'line', 'uspl'],
      \ 'gitcommit' : ['keyn', 'dict', 'uspl'],
      \ 'ruby': ['path', 'dict'],
      \ 'sql': ['file', 'dict', 'keyn'],
      \ }
" ----------------------------------------------------------------------------
" vim-merginal
" ----------------------------------------------------------------------------
map <Leader>m :MerginalToggle<CR>

" ----------------------------------------------------------------------------
" vim-signature
" ----------------------------------------------------------------------------
" Leave "m" for other plugins
let g:SignatureMap = {'Leader': 'gm'}

" ----------------------------------------------------------------------------
" startify
" ----------------------------------------------------------------------------
let g:startify_session_dir = '~/.vim/sessions'
let g:startify_session_persistence = 1
let g:startify_relative_path = 1
let g:startify_list_order = [
  \ ['   Sessions:'],
  \ 'sessions',
  \ ['   Recent files:'],
  \ 'files',
  \ ['   Recent files in current directory:'],
  \ 'dir',
  \ ]

" ----------------------------------------------------------------------------
" unimpaired
" ----------------------------------------------------------------------------
nmap < [
nmap > ]
omap < [
omap > ]
xmap < [
xmap > ]

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
autocmd FileType ruby compiler rspec

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
" ctrlp
" ----------------------------------------------------------------------------
nnoremap <Leader>f :CtrlP<cr>
nnoremap <Leader>b :CtrlPBuffer<Cr>

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
else
  echoerr "is better to use ag for ctrp, install the_silver_searcher"
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
" sonictemplate
" ----------------------------------------------------------------------------
let g:sonictemplate_vim_template_dir = '$HOME/.vim/templates'

" ----------------------------------------------------------------------------
" vim-test
" ----------------------------------------------------------------------------
map <Leader>t :TestFile<CR>
map <Leader>l :TestLast<CR>
map <Leader>a :TestSuite<CR>
map <Leader>n :TestNearest<CR>
" make test commands execute using dispatch.vim
let test#strategy = "dispatch"

" for a custom rspec command
" let g:dispatch_compilers = {}
" let g:dispatch_compilers['bin/rspec_docker'] = 'rspec'
" let test#ruby#rspec#executable = 'bin/rspec_docker'

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

" Format json
com! FormatJSON %!python -m json.tool

" Ruby hash syntax conversion
nnoremap <c-h> :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<return>

nmap fs :set paste<cr>i# frozen_string_literal: true<cr><cr><esc>:set nopaste<cr>

" Load local settings
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
