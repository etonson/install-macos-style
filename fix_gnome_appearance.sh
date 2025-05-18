#!/bin/bash

echo "開始安裝必備套件..."

sudo apt update

sudo apt install -y gnome-tweaks gnome-shell-extensions gnome-shell-extension-prefs

echo "啟用 User Themes 擴充..."

# 啟用 user themes 擴充
gsettings set org.gnome.shell enabled-extensions "['user-theme@gnome-shell-extensions.gcampax.github.com']"

echo "安裝完成！"

echo -e "\n請登出並在登入畫面右下角齒輪選擇「Ubuntu on Xorg」或「GNOME on Xorg」後再登入，這樣 GNOME Tweaks 的外觀分頁才會出現。"

