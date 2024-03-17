export DOTFILES_ROOT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# load bashrc.d configuration
for file in $DOTFILES_ROOT_DIR/bashrc.d/*.bashrc;
do
  source "$file"
done

# add bin scripts in PATH
export PATH="$PATH:$DOTFILES_ROOT_DIR/bin"
