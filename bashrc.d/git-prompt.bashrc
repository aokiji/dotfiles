#!/bin/bash

if [ -d ~/.bash-git-prompt ]; then
  GIT_PROMPT_ONLY_IN_REPO=1
  GIT_PROMPT_END="> "
  source ~/.bash-git-prompt/gitprompt.sh
else
  echo "Looks like you don't have bash-git-prompt install"
  echo "If you wish to install it you may do by:"
  echo '  cd ~'
  echo '  git clone https://github.com/magicmonty/bash-git-prompt.git .bash-git-prompt --depth=1'
fi
