# load bashrc.d configuration
for file in ~/.bashrc.d/*.bashrc;
do
  source "$file"
done

# Local config
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local
