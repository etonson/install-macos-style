#!/bin/bash

set -e

echo "🔄 更新系統"
sudo apt update && sudo apt upgrade -y

echo "📦 安裝基礎套件"
sudo apt install -y gnome-tweaks gnome-shell-extensions gnome-shell-extension-manager dconf-editor fonts-firacode curl git plank arc-theme gnome-shell-extension-appindicator gir1.2-appindicator3-0.1

echo "❌ 關閉 Ubuntu Dock"
gnome-extensions disable ubuntu-dock@ubuntu.com || true
gnome-extensions disable dash-to-dock@micxgx.gmail.com || true

echo "✅ 啟用桌面圖示 (DING)"
gnome-extensions enable ding@rastersoft.com || true

echo "✅ 啟用 AppIndicator 托盤"
gnome-extensions enable ubuntu-appindicators@ubuntu.com || true

echo "📥 安裝 WhiteSur 主題"
if [ ! -d "$HOME/WhiteSur-gtk-theme" ]; then
  git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git "$HOME/WhiteSur-gtk-theme"
  cd "$HOME/WhiteSur-gtk-theme"
  ./install.sh -l
else
  echo "WhiteSur 主題已存在，跳過"
fi

echo "📥 安裝 WhiteSur Icon 主題"
if [ ! -d "$HOME/WhiteSur-icon-theme" ]; then
  git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git "$HOME/WhiteSur-icon-theme"
  cd "$HOME/WhiteSur-icon-theme"
  ./install.sh
else
  echo "WhiteSur Icon 已存在，跳過"
fi

echo "📥 安裝 ArcMenu"
sudo apt install -y gnome-shell-extension-arcmenu

echo "✅ 啟用 ArcMenu"
gnome-extensions enable arcmenu@arcmenu.com || true

echo "⚙ 設定 Plank Dock 自動啟動"
mkdir -p ~/.config/autostart
cp /usr/share/applications/plank.desktop ~/.config/autostart/

echo "🔧 設定 Plank 參數"
mkdir -p ~/.config/plank/dock1
cat > ~/.config/plank/dock1/settings <<EOF
[PlankDock Settings]
IconSize=64
Alignment=Center
HideMode=1
IconZoom=1
ZoomPercent=170
EOF

echo "✅ WhiteSur GDM 登入主題安裝（需 sudo）"
if [ -d "$HOME/WhiteSur-gtk-theme" ]; then
  sudo "$HOME/WhiteSur-gtk-theme/install-gdm-theme.sh" || echo "GDM 主題安裝失敗，請手動執行"
else
  echo "找不到 WhiteSur 主題目錄，無法安裝 GDM 主題"
fi

echo "🔄 GNOME 快捷鍵微調"
gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-group "['<Super>grave']"

gnome-extensions disable dash-to-dock@micxgx.gmail.com

echo "⚠️ 請登出，並在登入畫面選擇『Ubuntu on Xorg』，才能享受完整 macOS 化效果！"


echo "🎉 安裝完成！"

