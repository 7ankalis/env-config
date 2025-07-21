#!/usr/bin/env bash

set -e

# Colors
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
BOLD="\e[1m"
RESET="\e[0m"

SHELL_RC="~/.bashrc"

# Handle arguments
if [ "$1" == "--uninstall" ]; then
  echo -e "${YELLOW}${BOLD}Uninstall instructions:${RESET}"
  echo "1. Remove fonts: rm ~/.local/share/fonts/*.ttf && fc-cache -fv"
  echo "2. Remove tmux and TPM: sudo apt remove tmux && rm -rf ~/.tmux ~/.tmux.conf"
  echo "3. Remove Neovim: sudo rm -rf /opt/nvim-linux-x86_64 && rm nvim-linux-x86_64.tar.gz"
  echo "4. Remove NVChad config: rm -rf ~/.config/nvim"
  echo "5. Edit ~/.bashrc or ~/.zshrc to remove:"
  echo "   - export PATH line for Neovim"
  echo "   - alias vim=nvim"
  echo -e "${YELLOW}⚠️  Then restart your terminal.${RESET}"
  exit 0
elif [ "$1" == "--shell" ]; then
  if [ "$2" == "zsh" ]; then
    SHELL_RC="~/.zshrc"
  elif [ "$2" == "bash" ]; then
    SHELL_RC="~/.bashrc"
  else
    echo -e "${RED}Unknown shell type: $2. Use 'bash' or 'zsh'.${RESET}"
    exit 1
  fi
fi

print_step() {
  echo -e "${BLUE}${BOLD}➤ $1${RESET}"
}

print_done() {
  echo -e "${GREEN}✔ $1${RESET}"
}

### INSTALL STEPS ###

print_step "Installing fonts"
mkdir -p ~/.local/share/fonts
cp fonts/*.ttf ~/.local/share/fonts
fc-cache -fv
print_done "Fonts installed"

print_step "Installing tmux and TPM"
sudo apt update -qq
sudo apt install -y tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp .tmux.conf ~/.tmux.conf
print_done "tmux, TPM, and .tmux.conf installed"

print_step "Installing Neovim"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> "$SHELL_RC"
print_done "Neovim installed"

print_step "Installing NvChad"
git clone https://github.com/NvChad/starter ~/.config/nvim
echo 'alias vim=nvim' >> "$SHELL_RC"
print_done "NvChad installed"

echo -e "\n${YELLOW}📌 After setup:${RESET}"
echo "- Launch Neovim with: ${BOLD}nvim${RESET}"
echo "- Inside Neovim, run: ${GREEN}:MasonInstallAll${RESET}"
echo "- Optionally remove: ~/.config/nvim/.git"
echo -e "\n${GREEN}✅ All done! Changes saved to ${SHELL_RC}. Restart your terminal.${RESET}"

