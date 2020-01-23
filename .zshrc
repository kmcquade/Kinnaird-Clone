# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/kmcquade/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"


##### Plugins #####

plugins=(
  aws
  colored-man-pages
  docker
  gem
  git
  git-flow
  hacker-quotes
  history-substring-search
  jsontools
  kitchen
  npm
  rake
  ruby
  rvm
  sublime
#  terraform
  vagrant
  vault
  zsh-autosuggestions
  zsh-completions
)

##### Themes #####

# Powerlevel9k
# https://github.com/bhilburn/powerlevel9k
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ADD_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%f"
# Visual customisation of the second prompt line
local user_symbol="$"
if [[ $(print -P "%#") =~ "#" ]]; then
    user_symbol = "#"
fi
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%{%B%F{black}%K{yellow}%} $user_symbol%{%b%f%k%F{yellow}%} %{%f%}"
POWERLEVEL9K_PROMPT_ADD_NEWLINE_COUNT=1
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon context ssh dir dir_writable)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time status background_jobs vcs time)

POWERLEVEL9K_TIME_FOREGROUND='black'
POWERLEVEL9K_TIME_BACKGROUND='blue'
POWERLEVEL9K_TIME_FORMAT="%D{\uf017 %H:%M:%S}"
POWERLEVEL9K_DIR_HOME_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_BACKGROUND='black'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='black'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='white'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='black'
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND='black'
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND='magenta'
POWERLEVEL9K_TODO_FOREGROUND='black'
POWERLEVEL9K_TODO_BACKGROUND='blue'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='blue'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='black'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='cyan'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='black'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='magenta'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='black'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='red'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='black'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='green'
#POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='black'
#POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='cyan'
#POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='black'
#POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='green'

POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER="."
POWERLEVEL9K_STATUS_CROSS=true
PROMPT_EOL_MARK=''
ZSH_DISABLE_COMPFIX=true
autoload -U compinit
compinit

##### Path mods #####

source $HOME/.profile.d/

if [ -d $HOME/.profile.d ]; then
  for file in $HOME/.profile.d/*.zsh; do
    source $file
  done
fi


##### Activate it #####

source $ZSH/oh-my-zsh.sh

##### User configuration #####


{ eval "$(ssh-agent -s)" } &>/dev/null

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=/usr/local/bin/aws_completer:$PATH
export PATH=/Users/kmcquade/Library/Python/3.7/bin:$PATH
eval "$(_POLICY_SENTRY_COMPLETE=source_zsh policy_sentry)"

##### Aliases ####


# added by travis gem
[ -f /Users/kmcquade/.travis/travis.sh ] && source /Users/kmcquade/.travis/travis.sh

eval "$(pyenv init -)"

