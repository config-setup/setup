$!/usr/bin/env bash

function clone_or_pull {
  if [ -d $1 ]; then
    pushd $1
    git pull
    popd
  else
    git clone "$2" $1
  fi
}

apt update
apt upgrade

apt install software-properties-common 

# git
apt install git
git config --global user.name "Reggles"
git config --global user.email "reginaldbeakes@gmail.com"
git config --global credential.helper store
git config --global init.defaultBranch main

# python
apt install python3-pip
curl https://pyenv.run | bash

# zsh and ohmyzsh
apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl https://raw.g -o ~/.zshrc

# fzf
clone_or_pull ~/.fzf "--depth 1 https://github.com/junegunn/fzf.git"
$(~/.fzf/install)

# tmux
apt install tmux
clone_or_pull ~/.config/tmux https://github.com/Reggles44/tmux.git
clone_or_pull ~/.tmux/plugins/tpm https://github.com/tmux-plugins/tpm

# nvim
apt install nvim
clone_or_pull ~/.config/nvim https://github.com/Reggles44/nvim.git

