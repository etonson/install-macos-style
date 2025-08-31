# Ubuntu Pro 一鍵 macOS 化腳本

此腳本會把 Ubuntu 打造為近似 macOS 外觀，包括：

- WhiteSur GTK / Icon 主題
- Plank Dock（居中動畫）
- 關閉 Ubuntu Dock（避免雙 Dock）
- 啟用桌面圖示與托盤圖示
- 安裝 ArcMenu（類似 macOS Launchpad）
- Plank 開機啟動與預設設定
- WhiteSur GDM 登入畫面
- GNOME 快捷鍵優化

## 使用方式

1. 下載腳本並執行：

```bash
wget https://your-link/install-macos-pro.sh
chmod +x install-macos-pro.sh
./install-macos-pro.sh
```

2. 完成後請「登出」並在登入畫面選擇 **Ubuntu on Xorg**。

---
# KDE Neon macOS 化自動設定腳本

建議用於 Ubuntu 22.04 / 24.04，效果最佳。

KDE Neon macOS 化自動設定腳本

這份文件詳細說明了一個 Shell 腳本的功能，該腳本能自動將 KDE Neon 桌面環境的視覺風格轉換為類似 macOS 的外觀。
腳本總覽

此腳本會自動化執行以下任務：
 * 更新系統：確保所有套件都是最新版本。
 * 安裝必要套件：安裝美化所需的主題、圖示、字型與工具。
 * 安裝與設定主題：下載並套用 WhiteSur 系列的 KDE 佈景主題、圖示與游標。
 * 設定 Latte Dock：安裝並設定一個類似 macOS Dock 的應用程式啟動器。
 * 安裝登入畫面：套用 WhiteSur SDDM 主題，美化登入介面。
 * 安裝字體：下載並安裝 Apple 的官方字體 SF Pro。
 * 設定系統字體與快捷鍵：將系統預設字體更換為 SF Pro，並修改 KRunner 快捷鍵。
    
---
## 安裝方法

下載專案：
```bash
git clone https://github.com/your-repo/kde-macos-setup.git
cd kde-macos-setup
```

執行腳本：
```bash
chmod +x kde-macos-setup-full.sh
./kde-macos-setup-full.sh
```

---

腳本詳細步驟
## 1. 更新系統

首先，腳本會更新系統的套件列表並升級所有已安裝的套件，確保系統環境為最新狀態。

## 2. 安裝基礎與必要套件

接著，安裝後續步驟會用到的核心工具與美化資源。
 * git: 用於從 GitHub 下載主題。
 * curl: 用於下載檔案 (例如字體)。
 * unzip: 用於解壓縮檔案。
 * latte-dock: macOS 風格的 Dock 工具。
 * papirus-icon-theme: 一套廣受歡迎的圖示主題。
 * fonts-firacode: 一款適合用於程式設計的等寬字體。



## 3. 安裝 WhiteSur KDE 主題

從 GitHub 下載 WhiteSur-kde 專案，並執行其安裝腳本來安裝深色 (Dark) 版本的 macOS Mojave 風格主題。腳本會檢查主題是否已存在，避免重複下載。


## 4. 安裝 WhiteSur Icon 主題
同樣地，從 GitHub 下載 `WhiteSur-icon-theme` 專案並執行安裝腳本。

## 5. 設定 Plasma 主題與圖示
使用 KDE Plasma 的命令列工具來套用剛剛安裝好的主題、游標、色彩配置與圖示。

 

## 6. 設定 Latte Dock 自動啟動與版面
自動啟動：將 Latte Dock 的 .desktop 檔案複製到自動啟動目錄，使其在登入時自動執行。
預設設定：建立一個名為 macOS.layout.latte 的版面設定檔，定義 Dock 的外觀（置中、圖示大小等）。
套用設定：啟動 Latte Dock 並載入此設定檔。
  

## 7. 安裝 WhiteSur SDDM 登入畫面主題

執行 WhiteSur-kde 專案中附帶的腳本來安裝 SDDM (登入管理器) 的主題。

## 8. 安裝 SF Pro 字體

這是讓介面更像 macOS 的關鍵步驟。

從 Apple 官方開發者網站下載 SF Pro 字體包 (.dmg 檔案)。
使用 p7zip-full 工具解壓縮 .dmg 與內部的 .pkg 檔案。
將所有 .ttf 字體檔案複製到使用者的字體目錄 (~/.local/share/fonts)。
更新系統的字體快取。

注意：下載此字體代表您同意 Apple 的 EULA (終端使用者授權合約)。


## 9. 設定字體

使用 kwriteconfig5 命令將系統的預設介面字體設定為 SF Pro Display，並將等寬字體設定為 FiraCode 

## 10. 快捷鍵設定

將 KRunner (應用程式啟動器) 的快捷鍵設定為 Super + Space，這與 macOS 的 Spotlight 快捷鍵一致。
 

## 11. 完成

最後，腳本會提示使用者需要登出後重新登入，以讓所有設定（特別是 SDDM 主題與字體）完全生效。