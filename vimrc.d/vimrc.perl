" And the following to you ~/.vimrc.local
" source $PWD/vimrc.d/vimrc.perl

" ale configuration
let g:ale_linters['perl'] = ['perl', 'perl-critic']
let g:ale_fixers['perl'] = ['perltidy']

" Disable Ctrl-j to avoid collision with tmux config
let g:Perl_Ctrl_j='no'

" Change leader
let g:Perl_MapLeader  = '\'

" Enable Perl::Tags, this requires module Perl::Tags
let g:Perl_PerlTags = 'on'

autocmd FileType perl call SetPerlOptions()
function SetPerlOptions()
  nunmap \

  " remove mapping giving problem
  iunmap <c-x><c-k>
  setlocal complete-=i
endfunction
