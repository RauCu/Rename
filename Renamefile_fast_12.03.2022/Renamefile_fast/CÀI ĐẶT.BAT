@echo off
chcp 65001
title Bắt đầu cài đặt công cụ
ECHO [%date% %time%] starting Install installer script
echo =============================================
IF NOT EXIST C:\audiotomp3 mkdir C:\audiotomp3
IF NOT EXIST C:\audiotomp3\renamefile mkdir C:\audiotomp3\renamefile
IF EXIST .\tool xcopy /y .\tool\* C:\audiotomp3\

echo ==========================================
echo Cài đặt thành công, cửa sổ này sẽ đóng sau giây lát...
echo ==========================================
echo(
ECHO [%date% %time%] finished Install installer script
:IF EXIST %~dp0..\Rename DEL %~dp0..\Rename
TIMEOUT 2