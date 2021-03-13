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
brew cask install clipy       # extend pdcopy
brew cask install dash        # watch docs
brew cask install iterm2
brew cask install karabiner   # customize key mapping
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

echo "====== End ======"

echo "====== Setup ghq ======"
brew install ghq
# ghq default root path
mkdir ~/ghq
echo "====== End ======"

# echo "======= Setup xxx ======="
# echo "======= End ======"
