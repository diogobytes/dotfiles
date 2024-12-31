
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set vi super mode
set -o vi

# keybinds
bind -x '"\C-l":clear'
# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

export VISUAL=nvim
export EDITOR=nvim

# config
export BROWSER="edge"

# directories
export REPOS="$HOME/Repos"
export GITUSER="diogobytes"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"
export LAB="$GHREPOS/lab"
export SCRIPTS="$DOTFILES/scripts"
export ZETTELKASTEN="$HOME/Zettelkasten"


# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=25000
export HISTCONTROL=ignorespace

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~

clone() {
  local repo="$1" user
  local repo="${repo#https://github.com/}"
  local repo="${repo#git@github.com:}"
  if [[ $repo =~ / ]]; then
    user="${repo%%/*}"
  else
    user="$GITUSER"
    [[ -z "$user" ]] && user="$USER"
  fi
  local name="${repo##*/}"
  local userd="$REPOS/github.com/$user"
  local path="$userd/$name"
  [[ -d "$path" ]] && cd "$path" && return
  mkdir -p "$userd"
  cd "$userd"
  echo gh repo clone "$user/$name" -- --recurse-submodule
  gh repo clone "$user/$name" -- --recurse-submodule
  cd "$name"
} && export -f clone

# ~~~~~~~~~~~~~~~ SSH ~~~~~~~~~~~~~~~~~~~~~~~~
# SSH Script from arch wiki

if ! pgrep -u "$USER" ssh-agent >/dev/null; then
  ssh-agent >"$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
  source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# Only run on Ubuntu

#if [[ $(grep -E "^(ID|NAME)=" /etc/os-release | grep -q "ubuntu")$? == 0 ]]; then
#  eval "$(ssh-agent -s)" >/dev/null
#  eval "$(fzf --bash)"
#fi


# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~

eval "$(starship init bash)"

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias v=nvim

# cd
alias ..="cd .."
alias scripts='cd $SCRIPTS'

# Repos

alias lab='cd $LAB'
alias cks='cd $LAB/kubernetes/cks/'
alias alab='cd $GHREPOS/azure-lab'
alias dot='cd $GHREPOS/dotfiles'
alias repos='cd $REPOS'
alias ghrepos='cd $GHREPOS'
alias cdgo='cd $GHREPOS/go/'
alias rwdot='cd $REPOS/github.com/rwxrob/dot'

alias c="clear"
alias rob='cd $REPOS/github.com/rwxrob'
alias homelab='cd $REPOS/github.com/mischavandenburg/homelab/'
alias hl='homelab'
alias cdq='cd $REPOS/github.com/jackyzha0/quartz'

# ls
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -lathr'

# finds all files recursively and sorts by last modification, ignore hidden files
alias lastmod='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

alias sv='sudoedit'
alias t='tmux'
alias e='exit'
alias syu='sudo pacman -Syu'

# Azure

# git
alias gp='git push -f'
alias gc='git commit -m'
alias gs='git status'
alias lg='lazygit'

# ricing
alias et='v ~/.config/awesome/themes/powerarrow/theme-personal.lua'
alias ett='v ~/.config/awesome/themes/powerarrow-dark/theme-personal.lua'
alias er='v ~/.config/awesome/rc.lua'
alias eb='v ~/.bashrc'
alias ev='cd ~/.config/nvim/ && v init.lua'
alias sbr='source ~/.bashrc'
alias s='startx'

# vim & second brain
alias in="cd \$ZETTELKASTEN/0 Inbox/"
alias zk="cd \$ZETTELKASTEN"


# terraform
alias tf='terraform'
alias tp='terraform plan'


# kubectl
alias k='kubectl'
source <(kubectl completion bash)
complete -o default -F __start_kubectl k
alias kgp='kubectl get pods'
alias kc='kubectx'
alias kn='kubens'

# flux
#source <(flux completion bash)
#alias fgk='flux get kustomizations'

# completions
#source <(talosctl completion bash)
#source <(kubectl-cnp completion bash)
#source <(cilium completion bash)
#source <(devpod completion bash)

# fzf aliases
# use fp to do a fzf search and preview the files
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# search for a file with fzf and open it in vim
alias vf='v $(fp)'


if [[ "$OSTYPE" == "darwin"* ]]; then
  source "$HOME/.fzf.bash"
  # echo "I'm on Mac!"

  # brew bash completion
  [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
else
  #	source /usr/share/fzf/key-bindings.bash
  #	source /usr/share/fzf/completion.bash

  # The first one worked on Ubuntu, the eval one on Fedora. Keeping for reference.
  # [ -f ~/.fzf.bash ] && source ~/.fzf.bash
  eval "$(fzf --bash)"
fi

# Only needed for npm install on WSL
#export NVM_DIR="$HOME/.config/nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
