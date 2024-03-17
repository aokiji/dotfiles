# Setup

## Dependencies

Install dependencies

For fedora
```
sudo apt install tmux vim fasd
curl -sS https://starship.rs/install.sh | sh
```

## Configuration

```
echo "source $PWD/bashrc" >> ~/.bashrc
source ~/.bashrc

echo "source $PWD/tmux.conf" >> ~/.tmux.conf
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
