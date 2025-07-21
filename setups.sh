#!/usr/bin/bash

echo "Setting up fonts"
mkdir -p ~/.local/share/fonts 
cp fonts/*.ttf ~/.local/share/fonts 
fc-cache -fv  
echo "Installed enough fonts for you to choose"

echo "Installing tmux"
sudo apt install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf
echo "Tmux and TPM installed successfully"

echo "Setting up nvim"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
echo "export PATH="$PATH:/opt/nvim-linux-x86_64/bin" >> ~/.bashrc
echo "Nvim installed succesfully"

echo "Setting up NVchad"
echo "Once you\'re inside nvim, run \`:MasonInstallAll\` and then delete the .git folder within the nvim folder"
git clone https://github.com/NvChad/starter ~/.config/nvim
echo "alias vim=nvim" >> ~/.bashrc
