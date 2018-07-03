#!/bin/bash
alias tree='tree -C -I $(git check-ignore * 2>/dev/null | tr "\n" "|").git'
