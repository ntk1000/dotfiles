
.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST)  | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: ## create bin,pkg,src and deploy all dotfiles
	- [ -d ~/bin] || mkdir -p ~/bin
	- [ -d ~/pkg] || mkdir -p ~/pkg
	- [ -d ~/src] || mkdir -p ~/src
	- [ -d ~/.config] || mkdir -p ~/.config
	- [ -L ~/.vimrc ] || ln -s $(PWD)/vimrc ~/.vimrc
	- [ -L ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc
	- [ -L ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig
	- [ -L ~/.config/hub ] || ln -s $(PWD)/hub ~/.config/hub

clean: ## clean dotfiles
	- [ -L ~/.vimrc ] && rm ~/.vimrc
	- [ -L ~/.zshrc ] && rm ~/.zshrc
	- [ -L ~/.gitconfig ] && rm ~/.gitconfig

brew: ## setup homebrew via Brewfile
	/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew bundle cleanup
	brew bundle

vim: ## install plug.vim
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

shell: ## setup zsh as default shell
	sudo sh -c "grep -q '/usr/local/bin/zsh' /etc/shells || echo '/usr/local/bin/zsh' >> /etc/shells"
	sudo chsh -s /usr/local/bin/zsh junasano

octave: ## setup octave 2018 edition via http://www.schoeps.org/home/2018/01/how-to-compile-gnu-octave-with-openblas-on-macos/
	brew tap dpo/openblas
	brew tap-pin dpo/openblas
	brew install dpo/openblas/octave --devel --with-qt --with-java

defaults: ## setup defaults write
	defaults write com.apple.dock orientation -string "left"
	defaults write com.apple.dock autohide -bool true
	defaults write com.apple.dock tilesize -int 30
	killall Dock
	defaults write com.apple.finder CreateDesktop false
	killall Finder

.PHONY: all
