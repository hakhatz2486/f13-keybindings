# f13-keybindings

CapsLockをF13キーをショートカットキーとして使用するための設定集です。OSごとに実現方法が異なるため、ディレクトリを分けて管理しています。

- `f13-keybindings.ahk`: Windows, AutoHotkey v2使用
- `xremap/`: Linux、xremap使用

## Windows

- ChangeKeyもしくはレジストリエディタでCapsLockをF13に置き換える
- AutoHotkeyを導入し、`f13-keybindings.ahk`を実行

## Linux (xremap)

GNOME Wayland環境を前提としています。

### セットアップ

1. xremap本体(gnome版)とGNOME拡張機能(`xremap@k0kubun.com`)を導入
2. 日付時刻挿入機能のため`wl-clipboard`を導入(`sudo apt install wl-clipboard`)
3. `xremap/config.yml`を`~/.config/xremap/config.yml`に配置
4. `xremap/xremap.service`を`~/.config/systemd/user/xremap.service` に配置し、`systemctl --user enable --now xremap.service`
5. `input`グループへユーザーを追加(`sudo usermod -aG input $USER`)し、再ログインまたは再起動

### 注意点

- Windows側でChangeKeyで置き換えていたが`modmap`でF13に変換して扱っている
