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

#### Snippets

You can add custom snippets via

```
ln -s $PWD/UltiSnips ~/.vim/

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
