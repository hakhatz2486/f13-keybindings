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
3. `./xremap/install.sh`を実行し、設定ファイルとサービスを配置・有効化
4. `input`グループへユーザーを追加(`sudo usermod -aG input $USER`)し、再ログインまたは再起動

### 注意点

- Windows側でChangeKeyで置き換えていたが`modmap`でF13に変換して扱っている
- F13+ホイールでの音量調整のため、`xremap.service`は`--mouse`オプション付きでマウスデバイスも監視している
- AHKの`{Blind}`(押下中の修飾キーを自動で保持する機能)に相当するものがxremapには無いため、Ctrl・Shiftなどとの組み合わせは`config.yml`内で個別に定義している
