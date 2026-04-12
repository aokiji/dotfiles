# Setup

## Dependencies

Install dependencies

For ubuntu
```
snap install nvim --classic
sudo apt install tmux fzf universal-ctags gpaste-2 parallel
curl -sS https://starship.rs/install.sh | sh
```

## Configuration

```
echo "source $PWD/bashrc" >> ~/.bashrc
source ~/.bashrc

echo "source $PWD/tmux.conf" >> ~/.tmux.conf

mkdir -p ~/.config/redmine && echo "https://REDMINE_URL" >> ~/.config/redmine/url
```
### Tmux

```
$> git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
$> go install github.com/joshmedeski/sesh/v2@latest
$> mkdir -p ~/.config/sesh && touch ~/.config/sesh/sesh.toml
```

### NVIM

```
echo "vim.cmd('source $PWD/nvim/init.lua')" > ~/.config/nvim/init.lua
```

### SSH

Add tmux on remote execution

```
# ~/.ssh/config
Host remote
Include $DOTFILES_DIR/ssh/config/remote_tmux
```

### television

~~~
curl -fsSL https://alexpasmantier.github.io/television/install.sh | bash
~~~
