#!/bin/bash

alias ll="ls -al"

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'
alias rg='rg --type-add "batch:*.cmd"'
alias kp='kubectl --context=user-dyo-context'
alias ks='kubectl --context=user-dyo-staging-context'
