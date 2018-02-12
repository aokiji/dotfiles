#!/bin/bash

HISTSIZE=4096
# ignore duplicate commands, ignore commands starting with a space
HISTCONTROL=erasedups:ignoreboth

# append to the history instead of overwriting (good for multiple connections)
shopt -s histappend
