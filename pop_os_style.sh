#!/bin/bash
set -e

echo "=== Pop!_OS GTK Theme 一鍵安裝 ==="

echo ">>> 安裝必要工具"
sudo apt update
sudo apt install -y git meson ninja-build sassc libglib2.0-dev \
    inkscape optipng gnome-tweaks gnome-shell-extensions

echo ">>> 移除舊版本主題"
sudo apt remove -y pop-gtk-theme || true
sudo rm -rf /usr/share/themes/Pop*
rm -rf ~/.local/share/themes/Pop*
rm -rf ~/.themes/Pop*

echo ">>> 下載 Pop!_OS GTK Theme 原始碼"
rm -rf /tmp/gtk-theme
git clone https://github.com/pop-os/gtk-theme.git /tmp/gtk-theme
cd /tmp/gtk-theme

echo ">>> 建置與安裝"
meson build --prefix=/usr
cd build
ninja
sudo ninja install

echo ""
echo "🎉 安裝完成！請重新啟動 GNOME Shell (Alt+F2 → r) 或登出再登入。"
echo "打開 'GNOME Tweaks' → 外觀 → 選擇 Pop 主題即可。"

