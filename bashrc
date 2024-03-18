export DOTFILES_ROOT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
export DOTFILES_LOG_FILE=/tmp/dotfile.bash.$$.log

# load bashrc.d configuration
for file in $DOTFILES_ROOT_DIR/bashrc.d/*.bash; do
	local TIMEFORMAT="sourcing $file took %3R" 
        time source "$file" 2>&3
done 3>&2 2>>$DOTFILES_LOG_FILE

# add bin scripts in PATH
export PATH="$PATH:$DOTFILES_ROOT_DIR/bin"
