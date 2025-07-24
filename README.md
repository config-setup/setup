# Setup for local env

<!--toc:start-->
- [Setup for local env](#setup-for-local-env)
  - [Ubuntu, Debian](#ubuntu-debian)
  - [Mac](#mac)
<!--toc:end-->

## Ubuntu, Debian

```
sudo apt update
sudo apt install software-properties-common \
  git zsh tmux gawk \
  build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev \
  libncursesw5-dev xz-utils tk-dev libxml2-dev \
  libxmlsec1-dev libffi-dev liblzma-dev
curl -sS https://raw.githubusercontent.com/config-setup/setup/refs/heads/main/setup | bash
```

## Mac

```
brew
update
brew install software-properties-common \
  git zsh tmux gawk \
  build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev \
  libncursesw5-dev xz-utils tk-dev libxml2-dev \
  libxmlsec1-dev libffi-dev liblzma-dev
curl -sS https://raw.githubusercontent.com/config-setup/setup/refs/heads/main/setup | bash
```
