@echo off
echo Windows setup program
echo (C) UHAsikakutou 2023
if %0=gop2 goto :p2
net session >nul 2>&1
if %ERRORLEVEL% equ 0 (
) else (
  echo 管理者権限で実行していません。管理者権限がない場合一部パッケージのインストールが行えません。
  SET /P selected="管理者権限で続行しますか[U]？強制的に続行しますか[F]？中断して終了しますか[E]？"
  if /i {%selected%}=={u} (goto :upgrade)
  if /i {%selected%}=={f} (goto :startinstall)
  if /i {%selected%}=={e} (goto :no)
  :upgrade
  powershell start-process %~0 -verb runas
)
:startinstall
SET /P selected="必要なパッケージ類のインストールを開始します。　実行にはインターネット接続が必要です。実行しますか[Y/N]？"
if /i {%selected%}=={y} (goto :yes)
if /i {%selected%}=={yes} (goto :yes)
:no
echo ユーザーが処理を中断したため終了します
goto exit
:yes
echo Wingetを使用してパッケージの取得を行います。
winget install -e --id Microsoft.PowerShell
winget install -e --id Microsoft.VisualStudioCode --scope machine
winget install -e --id Git.Git
winget install -e --id GitHub.GitHubDesktop
winget install -e --id GitHub.cli
winget install -e --id OpenJS.NodeJS
winget install -e --id Discord.Discord
winget install -e --id valinet.ExplorerPatcher
winget install -e --id OsirisDevelopment.BatteryBar
winget install -e --id GNU.Nano
echo Winget パッケージの取得が終了しました
SET /P selected="インストールしたソフトを設定するために実行しますか[Y/N]?"
if /i {%selected%}=={y} (goto :re)
if /i {%selected%}=={yes} (goto :re)
if /i {%selected%}=={n} (goto :wsl)
if /i {%selected%}=={no} (goto :wsl)
:re
start %~dp0\main.bat gop2
exit
:p2
start code
start %USERPROFILE%AppData\Local\GitHubDesktop\GitHubDesktop.exe
start gh auth login
start %USERPROFILE%AppData\Local\Discord\discord.exe
:wsl
echo WSL(Ubuntu)のインストールを行います
wsl --install
:exit
exit /b
