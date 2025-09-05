#!/bin/bash

alias ll="ls -al"

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'
alias rg='rg --type-add "batch:*.cmd"'
alias kp='kubectl --context=oidc-production-context'
alias ks='kubectl --context=oidc-staging-context'
