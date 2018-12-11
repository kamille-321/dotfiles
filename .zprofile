# コマンド履歴
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history    # share command history data

# alias
alias py="python"
alias ipy="ipython"
alias es="elasticsearch"
alias be="bundle exec"
alias rm="trash"
alias agg="ag -g"
alias ls="ls -G"
alias ctags="`brew --prefix`/bin/ctags"

## Set path for pyenv
export PYENV_ROOT="${HOME}/.pyenv"
export PATH=${PYENV_ROOT}/bin:$PATH
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
