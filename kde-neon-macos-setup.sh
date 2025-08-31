#!/bin/bash
set -e

echo "🔄 更新系統"
sudo apt update && sudo apt upgrade -y

echo "📦 安裝基礎與必要套件"
sudo apt install -y \
  git \
  curl \
  unzip \
  latte-dock \
  papirus-icon-theme \
  fonts-firacode

# 安裝 WhiteSur KDE 主題
echo "📥 安裝 WhiteSur KDE 主題"
if [ ! -d "$HOME/WhiteSur-kde" ]; then
  git clone https://github.com/vinceliuice/WhiteSur-kde.git "$HOME/WhiteSur-kde"
  cd "$HOME/WhiteSur-kde"
  ./install.sh -c Dark -n mojave
  cd ..
else
  echo "WhiteSur KDE 主題已存在，跳過"
fi

# 安裝 WhiteSur Icon 主題
echo "📥 安裝 WhiteSur Icon 主題"
if [ ! -d "$HOME/WhiteSur-icon-theme" ]; then
  git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git "$HOME/WhiteSur-icon-theme"
  cd "$HOME/WhiteSur-icon-theme"
  ./install.sh
  cd ..
else
  echo "WhiteSur Icon 主題已存在，跳過"
fi

# 設定 Plasma 主題與圖示
echo "🔧 設定 Plasma 主題與圖示"
lookandfeeltool -a "org.kde.breezedark.desktop" || true
plasma-apply-desktoptheme WhiteSur-Dark || true
plasma-apply-cursortheme WhiteSur-cursors || true
plasma-apply-colorscheme WhiteSurDark || true
plasma-apply-icon-theme WhiteSur || true

# 啟動 Latte Dock 並自動開機
echo "⚙ 設定 Latte Dock 自動啟動"
mkdir -p ~/.config/autostart
cp /usr/share/applications/latte-dock.desktop ~/.config/autostart/

# Latte Dock 預設設定
mkdir -p ~/.config/latte
cat > ~/.config/latte/macOS.layout.latte <<EOF
[Layout]
name=macOS
showInMenu=true

[Dock][1]
alignment=Center
iconSize=64
zoomLevel=15
visibility=2
panelPosition=Bottom
EOF

echo "⚙ 套用 Latte Dock 設定"
latte-dock --replace --import ~/.config/latte/macOS.layout.latte &

# 安裝 SDDM 主題
echo "✅ 安裝 WhiteSur SDDM 登入畫面主題"
if [ -d "$HOME/WhiteSur-kde" ]; then
  cd "$HOME/WhiteSur-kde"
  sudo ./install-sddm-theme.sh
  cd ..
else
  echo "找不到 WhiteSur KDE 主題目錄，無法安裝 SDDM 主題"
fi

# 安裝 SF Pro 字體
echo "🔤 安裝 SF Pro 字體"
FONT_DIR="$HOME/.local/share/fonts/SFPro"
if [ ! -d "$FONT_DIR" ]; then
  mkdir -p "$FONT_DIR"
  cd "$FONT_DIR"
  echo "📥 從 Apple 官方下載 SF Pro 字體 (需同意 Apple EULA)"
  curl -L -o SFPro.dmg "https://developer.apple.com/design/downloads/SF-Pro.dmg"
  
  echo "📦 解壓縮 SF Pro.dmg"
  # 需要 7zip 支援
  sudo apt install -y p7zip-full
  7z x SFPro.dmg -oSFPro_extract
  7z x SFPro_extract/*.pkg -oSFPro_pkg
  7z x SFPro_pkg/*.pkg -oSFPro_fonts

  find SFPro_fonts -name "*.ttf" -exec cp {} "$FONT_DIR" \;
  fc-cache -f -v
  cd ~
else
  echo "SF Pro 字體已安裝，跳過"
fi

# 設定字體 (優先使用 SF Pro)
echo "🔧 設定字體"
kwriteconfig5 --file kdeglobals --group General --key font "SF Pro Display,10,-1,5,50,0,0,0,0,0"
kwriteconfig5 --file kdeglobals --group General --key fixed "FiraCode Nerd Font,10,-1,5,50,0,0,0,0,0"

# 快捷鍵設定：KRunner = Super+Space
echo "⌨️ 設定快捷鍵 (KRunner = Super+Space)"
kwriteconfig5 --file kglobalshortcutsrc --group "krunner.desktop" --key "_launch" "Meta+Space,Alt+Space,Run Command"

echo "⚠️ 請登出並重新登入，選擇 WhiteSur SDDM 主題"
echo "🎉 KDE Neon macOS 化完成 (含 SF Pro 字體)！"

