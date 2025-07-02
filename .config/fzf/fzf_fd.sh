#!/usr/bin/env bash

fzf_fd() {
  fd --type file |
    fzf --prompt 'Files> ' \
        --header 'CTRL-T: Switch between Files/Directories' \
        --bind 'ctrl-t:transform:[[ ! $FZF_PROMPT =~ Files ]] &&
                echo "change-prompt(Files> )+reload(fd --type file)" ||
                echo "change-prompt(Directories> )+reload(fd --type directory)"' \
        --preview '[[ $FZF_PROMPT =~ Files ]] && bat --color=always {} || tree -C {}'
}

fzf_fd2() {
  find * | fzf --prompt 'All> ' \
               --header 'CTRL-D: Directories / CTRL-F: Files' \
               --bind 'ctrl-d:change-prompt(Directories> )+reload(find * -type d)' \
               --bind 'ctrl-f:change-prompt(Files> )+reload(find * -type f)'
}
