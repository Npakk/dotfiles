#!/usr/bin/env zsh

# create .hushlogin
touch "${HOME}/.hushlogin"

# Homebrew
ln -sf ~/dotfiles/home/Brewfile ~/Brewfile

# zsh
ln -sf ~/dotfiles/home/.zshenv ~/.zshenv
ln -sf ~/dotfiles/config/zsh/.zshrc ~/.config/zsh/.zshrc

# git
ln -sf ~/dotfiles/home/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/config/git/ignore ~/.config/git/ignore

# github cli
ln -sf ~/dotfiles/config/gh/config.yml ~/.config/gh/config.yml

# karabiner-elements
ln -sf ~/dotfiles/config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
ln -snf ~/dotfiles/config/karabiner/assets ~/.config/karabiner/assets

# iTerm2
ln -sf ~/dotfiles/config/iTerm2/com.googlecode.iterm2.plist ~/.config/iTerm2/com.googlecode.iterm2.plist

# neovim
ln -sf ~/dotfiles/config/nvim/init.lua ~/.config/nvim/init.lua
ln -snf ~/dotfiles/config/nvim/after ~/.config/nvim/after
ln -snf ~/dotfiles/config/nvim/lua ~/.config/nvim/lua
ln -snf ~/dotfiles/config/nvim/snippets ~/.config/nvim/snippets
ln -snf ~/dotfiles/config/nvim/lsp ~/.config/nvim/lsp
ln -snf ~/dotfiles/config/nvim/formatter ~/.config/nvim/formatter
ln -sf ~/dotfiles/config/nvim/.stylua ~/.config/nvim/.stylua

# efm-langserver
ln -sf ~/dotfiles/home/.textlintrc ~/.textlintrc

# rubocop
ln -sf ~/dotfiles/home/.rubocop.yml ~/.rubocop.yml
