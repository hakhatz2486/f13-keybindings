# AGENTS.md

このファイルは、このリポジトリで作業するAIエージェント(Claude Code含む)向けのガイダンスを提供する。

## 概要

CapsLockをF13キーとして扱い、それをショートカットキーとして使うための設定集。OSごとに実現方法が異なるため、以下のようにディレクトリ・ファイルを分けて管理している。

- `ahk/f13-keybindings.ahk`: Windows、AutoHotkey v2使用
- `xremap/`: Linux、xremap使用(GNOME Wayland環境前提)
- `xremap/install.sh`: xremap設定ファイルとsystemdサービスファイルを`~/.config`配下に配置し、サービスを有効化・再起動するスクリプト

## xremap設定を編集した場合の適用ルール

`xremap/config.yml`または`xremap/xremap.service`を編集した後は、必ず`./xremap/install.sh`を実行して反映させること。このスクリプトは配置(`cp`)・`daemon-reload`・`restart`までを一括で行う。手動で`~/.config/xremap/config.yml`へコピーしたり、`systemctl --user restart`のみを個別に実行したりしない(配置漏れや再起動漏れで、リポジトリ上の修正が実環境に反映されない不具合を過去に起こしている)。

## xremap設定のキーバインド構造

`xremap/config.yml`は`modmap`(CapsLock→F13変換)と`keymap`(F13との組み合わせ)の2段構成。`virtual_modifiers`にF13を登録することで、F13を通常の修飾キーのように組み合わせて使えるようにしている。

JIS配列特有の癖に注意: 物理`[`キーは`KEY_RIGHTBRACE`、物理`]`キーは`KEY_BACKSLASH`としてxremapに渡ってくるため、`config.yml`内では見た目のキー名と実際の物理キー位置が入れ替わって見える。

日付時刻挿入(`F13-y`/`F13-r`/`F13-t`など)は「`date`コマンドの出力を`wl-copy`でクリップボードへ→`C-v`で貼り付け」という`launch`+`sleep`+ペーストの組み合わせで実装している。`launch`アクションは起動後すぐ次のアクションに進むため、`wl-copy`への反映を待つ`sleep`を挟んでいる点、および`date`出力の末尾改行は`printf '%s'`で除去してから渡している点(除去しないと貼り付け時に改行が入る)は、修正時に崩さないよう注意すること。

AHK側の`{Blind}`(送信時に押下中の修飾キーをそのまま保持する機能)に相当するものがxremapには無い。`exact_match: true`にしているため、バインドで明示していない修飾キーとの組み合わせ(例: Shift+F13-q)は自動では動作せず、必要な組み合わせごとに個別のエントリを追加する必要がある。

## Windows/Linux間の対称性

`ahk/f13-keybindings.ahk`と`xremap/config.yml`は同じキーマッピングを提供するように対称に保たれている。一方のキーバインドを追加・変更する際は、もう一方にも対応する変更が必要か確認すること。

## 動作確認

このリポジトリにはビルド・テスト・lintの仕組みはない。xremap側の動作確認は、`xremap/install.sh`実行後に`systemctl --user status xremap`でサービスが起動しているかを確認する。
