echo 'eval "$(tv init bash)"' >>~/.bashrc
export TELEVISION_CONFIG=$DOTFILES_ROOT_DIR/television
if [ -n "$TMUX" ]; then
	tmux set-environment -g TELEVISION_CONFIG "$TELEVISION_CONFIG"
fi
