" And the following to you ~/.vimrc.local
" source $PWD/vimrc.d/vimrc.perl

" ale configuration
let g:ale_linters['perl'] = ['perl', 'perl-critic']
let g:ale_fixers['perl'] = ['perltidy']

" Disable Ctrl-j to avoid collision with tmux config
let g:Perl_Ctrl_j='no'

" Change leader
let g:Perl_MapLeader  = '\'

" disable PerlTags
let g:Perl_PerlTags = 'off'

" https://gist.github.com/jbolila/7598018
let g:tagbar_type_perl = {
  \ 'ctagstype'   : 'Perl',
  \ 'kinds' : [
    \ 'p:packages:1:0',
    \ 'u:uses:1:0',
    \ 'r:requires:1:0',
    \ 'e:extends',
    \ 'w:roles',
    \ 'o:ours:1:0',
    \ 'c:constants:1:0',
    \ 'f:formats:1:0',
    \ 'a:attributes',
    \ 's:subroutines',
    \ 'x:around:1:0',
    \ 'l:aliases',
    \ 'd:pod:1:0',
    \ 't:tasks:1:0',
  \ ],
\ }

augroup RexfileFileType
  au!
  autocmd BufNewFile,BufRead Rexfile  set filetype=perl
augroup END

autocmd FileType perl call SetPerlOptions()
function SetPerlOptions()
  silent! nunmap \

  " remove mapping giving problem
  silent! iunmap <c-x><c-k>
  setlocal complete-=i
endfunction
