# Setup

## Dependencies

Install dependencies

For fedora
```
sudo dnf install tmux nvim fasd
# install bash-git-prompt
cd ~
git clone https://github.com/magicmonty/bash-git-prompt.git .bash-git-prompt --depth=1
```

## Configuration

```
mv ~/.bashrc ~/.bashrc.local
ln -s $PWD/bashrc ~/.bashrc
ln -s $PWD/bashrc.d ~/.bashrc.d
source ~/.bashrc
ln -s $PWD/tmux.conf ~/.tmux.conf
```
