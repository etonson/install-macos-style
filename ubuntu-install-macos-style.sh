#!/bin/bash
set -e

echo "🔄 更新系統"
sudo apt update && sudo apt upgrade -y

echo "📦 安裝基礎與必要套件"
sudo apt install -y \
  gnome-tweaks \
  gnome-shell-extensions \
  gnome-shell-extension-manager \
  gnome-shell-extension-prefs \
  dconf-editor \
  fonts-firacode \
  curl \
  git \
  unzip \
  plank \
  arc-theme \
  gnome-shell-extension-appindicator \
  gir1.2-appindicator3-0.1 \
  papirus-icon-theme \
  p7zip-full

# 關閉 Ubuntu 預設 Dock
echo "❌ 關閉 Ubuntu Dock"
gnome-extensions disable ubuntu-dock@ubuntu.com || true
gnome-extensions disable dash-to-dock@micxgx.gmail.com || true

echo "✅ 啟用桌面圖示 (DING)"
gnome-extensions enable ding@rastersoft.com || true

echo "✅ 啟用 AppIndicator 托盤"
gnome-extensions enable ubuntu-appindicators@ubuntu.com || true

# 安裝 WhiteSur GTK 主題
echo "📥 安裝 WhiteSur GTK 主題"
if [ ! -d "$HOME/WhiteSur-gtk-theme" ]; then
  git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git "$HOME/WhiteSur-gtk-theme"
  cd "$HOME/WhiteSur-gtk-theme"
  ./install.sh -l -c dark -N mojave
  cd ..
else
  echo "WhiteSur GTK 主題已存在，跳過"
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

# 設定主題與圖示
echo "🔧 設定主題與圖示"
gsettings set org.gnome.desktop.interface gtk-theme "WhiteSur-Dark"
gsettings set org.gnome.shell.extensions.user-theme name "WhiteSur-Dark"
gsettings set org.gnome.desktop.interface icon-theme "WhiteSur"
gsettings set org.gnome.desktop.interface cursor-theme 'WhiteSur-cursors'

# 安裝 ArcMenu 擴充
if ! gnome-extensions list | grep -q arcmenu@arcmenu.com; then
  echo "📥 請透過 Extension Manager 安裝 ArcMenu"
else
  echo "✅ ArcMenu 已安裝"
  gnome-extensions enable arcmenu@arcmenu.com || true
fi

# 自動啟動 Plank Dock
echo "⚙ 設定 Plank Dock 自動啟動"
mkdir -p ~/.config/autostart
cp /usr/share/applications/plank.desktop ~/.config/autostart/

# 設定 Plank Dock 外觀
mkdir -p ~/.config/plank/dock1
cat > ~/.config/plank/dock1/settings <<EOF
[PlankDock Settings]
IconSize=64
Alignment=Center
HideMode=1
IconZoom=1
ZoomPercent=170
EOF

# 安裝 GDM 登入主題（需要 sudo）
echo "✅ WhiteSur GDM 登入主題安裝（需 sudo）"
if [ -d "$HOME/WhiteSur-gtk-theme" ]; then
  sudo "$HOME/WhiteSur-gtk-theme/install-gdm-theme.sh" || echo "⚠️ GDM 主題安裝失敗，請手動執行"
else
  echo "找不到 WhiteSur 主題目錄，無法安裝 GDM 主題"
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
  7z x SFPro.dmg -oSFPro_extract
  7z x SFPro_extract/*.pkg -oSFPro_pkg
  7z x SFPro_pkg/*.pkg -oSFPro_fonts

  find SFPro_fonts -name "*.ttf" -exec cp {} "$FONT_DIR" \;
  fc-cache -f -v
  cd ~
else
  echo "SF Pro 字體已安裝，跳過"
fi

# GNOME 快捷鍵調整
echo "⌨️ GNOME 快捷鍵微調"
gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-group "['<Super>grave']"

echo "⚠️ 登出並在登入畫面選『Ubuntu on Xorg』，才能享受完整 macOS 化效果"
echo "🎉 Ubuntu GNOME macOS 化完成 (含 SF Pro 字體)！"
