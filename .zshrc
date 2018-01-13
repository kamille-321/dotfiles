export BROWSER=/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome
source ~/.zplug/init.zsh

# 日本語を使用
export LANG=ja_JP.UTF-8

zplug "wbinglee/zsh-wakatime"

# syntax
zplug "chrissicool/zsh-256color"
zplug "Tarrasch/zsh-colors"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "ascii-soup/zsh-url-highlighter"

# program
zplug "voronkovich/mysql.plugin.zsh"

# tools
zplug "marzocchi/zsh-notify"
zplug "oknowton/zsh-dwim"

# 色を使用出来るようにする
autoload -Uz colors
colors

# 補完
autoload -Uz compinit
compinit
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..

# ビープ音の削除
setopt no_beep

# VCSの情報を取得するzsh関数
autoload -Uz vcs_info
autoload -Uz colors # black red green yellow blue magenta cyan white
colors

# PROMPT変数内で変数参照
setopt prompt_subst

zstyle ':vcs_info:git:*' check-for-changes true    #formats 設定項目で %c,%u が使用可
zstyle ':vcs_info:git:*' stagedstr "%F{cyan}C!"    #commit されていないファイルがある
zstyle ':vcs_info:git:*' unstagedstr "%F{cyan}A+"  #add されていないファイルがある
zstyle ':vcs_info:*' formats "%F{white}%c%u(%b)%f" #通常
zstyle ':vcs_info:*' actionformats '[%b|%a]'       #rebase 途中,merge コンフリクト等 formats 外の表示

# %b ブランチ情報
# %a アクション名(mergeなど)
# %c changes
# %u uncommit

# プロンプト表示直前に vcs_info 呼び出し
precmd () { vcs_info }

# PROMPT
PROMPT='[ %{$fg_bold[blue]%}%T% %{$fg_bold[yellow]%} %n@%m% %{$fg_bold[green]%} %~% %{$reset_color%} ]
%{${fg_bold[green]}%}%} > %{${reset_color}% '
RPROMPT='${vcs_info_msg_0_}'
