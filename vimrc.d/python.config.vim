" And the following to you ~/.vimrc.local
" source $PWD/vimrc.d/vimrc.python

" ale configuration
let g:ale_linters['python'] = ['pylint']
let g:ale_fixers['python'] = ['yapf']
