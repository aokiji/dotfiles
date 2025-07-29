# Setup

## Dependencies

Install dependencies

For ubuntu
```
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt install tmux vim fzf
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
$> go install github.com/joshmedeski/sesh/v2@latest
$> mkdir -p ~/.config/sesh && touch ~/.config/sesh/sesh.toml
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
