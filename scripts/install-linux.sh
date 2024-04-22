#!/bin/bash

# Adapted from https://docs.astronvim.com/

set -e

mkdir -p $HOME/Downloads
cd $HOME/Downloads

mkdir -p $HOME/squashfs-root
echo 'export PATH="$HOME/squashfs-root/usr/bin:$PATH"' >> $HOME/.bashrc

mkdir -p $HOME/.local/bin
echo 'export PATH="$HOME/.local/bin:$PATH"' >> $HOME/.bashrc

curl -fsSL https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage -o nvim.appimage
chmod u+x nvim.appimage && ./nvim.appimage --appimage-extract
cp -r squashfs-root/* $HOME/squashfs-root

# NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source /home/default-user/.bashrc

# Node.js
nvm install --lts

# treesitter
cargo install tree-sitter-cli

# ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
sudo dpkg -i ripgrep_13.0.0_amd64.deb

# lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
mv lazygit "$HOME/.local/bin"
