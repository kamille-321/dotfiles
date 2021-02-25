#!/bin/sh

read -p "start dev setup? (y/N): " yn
case "$yn" in
  [yY]*)
    ;;
  *)
    echo "abort." ; exit
    ;;
esac

# install homebrew
if (type brew > /dev/null 2>&1) ; then
  echo "======= Install Homebrew ======="

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

  echo "======= End ======"
fi

# install git
if brew list | grep git > /dev/null; then
  echo "====== Install git ======="

  brew install git

  echo "====== End ======"
fi

echo "====== Setup git ======"

ln -snfv ${HOME}/dotfiles/git_setting/gitconfig ${HOME}/.gitconfig
ln -snfv ${HOME}/dotfiles/git_setting/gitignore_global ${HOME}/.gitignore_global

echo "======= End ======"


echo "====== Install Applications ======"

brew install mas # App StoreのアプリをCLIでダウンロードできるようにする
mas install 497799835  # Xcode
mas install 405399194  # Kindle
mas install 425955336  # Skitch
mas install 485812721  # TweetDeck
mas install 1295203466 # Microsoft Remote Desktop
mas install 539883307  # LINE
mas install 417375580  # BetterSnapTool
mas install 1429033973 # RunCat

# TODO: /Applications 配下にあるならインストールしない、ないならインストールするみたいにしたい
# dotfiles/.bashrc を読み込みbrew cask でのインストール先を /Applications に変更する
cp .bashrc ~/.bashrc
source ~/.bashrc

# f [ -f ~/.bashrc ] ; then
#   . ~/.bashrc
# fi

brew cask install google-chrome
brew cask install google-chrome-canary
brew cask install google-japanese-ime
brew cask install visual-studio-code
brew cask install skype
brew cask install zoom
brew cask install homebrew/cask-versions/sequel-pro-nightly # mysql GUI for mojave
brew cask install keyboardcleantool # disable keyboard when clean up it
brew cask install slack
brew cask install typora
brew cask install cmd-eikana
brew cask install alfred
brew cask install hyperswitch
brew cask install appcleaner
brew cask install dropbox
brew cask install clipy       # extend pdcopy
brew cask install dash        # watch docs
brew cask install iterm2
brew cask install karabiner   # customize key mapping
brew cask install evernote
brew cask install skitch      # edit images
brew cask install postman
brew cask install notion
# dockerは brew, brew cask 両方必要
brew install docker
brew cask install docker

echo "====== End ======"


echo "====== Setup zsh ======"

brew install zsh
brew install zsh-completions
brew install zplug

sudo sh -c "echo /usr/local/bin/zsh >> /etc/shells"
# change login shell
chsh -s /usr/local/bin/zsh

ln -snfv ${HOME}/dotfiles/.zshrc ${HOME}/.zshrc

source ${HOME}/.zshrc

echo "====== End ======"

echo "====== Setup tmux ======"

brew install tmux
brew install reattach-to-user-namespace

ln -snfv ${HOME}/dotfiles/.tmux.conf ${HOME}/.tmux.conf

tmux source ${HOME}/.tmux.conf

echo "====== End ======"

echo "====== Setup karabiner ======"

ln -snfv ${HOME}/dotfiles/karabiner ${HOME}/.config/karabiner

echo "====== End ======"

echo "====== Setup CLI ======"

brew install peco
brew install htop
brew install tig
brew install trash
brew install tree
brew install gnu-sed
brew install the_silver_searcher
brew install github/gh/gh
brew install jid
brew install kustomize
# provide kubectx & kubens
brew install kubectx

echo "To install `kubectl krew`, check the url"
echo "https://krew.sigs.k8s.io/docs/user-guide/setup/install/"

echo "====== End ======"


echo "====== Setup ghq ======"
brew install ghq
# ghq default root path
mkdir ~/ghq
echo "====== End ======"

echo "====== Setup Neovim ======"
# denite, deopleteが python3を必要とするので先にpythonのセッティングを行う
brew install pyenv
pyenv install 3.7.1
pyenv global 3.7.1
pip3 install pynvim # required https://github.com/roxma/nvim-yarp#requirements

brew install neovim
# deniteセットアップのためのシェルスクリプトをダウンロード & 実行
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
# For example, we just use `~/.cache/dein` as installation directory
sh ./installer.sh ~/.cache/dein

# set sym link
mkdir -p ~/.config/nvim
ln -snfv ${HOME}/dotfiles/.vimrc ${HOME}/.config/nvim/init.vim

# for incremental search by fzf
brew install ripgrep

# make rich vim icons
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font

# monaco powerline
wget https://gist.github.com/baopham/1838072/raw/2c0e00770826e651d1e355962e751325edb0f1ee/Monaco%20for%20Powerline.otf
mv Monaco\ for\ Powerline.otf /Library/Fonts/
echo "====== End ======"


echo "====== Setup Ruby ======"
brew install rbenv ruby-build

brew install readline
brew link readline --force
RUBY_CONFIGURE_OPTS="--with-readline-dir=$(brew --prefix readline)"
echo 'export PATH="$HOME/.rbenv/bin/:$PATH" >> ~/.zshrc'
echo 'eval "$(rbenv init -)" >> ~/.zshrc'

# neovimが ruby2.7.1 と neovim gem を参照するので入れておく
# 2.7.1が古くなったらvimrcに書いてあるneovimが参照するバージョンを変更すること
rbenv install 2.7.1
rbenv global 2.7.1
gem install neovim

# 最新版をインストールする
LATEST_STABLE_RUBY = $(rbenv install -l | grep -v - | tail -1)
rbenv install LATEST_STABLE_RUBY
rbenv global LATEST_STABLE_RUBY
gem install bundler
rbenv rehash

ln -snfv ${HOME}/dotfiles/.pryrc ${HOME}/.pryrc
echo "====== End ======"


echo "====== Setup golang ======"
git clone https://github.com/syndbg/goenv.git ~/.goenv
# 最新版のgoをインストールする
LATEST_STABLE_GO = $(goenv install -l | grep -E "([1].[0-9].[0-9])|([1].[0-9][0-9].[0-9])" | tail -1)
goenv install LATEST_STABLE_GO
goenv global LATEST_STABLE_GO
echo "====== End ======"

echo "====== Setup nodejs ======"
brew install nvm
mkdir ${HOME}/.nvm

nvm install v10.13.0
node -v
nvm use 10.13.0

brew install nodenv
curl -fsSL https://github.com/nodenv/nodenv-installer/raw/master/bin/nodenv-doctor | bash

# make available git open command
npm install --global git-open
echo "====== End ======"

echo "====== Setup vue ======"
brew install yarn

yarn global add @vue/cli
yarn global add @vue/cli-init
echo "====== End ======="

echo "====== Setup terraform ======"
brew install tfenv
echo "====== End ======="

# echo "======= Setup xxx ======="
# echo "======= End ======"
