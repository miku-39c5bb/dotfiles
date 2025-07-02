#!/usr/bin/env bash

# https://github.com/Aloxaf/fzf-tab.git
autoload -U compinit; compinit
source ~/.config/fzf/fzf-tab/fzf-tab.plugin.zsh

# https://github.com/junegunn/fzf-git.sh.git
source $HOME/.config/fzf/fzf-git.sh/fzf-git.sh

source $HOME/.config/fzf/fzf_def.sh
source $HOME/.config/fzf/fzf_fd.sh
source $HOME/.config/fzf/fzf_ps.sh
source $HOME/.config/fzf/fzf_rg.sh

