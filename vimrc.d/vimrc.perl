" And the following to you ~/.vimrc.local
" source $PWD/vimrc.d/vimrc.perl

" ale configuration
let g:ale_linters['perl'] = ['perl', 'perl-critic']
let g:ale_fixers['perl'] = ['perltidy']
