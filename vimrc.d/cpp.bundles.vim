" source this file in your vimrc.bundles.local
" source $PWD/vimrc.d/cpp.bundles.vim

" indexer
Plug 'lyuts/vim-rtags', { 'for': ['c', 'cpp'] }

" To use indexer with cmake project do
" cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .
" rc -J
