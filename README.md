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

### NVIM

```
echo "vim.cmd('source $PWD/nvim/init.lua')" > ~/.config/nvim
```

### SSH

Add tmux on remote execution

```
# ~/.ssh/config
Host remote
Include $DOTFILES_DIR/ssh/config/remote_tmux
```
