
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
