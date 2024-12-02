#!/usr/bin/env bash

apt update
apt upgrade

apt install software-properties-common

# git
apt install git
git config --global user.name "Reggles"
git config --global user.email "reginaldbeakes@gmail.com"
git config --global credential.helper store
git config --global init.defaultBranch main
git config --global push.autoSetupRemote true

# python
apt install python3-pip
if [ ! command -v pyenv 2>&1 > /dev/null ] ; then
  curl https://pyenv.run | bash
fi

# zsh and ohmyzsh
apt install zsh
if [ ! command -v omz 2>&1 > /dev/null ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  omz update
fi

### DO NOT TOUCH ###
# Downloading zshrc 
curl https://raw.githubusercontent.com/Reggles44/conf/refs/heads/main/zshrc -o ~/.zshrc
### DO NOT TOUCH ###

# starship
if [ ! command -v starship 2>&1 > /dev/null ]; then
  curl -sS https://starship.rs/install.sh | sh
else
  starship preset nerd-font-symbols -o ~/.config/starship.toml
fi

function clone_or_pull {
  if [ -d $1 ]; then
    pushd $1
    git pull
    popd
  else
    git clone "$2" $1
    if [ ! -z "$3" ]; then
      eval $3
    fi
  fi
}

# fzf
clone_or_pull ~/.fzf "\-\-depth 1 https://github.com/junegunn/fzf.git" ~/.fzf/install

# tmux
apt install tmux
clone_or_pull ~/.config/tmux https://github.com/Reggles44/tmux.git
clone_or_pull ~/.tmux/plugins/tpm https://github.com/tmux-plugins/tpm

# nvim
apt install ninja-build gettext cmake unzip curl build-essential
NEOVIM_DIR=/tmp/neovim_build/
mktemp -d -p $NEOVIM_DIR
git clone https://github.com/neovim/neovim $NEOVIM_DIR
pushd $NEOVIM_DIR
make CMAKE_BUILD_TYPE=RelWithDebInfo
make install
popd
rm -rf $NEOVIM_DIR

