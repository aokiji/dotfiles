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

" Ease regexp use in vim
set magic

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
nnoremap <leader>s :update<cr>
nnoremap <leader>w :update<cr>

" Quit
inoremap <C-Q>     <esc>:q<cr>
nnoremap <C-Q>     :q<cr>
vnoremap <C-Q>     <esc>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>Q :qa!<cr>

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
if has('nvim')
  set viminfo+=n~/.local/share/nvim/viminfo
else
  set viminfo+=n~/.vim/viminfo
endif

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

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  nnoremap \ :Ag<SPACE>

  nnoremap K :exe 'Ag' expand('<cword>')<cr>
else
  " bind K to grep word under cursor
  nnoremap K :Ag "\b<C-R><C-W>\b"<CR>:cw<CR>
endif

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

let g:ale_fixers = {}
let g:ale_linters = {
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

" Move to last line when pasting, you can go back with C-O
let g:EasyClipAlwaysMoveCursorToEndOfPaste=1

" ----------------------------------------------------------------------------
" ultisnips
" ----------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger="<c-b>"
inoremap <C-l> <C-o>:Snippets<cr>

" ----------------------------------------------------------------------------
" NERDTree
" ----------------------------------------------------------------------------
nnoremap tt :NERDTreeToggle<cr>
nnoremap tf :NERDTreeFind<cr>

" ----------------------------------------------------------------------------
" mucomplete
" ----------------------------------------------------------------------------
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#chains = {
      \ 'default': ['path', 'keyn', 'ulti', 'omni', 'dict'],
      \ 'gitcommit' : ['ulti', 'keyn', 'dict', 'uspl'],
      \ 'ruby': ['path', 'ulti', 'dict'],
      \ 'sql': ['file', 'ulti', 'dict', 'keyn'],
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
let g:startify_change_to_vcs_root = 1
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


" auto-pairs
let g:AutoPairsMapCR = 0

" combine with mucomplete and ultisnips
imap <Plug>OmniEnter <Plug>(MUcompleteCR)<Plug>AutoPairsReturn
imap <CR> <Plug>OmniEnter

" ultisnips
let g:UltiSnipsExpandTrigger = "<nop>"
imap <expr> <CR> pumvisible() ? "<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>" : "\<Plug>OmniEnter"

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
" fzf
" ----------------------------------------------------------------------------
if has('nvim') || has('gui_running')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif

" Hide statusline of terminal buffer
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>L :Lines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>T :Tags<CR>
nnoremap <silent> <Leader>? :Helptags<CR>

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
inoremap <expr> <c-x><c-d> fzf#vim#complete#path('blsd')
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

if executable('ag')
  " https://github.com/junegunn/fzf/wiki/Examples-%28vim%29#narrow-ag-results-within-vim
  " CTRL-X, CTRL-V, CTRL-T to open in a new split, vertical split, tab respectively.
  " CTRL-A to select all matches and list them in quickfix window
  " CTRL-D to deselect all
  function! s:ag_to_qf(line)
    let parts = split(a:line, ':')
    return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
          \ 'text': join(parts[3:], ':')}
  endfunction

  function! s:ag_handler(lines)
    if len(a:lines) < 2 | return | endif

    let cmd = get({'ctrl-x': 'split',
          \ 'ctrl-v': 'vertical split',
          \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
    let list = map(a:lines[1:], 's:ag_to_qf(v:val)')

    let first = list[0]
    execute cmd escape(first.filename, ' %#\')
    execute first.lnum
    execute 'normal!' first.col.'|zz'

    if len(list) > 1
      call setqflist(list)
      copen
      wincmd p
    endif
  endfunction

  command! -nargs=* Ag call fzf#run({
        \ 'source':  printf('ag --nogroup --column --color "%s"',
        \                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
        \ 'sink*':    function('<sid>ag_handler'),
        \ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
        \            '--multi --bind=ctrl-a:select-all,ctrl-d:deselect-all '.
        \            '--color hl:68,hl+:110',
        \ 'down':    '50%'
        \ })
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
" Tagbar
" ----------------------------------------------------------------------------
nnoremap tb :TagbarToggle<cr>
let g:tagbar_autoclose = 1

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

" Format json
com! FormatJSON %!python -m json.tool

" Load local settings
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
