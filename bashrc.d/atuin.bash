. "$HOME/.atuin/bin/env"

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash)"

# bind to ctrl-r, add any other bindings you want here too
bind -x '"\C-r": __atuin_history'
