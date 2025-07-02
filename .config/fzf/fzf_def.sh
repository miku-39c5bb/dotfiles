#!/usr/bin/env bash

fzfd(){
    fzf --style default \
        --preview 'fzf-preview.sh {}' --bind 'focus:transform-header:file --brief {}'
}

fzff(){
    fzf --style full \
        --preview 'fzf-preview.sh {}' --bind 'focus:transform-header:file --brief {}'
}

fzfm(){
    fzf --style minimal \
        --preview 'fzf-preview.sh {}' --bind 'focus:transform-header:file --brief {}'
}

