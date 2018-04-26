
.PHONY: all
.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST)  | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: ## deploy all dotfiles
	[ -d ~/bin] || mkdir -p ~/bin
	[ -d ~/pkg] || mkdir -p ~/pkg
	[ -d ~/src] || mkdir -p ~/src
	[ -f ~/.vimrc ] || ln -s $(PWD)/vimrc ~/.vimrc
	[ -f ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig

clean: ## clean dotfiles
	[ -f ~/.vimrc ] || rm ~/.vimrc
	[ -f ~/.zshrc ] || rm ~/.zshrc
	[ -f ~/.gitconfig ] || rm ~/.gitconfig

brew: ## setup homebrew
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew bundle cleanup
	brew bundle check
	brew bundle

shell: ## setup zsh
	sudo sh -c "grep -q '/usr/local/bin/zsh' /etc/shells || echo '/usr/local/bin/zsh' >> /etc/shells"
	sudo chsh -s /usr/local/bin/zsh

defaluts: ## setup defaults write
	defaults write com.apple.dock orientation -string "left"
	defaults write com.apple.dock autohide -bool true
	defaults write com.apple.dock tilesize -int 30
	killall Dock

vim: ## setup vim
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
