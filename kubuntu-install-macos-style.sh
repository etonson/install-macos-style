#!/bin/bash
set -e

echo "🍎 Kubuntu macOS style setup 開始..."

# 更新系統
sudo apt update && sudo apt upgrade -y

# 基本工具
sudo apt install -y git curl wget gnome-themes-extra unzip

# KDE macOS 主題 (WhiteSur)
THEME_DIR="$HOME/.local/share/plasma/look-and-feel"
ICONS_DIR="$HOME/.local/share/icons"
CURSORS_DIR="$HOME/.local/share/icons"

mkdir -p "$THEME_DIR" "$ICONS_DIR" "$CURSORS_DIR"

echo "🎨 下載 WhiteSur KDE 主題..."
git clone https://github.com/vinceliuice/WhiteSur-kde.git /tmp/WhiteSur-kde
cd /tmp/WhiteSur-kde
./install.sh -d "$THEME_DIR"

echo "🎨 下載 WhiteSur Icons..."
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git /tmp/WhiteSur-icons
cd /tmp/WhiteSur-icons
./install.sh -d "$ICONS_DIR"

echo "🖱️ 下載 macOS cursors..."
git clone https://github.com/ful1e5/apple_cursor.git /tmp/apple_cursor
cd /tmp/apple_cursor
./install.sh -d "$CURSORS_DIR"

# Dock (Latte Dock)
echo "🛠️ 安裝 Latte Dock..."
sudo apt install -y latte-dock

# 字型 (Apple SF Pro)
echo "🔤 安裝 SF Pro Fonts..."
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"
cd /tmp
wget -O SFProFonts.zip https://github.com/sahibjotsaggu/San-Francisco-Pro-Fonts/archive/refs/heads/master.zip
unzip SFProFonts.zip
cp -r San-Francisco-Pro-Fonts-master/* "$FONT_DIR"
fc-cache -fv

# 登出前提醒
echo "✅ 已完成 macOS Style 基本安裝！"
echo "👉 建議步驟："
echo "1. 登出 KDE Plasma。"
echo "2. 進入『系統設定 → 外觀』選擇 WhiteSur 主題 & 圖示。"
echo "3. 在『啟動應用程式』中加入 latte-dock。"
echo "4. 在 Global Menu 啟用頂部選單 (可在小工具安裝)。"

echo "🍏 完成！享受你的 macOS Style Kubuntu 🚀"
