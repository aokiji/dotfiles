export DOTFILES_ROOT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# load bashrc.d configuration
for file in $DOTFILES_ROOT_DIR/bashrc.d/*.bash; do
    if [[ "$__DOTFILES_BASHRC_PERF" ]]; then
        TIMEFORMAT="sourcing $file took %3R" 
        time source "$file"
        unset TIMEFORMAT
    else
        source "$file"
    fi
done

# add bin scripts in PATH
export PATH="$PATH:$DOTFILES_ROOT_DIR/bin"
