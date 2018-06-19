# ////////////
# ALIAS
# ////////////

# shortcut
alias dc='docker-compose'
alias tf='terraform'
alias g='git'
alias tigs="tig status"
alias vi='vim'
alias sed='gsed'
alias findervisible='defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder;'
alias finderunvisible='defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder;'
alias ch='curl -D - -s -o /dev/null'

# default options
alias rm='rm -i'
alias ls='ls -GpF' # Mac OSX specific
alias ll='ls -alGpF' # Mac OSX specific
#alias hc='hub compare'
#alias -s go='go run'
#alias hs='hugo server'

# ////////////
# EXPORT
# ////////////

export LANG=ja_JP.UTF-8
export EDITOR="vim"
export GOPATH=$HOME
export PATH="/usr/loca/bin:$PATH:$GOPATH/bin"

export LSCOLORS=cxBxhxDxfxhxhxhxhxcxcx
export CLICOLOR=1

## support colors in less
#export LESS_TERMCAP_mb=$'\E[01;31m'
#export LESS_TERMCAP_md=$'\E[01;31m'
#export LESS_TERMCAP_me=$'\E[0m'
#export LESS_TERMCAP_se=$'\E[0m'
#export LESS_TERMCAP_so=$'\E[01;44;33m'
#export LESS_TERMCAP_ue=$'\E[0m'
#export LESS_TERMCAP_us=$'\E[01;32m'

# ////////////
# HISTORY
# ////////////

if [ -z "$HISTFILE" ]; then
    HISTFILE=$HOME/.zsh_history
fi

HISTSIZE=1000000
SAVEHIST=1000000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups 
setopt hist_ignore_dups 
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history 

# ////////////
# PROMPT
# ////////////

# no beep
setopt nolistbeep

# old style
#autoload -U colors && colors
#autoload -U promptinit; promptinit
# install via 'npm install --global pure-prompt'
#PURE_PROMPT_SYMBOL=λ
#prompt pure

# fatih style
autoload -U colors && colors
setopt promptsubst

local ret_status="%(?:%{$fg_bold[green]%}λ :%{$fg_bold[green]%}$)"
PROMPT='${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

# Outputs current branch info in prompt format
function git_prompt_info() {
  local ref
  if [[ "$(command git config --get customzsh.hide-status 2>/dev/null)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

# Checks if working tree is dirty
function parse_git_dirty() {
  local STATUS=''
  local FLAGS
  FLAGS=('--porcelain')

  if [[ "$(command git config --get customzsh.hide-dirty)" != "1" ]]; then
    FLAGS+='--ignore-submodules=dirty'
    STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
  fi

  if [[ -n $STATUS ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

# ////////////
# AUTOCOMPLETION
# ////////////

fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

# enable completion
autoload -U compinit
compinit -u

# ////////////
# KEY BINDINGS
# ////////////

# vi like keybind
bindkey -v

# [Ctrl-r] - Search backward incrementally for a specified string. The string
# may begin with ^ to anchor the search to the beginning of the line.
bindkey '^r' history-incremental-search-backward      

# ////////////
# THIRD PARTY
# ////////////

# brew install jump via https://github.com/gsamokovarov/jump
eval "$(jump shell)"

# brew install direnv via https://github.com/direnv/direnv
eval "$(direnv hook zsh)"

# brew install goenv via 
export PATH="$HOME/.goenv/bin:$PATH"
eval "$(goenv init -)"


##    AUTOCOMPLETION
#
#zmodload -i zsh/complist
#
#WORDCHARS=''
#
#unsetopt menu_complete   # do not autoselect the first completion entry
#unsetopt flowcontrol
#setopt auto_menu         # show completion menu on successive tab press
#setopt complete_in_word
#setopt always_to_end
#
## autocompletion with an arrow-key driven interface
#zstyle ':completion:*:*:*:*:*' menu select
#
#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
#zstyle ':completion:*' list-colors ''
#zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
#
#zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
#
## Don't complete uninteresting users
#zstyle ':completion:*:*:*:users' ignored-patterns \
#        adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
#        clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
#        gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
#        ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
#        named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
#        operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
#        rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
#        usbmux uucp vcsa wwwrun xfs '_*'
#
#zstyle '*' single-ignored show
#
## Automatically update PATH entries
#zstyle ':completion:*' rehash true
#
## Keep directories and files separated
#zstyle ':completion:*' list-dirs-first true

## ===================
##    KEY BINDINGS
## ===================
## Use emacs-like key bindings by default:
#bindkey -e
#
## [Ctrl-r] - Search backward incrementally for a specified string. The string
## may begin with ^ to anchor the search to the beginning of the line.
#bindkey '^r' history-incremental-search-backward      
#
#if [[ "${terminfo[kpp]}" != "" ]]; then
#  bindkey "${terminfo[kpp]}" up-line-or-history       # [PageUp] - Up a line of history
#fi
#
#if [[ "${terminfo[knp]}" != "" ]]; then
#  bindkey "${terminfo[knp]}" down-line-or-history     # [PageDown] - Down a line of history
#fi
#
#if [[ "${terminfo[khome]}" != "" ]]; then
#  bindkey "${terminfo[khome]}" beginning-of-line      # [Home] - Go to beginning of line
#fi
#
#if [[ "${terminfo[kend]}" != "" ]]; then
#  bindkey "${terminfo[kend]}"  end-of-line            # [End] - Go to end of line
#fi
#if [[ "${terminfo[kcbt]}" != "" ]]; then
#  bindkey "${terminfo[kcbt]}" reverse-menu-complete   # [Shift-Tab] - move through the completion menu backwards
#fi
#
#bindkey '^?' backward-delete-char                     # [Backspace] - delete backward
#if [[ "${terminfo[kdch1]}" != "" ]]; then
#  bindkey "${terminfo[kdch1]}" delete-char            # [Delete] - delete forward
#else
#  bindkey "^[[3~" delete-char
#  bindkey "^[3;5~" delete-char
#  bindkey "\e[3~" delete-char
#fi

## ===================
##    MISC SETTINGS
## ===================
#
## automatically remove duplicates from these arrays
#typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH

## ===================
##    PLUGINS
## ===================
#
## brew install zsh-syntax-highlighting
#source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#
## brew install zsh-autosuggestions
#source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh


