#!/bin/bash
# xremapの設定ファイルとsystemdサービスファイルを~/.config配下に配置し、サービスを有効化する。
# xremap本体・GNOME拡張機能・wl-clipboardの導入、inputグループへのユーザー追加は
# 対話的な操作やsudo権限を要するため対象外。README.mdの手順に従って別途行うこと。
set -eu

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
CONFIG_DIR="$HOME/.config/xremap"
SERVICE_DIR="$HOME/.config/systemd/user"

mkdir -p "$CONFIG_DIR" "$SERVICE_DIR"
cp "$SCRIPT_DIR/xremap/config.yml" "$CONFIG_DIR/config.yml"
cp "$SCRIPT_DIR/xremap/xremap.service" "$SERVICE_DIR/xremap.service"

systemctl --user daemon-reload
systemctl --user enable xremap.service
# enable --nowは起動中の場合は再起動しないため、設定変更を確実に反映するためrestartを使う
systemctl --user restart xremap.service

echo "配置完了: $CONFIG_DIR/config.yml"
echo "配置完了: $SERVICE_DIR/xremap.service"
