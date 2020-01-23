#!/usr/bin/env bash
set -e

# source: ethanj's script under https://github.com/pypa/pipenv/wiki/Run-pipenv-shell-automatically#zsh
# automatically run "pipenv shell" if we enter a pipenv project subdirectory
# if opening a new terminal, preserve the source directory
PROMPT_COMMAND='prompt'
precmd() { eval "$PROMPT_COMMAND" }
function prompt()
{
    if [ ! $PIPENV_ACTIVE ]; then
      if [ `pipenv --venv 2>/dev/null` ]; then
        export PIPENV_INITPWD="$PWD"
        pipenv shell
      fi
    elif [ $PIPENV_INITPWD ] ; then
      cd "$PIPENV_INITPWD"
      unset PIPENV_INITPWD
    fi
}
