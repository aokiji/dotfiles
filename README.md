# Setup

## Dependencies

Install dependencies

For fedora
```
sudo dnf install tmux vim fasd
# install bash-git-prompt
cd ~
git clone https://github.com/magicmonty/bash-git-prompt.git .bash-git-prompt --depth=1
```

## Configuration

```
mv ~/.bashrc ~/.bashrc.local
mkdir ~/.bashrc.d
ln -s $PWD/bashrc ~/.bashrc
ln -s $PWD/bashrc.d/* ~/.bashrc.d/
echo 'export PATH='$PWD'/bin:$PATH' >> ~/.bashrc.d/bin.bashrc
source ~/.bashrc
ln -s $PWD/tmux.conf ~/.tmux.conf
```
### Tmux

```
$> git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Vim

Setup plugin manager

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -sf $PWD/vimrc ~/.vimrc
ln -sf $PWD/vimrc.bundles ~/.vimrc.bundles
mkdir ~/.vimrc.d/

# copy specific language handlers
ln -sf $PWD/vimrc.d/ruby.bundles.vim ~/.vimrc.d/
ln -sf $PWD/vimrc.d/ruby.config.vim ~/.vimrc.d/
```

Open vim and exec :PlugInstall

### VIM Perl

You can setup general perl configuration in the following manner:

```
ln -sf $PWD/vimrc.d/perl.config.vim ~/.vimrc.d/
ln -sf $PWD/vimrc.d/perl.bundles.vim ~/.vimrc.d/
```

and then :PlugInstall

If you use cpanm or other packager you may consider setting de package list for perlomni

```
let g:cpan_user_defined_sources = [expand('~/.cpanm/sources/http%www.cpan.org/02packages.details.txt.gz')]
```

#### Snippets

You can add custom snippets via

```
ln -s $PWD/UltiSnips ~/.vim/

```

### NVIM

```
ln -sf $PWD/nvim/init.lua ~/.config/nvim/
ln -sf $PWD/nvim/lua/plugins ~/.config/nvim/lua/
ln -sf $PWD/nvim/lua/config ~/.config/nvim/lua/
ln -sf $PWD/nvim/luasnippets ~/.config/nvim/
```

### SSH

Add tmux on remote execution

```
# ~/.ssh/config
Host remote
Include $DOTFILES_DIR/ssh/config/remote_tmux
```

#### Extending completion with fzf

With a list_tasks commands that outputs lines in the format ID TITLE.
You could set C-X+C-T in insert mode so that it filters from it to get
the task id.

```vim
function! s:task_reduce(lines)
  return split(a:lines[0])[0]
endfunction

function! FzfCompleteTask(...)
  return fzf#vim#complete({
        \ 'source': 'list_tasks',
        \ 'reducer': function('s:task_reduce')
        \ })
endfunction

inoremap <expr> <c-x><c-t> FzfCompleteTask()
```
