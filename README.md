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

### Vim

Setup plugin manager

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Open vim and exec :PlugInstall
