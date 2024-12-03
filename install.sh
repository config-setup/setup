#!/usr/bin/env bash

function clone_or_pull {
  if [ -d $1 ]; then
    pushd $1
    git pull
    popd
  else
    git clone "$2" $1
  fi
}

apt update -y
apt upgrade -y
apt install git software-properties-common python3-pip zsh tmux ninja-build gettext cmake unzip curl build-essential -y
apt autoremove -y

### DO NOT TOUCH ###
# Downloading zshrc
rm $HOME/.zshrc
curl https://raw.githubusercontent.com/Reggles44/conf/refs/heads/main/zshrc -o $HOME/.zshrc
### DO NOT TOUCH ###

# git
git config --global user.name "Reggles"
git config --global user.email "reginaldbeakes@gmail.com"
git config --global credential.helper store
git config --global init.defaultBranch main
git config --global push.autoSetupRemote true

clone_or_pull $HOME/.local/bin/ https://github.com/Reggles44/local-bin.git # .local/bin
clone_or_pull $HOME/.fzf "\-\-depth 1 https://github.com/junegunn/fzf.git" # fzf
clone_or_pull $HOME/.config/tmux https://github.com/Reggles44/tmux.git     # tmux config
clone_or_pull $HOME/.tmux/plugins/tpm https://github.com/tmux-plugins/tpm  # tpm
clone_or_pull $HOME/.nvim https://github.com/neovim/neovim                 # nvim

# zsh and ohmyzsh
if ! command -v omz 2>&1 >/dev/null; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  omz update
fi

# pyenv
if ! command -v pyenv 2>&1 >/dev/null; then
  curl https://pyenv.run | bash
fi

# fzf
~/.fzf/install --all

# starship
if ! command -v starship 2>&1 >/dev/null; then
  curl -sS https://starship.rs/install.sh | sh
else
  starship preset nerd-font-symbols -o $HOME/.config/starship.toml
fi

# nvim
pushd $HOME/.nvim
make CMAKE_BUILD_TYPE=RelWithDebInfo
make install
popd

# node version manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# golang install
GO_VERSION="1.23.3"
ARCH="amd64"
mkdir -p $HOME/go/
curl -o "/tmp/go.tar.gz" -L "https://golang.org/dl/go${GO_VERSION}.linux-${ARCH}.tar.gz"
tar -xf "/tmp/go.tar.gz" -C $HOME/go/
rm -f /tmp/go.gar.gz

# rust install
if ! command -v rustup 2>&1 >/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
else
  rustup update
fi
