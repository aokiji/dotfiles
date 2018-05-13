" source this file in your vimrc.local
" source $PWD/vimrc.d/cpp.vim

" make in build dir
autocmd FileType cpp call SetCppOptions()
function SetCppOptions()
  set makeprg=make\ -C\ build\ -j8
  nmap <f4> :make!<cr>
endfunction
