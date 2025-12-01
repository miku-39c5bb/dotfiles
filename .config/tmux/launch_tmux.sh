#!/bin/bash

# Tmux 启动脚本 - 选择主题并拼接配置启动
# 将基础配置和主题配置合并后启动 tmux

THEME_DIR="$HOME/.config/tmux/themes"
BASE_CONF="$HOME/.config/tmux/tmux_min.conf"
TARGET_CONF="$HOME/.tmux.conf"

# 主题描述
declare -A THEME_DESC
THEME_DESC[1]="Default - 默认配置（无插件）"
THEME_DESC[2]="Catppuccin Macchiato - 柔和暖色调"
THEME_DESC[3]="Nova - 简洁北欧风格"
THEME_DESC[4]="Catppuccin Mocha - 经典深色主题"
THEME_DESC[5]="Catppuccin Custom - CPU/内存/电池显示"

# 检查基础配置文件
if [ ! -f "$BASE_CONF" ]; then
    echo "错误: 基础配置文件不存在: $BASE_CONF"
    exit 1
fi

# 检查 fzf 是否安装
if ! command -v fzf &> /dev/null; then
    echo "错误: 需要安装 fzf"
    echo "安装命令: sudo apt install fzf  或  brew install fzf"
    exit 1
fi

# 构建 fzf 选项列表
options=""
for i in {1..5}; do
    options+="${i}. ${THEME_DESC[$i]}\n"
done

# 使用 fzf 选择主题
selected=$(echo -e "$options" | fzf \
    --prompt="选择 Tmux 主题: " \
    --height=40% \
    --reverse \
    --border \
    --header="↑↓选择  Enter确认  ESC退出" \
    --preview="echo '=== 主题预览 ===' && cat $THEME_DIR/theme{1}.conf 2>/dev/null | head -30" \
    --preview-window=right:60%:wrap)

# 如果用户取消选择（按了 ESC），退出脚本
if [ -z "$selected" ]; then
    echo "已取消，不启动 tmux"
    exit 0
fi

# 提取主题编号
THEME_NUM=$(echo "$selected" | grep -o '^[0-9]')
THEME_FILE="$THEME_DIR/theme${THEME_NUM}.conf"

# 检查主题文件是否存在
if [ ! -f "$THEME_FILE" ]; then
    echo "错误: 主题文件不存在: $THEME_FILE"
    exit 1
fi

echo "正在生成配置文件..."
echo "  基础配置: $BASE_CONF"
echo "  主题配置: $THEME_FILE"
echo "  目标文件: $TARGET_CONF"

# # 备份现有的 tmux.conf（如果存在且不是符号链接）
# if [ -f "$TARGET_CONF" ] && [ ! -L "$TARGET_CONF" ]; then
#     BACKUP_FILE="${TARGET_CONF}.backup.$(date +%Y%m%d_%H%M%S)"
#     cp "$TARGET_CONF" "$BACKUP_FILE"
#     echo "  已备份原配置到: $BACKUP_FILE"
# fi

# 拼接配置文件：基础配置 + 主题配置
cat > "$TARGET_CONF" << 'HEADER'
# ============================================
# Tmux 配置文件
# 自动生成时间: TIMESTAMP
# 基础配置: BASE_CONF_PATH
# 主题配置: THEME_FILE_PATH (Theme THEME_NUMBER)
# ============================================

HEADER

# 替换占位符
sed -i "s|TIMESTAMP|$(date '+%Y-%m-%d %H:%M:%S')|g" "$TARGET_CONF"
sed -i "s|BASE_CONF_PATH|$BASE_CONF|g" "$TARGET_CONF"
sed -i "s|THEME_FILE_PATH|$THEME_FILE|g" "$TARGET_CONF"
sed -i "s|THEME_NUMBER|$THEME_NUM|g" "$TARGET_CONF"

# 添加基础配置
echo "# ============================================" >> "$TARGET_CONF"
echo "# 基础配置部分" >> "$TARGET_CONF"
echo "# ============================================" >> "$TARGET_CONF"
echo "" >> "$TARGET_CONF"
cat "$BASE_CONF" >> "$TARGET_CONF"

# 添加分隔符
echo "" >> "$TARGET_CONF"
echo "" >> "$TARGET_CONF"
echo "# ============================================" >> "$TARGET_CONF"
echo "# 主题配置部分 - Theme $THEME_NUM" >> "$TARGET_CONF"
echo "# ============================================" >> "$TARGET_CONF"
echo "" >> "$TARGET_CONF"

# 添加主题配置
cat "$THEME_FILE" >> "$TARGET_CONF"

echo "✅ 配置文件已生成"

# 检查是否已经在 tmux 会话中
if [ -n "$TMUX" ]; then
    echo "检测到已在 tmux 会话中，正在重新加载配置..."
    tmux source-file "$TARGET_CONF"
    tmux display-message "配置已重新加载 - Theme $THEME_NUM"
else
    echo "正在启动 tmux (Theme $THEME_NUM)..."
    tmux
fi
