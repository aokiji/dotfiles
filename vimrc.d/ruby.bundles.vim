" Add the following line to your ~/.vimrc.bundles.local
" source $PWD/vimrc.d/ruby.bundles.vim

Plug 'vim-ruby/vim-ruby'
" This adds #{} in surround
" this means that we can select text and use S# to interpolate selection
Plug 'p0deje/vim-ruby-interpolation', {'for': 'ruby'}
" use ar (external) and ir (internal) to select blocks in visual mode
Plug 'nelstrom/vim-textobj-rubyblock', {'for': 'ruby'} " depends: vim-textobj-user
Plug 'tpope/vim-endwise', {'for': 'ruby'}
