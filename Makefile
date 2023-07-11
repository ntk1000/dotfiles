
.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST)  | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: ## create bin,pkg,src and deploy all dotfiles
	- [ -d ~/bin ] || mkdir -p ~/bin
	- [ -d ~/pkg ] || mkdir -p ~/pkg
	- [ -d ~/src ] || mkdir -p ~/src
	- [ -d ~/.config ] || mkdir -p ~/.config
	- [ -L ~/.vimrc ] || ln -s $(PWD)/vimrc ~/.vimrc
	- [ -L ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc
	- [ -L ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig
	- [ -L ~/.config/hub ] || ln -s $(PWD)/hub ~/.config/hub

clean: ## clean dotfiles
	- [ -L ~/.vimrc ] && rm ~/.vimrc
	- [ -L ~/.zshrc ] && rm ~/.zshrc
	- [ -L ~/.gitconfig ] && rm ~/.gitconfig

brew: ## setup homebrew via Brewfile
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew bundle cleanup
	brew bundle

vim: ## install plug.vim
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

shell: ## setup zsh as default shell
	sudo chsh -s /bin/zsh jun.asano

defaults: ## setup defaults write
	defaults write com.apple.dock orientation -string "left"
	defaults write com.apple.dock autohide -bool true
	defaults write com.apple.dock tilesize -int 30
	killall Dock
	defaults write com.apple.finder CreateDesktop false
	killall Finder

.PHONY: all
