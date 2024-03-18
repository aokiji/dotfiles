#!/bin/bash

# Setup fasd
fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

# use fasd with fzf
unalias z 2> /dev/null
z() {
  local dir
    dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)"
    cd "${dir}" || return 1
}

unalias v 2> /dev/null
v() {
  local file
  file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)"
    vim "${file}" || return 1
}
