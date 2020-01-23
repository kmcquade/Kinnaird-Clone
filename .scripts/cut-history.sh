#!/usr/bin/env bash
HISTFILE=~/.zsh_history
HISTTIMEFORMAT="";
set -o history
history | sed 's/.[ ]*.[0-9]*.[ ]*//' | uniq
