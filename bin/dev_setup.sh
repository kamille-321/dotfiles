#!/bin/sh

read -p "start dev setup? (y/N): " yn
case "$yn" in [yY]*) ;; *) echo "abort." ; exit ;; esac

# install homebrew
if (type brew > /dev/null 2>&1) ; then
  echo "======= Install Homebrew ======="
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo "============= End =============="
fi

# install git
if brew list | grep git > /dev/null; then
  echo "======= Install git ======="
  brew install git
  echo "============= End =============="
fi

# dotfiles/.bashrc を読み込みbrew cask でのインストール先を /Applications に変更する
cp .bashrc ~/.bashrc
source ~/.bashrc

f [ -f ~/.bashrc ] ; then
  . ~/.bashrc
fi

echo "======= Install Applications ======="

brew install mas # App StoreのアプリをCLIでダウンロードできるようにする
mas install 497799835  # Xcode
mas install 405399194  # Kindle
mas install 715768417  # Microsoft Remote Desktop (8.0.30030)
mas install 425955336  # Skitch
mas install 485812721  # TweetDeck
mas install 1295203466 # Microsoft Remote Desktop (10.2.13)
mas install 539883307  # LINE
mas install 417375580  # BetterSnapTool

brew cask install google-chrome
brew cask install google-chrome-canary
brew cask install google-japanese-ime
brew cask install firefox
brew cask install homebrew/cask-versions/sequel-pro-nightly # mysql GUI for mojave
brew cask install slack       # slackたん
brew cask install typora      # md editor
brew cask install cmd-eikana  # 英かな使えるかわからん
brew cask install alfred      # lancher
brew cask install hyperswitch # cmd + tab でwindow毎に切り替え
brew cask install appcleaner  # remove applications
brew cask install dropbox     # share files
brew cask install clipy       # extend pdcopy
brew cask install dash        # リファレンス見る
brew cask install iterm2      # CLI
brew cask install karabiner   # customize key mapping
brew cask install evernote    # memo
brew cask install skitch      # edit images
# dockerは brew, brew cask 両方必要
brew install docker
brew cask install docker

echo "============= End =============="

echo "======= Install & setting zsh ======="

brew install zsh
brew install zsh-completions

sudo sh -c "echo /usr/local/bin/zsh >> /etc/shells"
# change login shell
chsh -s /usr/local/bin/zsh

source ~/dotfiles/.zshrc

echo "================ End ================"

echo "======= Setup Neovim ======="

# denite, deopleteが python3を必要とするので先にpythonのセッティングを行う
PYTHON_VERSION=3.7.1
brew install pyenv
pyenv install PYTHON_VERSION
pyenv global PYTHON_VERSION

brew install neovim
# deniteセットアップのためのシェルスクリプトをダウンロード & 実行
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
# For example, we just use `~/.cache/dein` as installation directory
sh ./installer.sh ~/.cache/dein

# set sym link
ln -snfv ${HOME}/dotfiles/.vimrc ${HOME}/.config/nvim/init.vim

# for incremental search by fzf
brew install ripgrep

# make rich vim icons
brew cask install font-hack-nerd-font

echo "============ End ============="
