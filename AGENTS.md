# AGENTS.md

このファイルは、このリポジトリで作業するAIエージェント(Claude Code含む)向けのガイダンスを提供する。

## 概要

CapsLockをF13キーとして扱い、それをショートカットキーとして使うための設定集。Windows専用で、AutoHotkey v2を使う。

- `f13-keybindings.ahk`: 設定本体

## 動作確認

このリポジトリにはビルド・テスト・lintの仕組みはない。AutoHotkeyでスクリプトを再読み込みして手動で確認する。

スクリプトはタスクスケジューラから管理者権限で常駐している(README.mdの「自動起動」を参照)。再読み込みは`schtasks /End /TN f13-keybindings`の後に`schtasks /Run /TN f13-keybindings`で行う。`f13-keybindings.ahk`を直接起動すると、通常権限の新しいインスタンスが古いインスタンスを終了できず、二重に動いてホットキーを取り合うことがある。
