alias t=tmux
#alias v=nvim
alias k="kitty --config ~/.config/kitty/kitty-notitle.conf"
alias ya=yazi
alias lg=lazygit
alias icat="kitten icat"
alias d="kitten diff"

# ========== Tmux 主题启动别名 ==========
# 默认配置启动（无主题）
alias txd='tmux -f /dev/null'

# ========== Tmux 启动方式 ==========
# 使用 fzf 选择主题，拼接配置后启动
# alias tx='~/.tmux/launch_tmux.sh'
alias tx='~/.config/tmux/launch_tmux.sh'
