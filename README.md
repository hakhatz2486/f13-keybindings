# f13-keybindings

CapsLockをF13キーとして扱い、ショートカットキーとして使用するための設定集です。Windows専用で、AutoHotkey v2を使用します。

## セットアップ

- Change KeyもしくはレジストリエディタでCapsLockをF13に置き換える
- AutoHotkeyを導入し、`f13-keybindings.ahk`を実行

## 自動起動

スタートアップフォルダーから起動すると、ログオンしてからスクリプトが起動するまでに時間がかかるため、タスクスケジューラから起動します。

また、タスクスケジューラからは最上位の特権で起動するので、管理者権限で動くウィンドウ上でもショートカットキーを使えます。スタートアップフォルダーから起動すると通常権限で動くため、管理者権限で動くウィンドウではショートカットキーが使えません。

管理者として開いたPowerShellで、リポジトリのディレクトリに移動してから次を実行します。

```powershell
$user = "$env:USERDOMAIN\$env:USERNAME"
$action = New-ScheduledTaskAction -Execute "$env:ProgramFiles\AutoHotkey\v2\AutoHotkey64.exe" -Argument "`"$((Resolve-Path .\f13-keybindings.ahk).Path)`""
$trigger = New-ScheduledTaskTrigger -AtLogOn -User $user
$trigger.Delay = 'PT10S'
$principal = New-ScheduledTaskPrincipal -UserId $user -LogonType Interactive -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet -ExecutionTimeLimit 0 -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -MultipleInstances IgnoreNew
Register-ScheduledTask -TaskName f13-keybindings -Action $action -Trigger $trigger -Principal $principal -Settings $settings
```

- ログオン直後はタスクバーの準備ができておらず、トレイアイコンが表示されないことがあるため、起動を10秒遅らせています
- 常駐させるため、実行時間の上限をなくし、バッテリー駆動でも停止しないようにしています

### 再起動

スクリプトを編集した後は、トレイアイコンの「Reload Script」で再読み込みするか、次のコマンドでタスクを再起動します。

```powershell
schtasks /End /TN f13-keybindings
schtasks /Run /TN f13-keybindings
```

`f13-keybindings.ahk`をダブルクリックして起動し直すと、通常権限で動く新しいインスタンスが管理者権限で動く古いインスタンスを終了できず、「まだ待ちますか？」と表示されます。
