@echo off
color 0b
chcp 65001
title Đổi tên file mp3
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "dates=%YYYY%%MM%%DD%" & set "times=%HH%%Min%%Sec%"
echo.& echo.Set timed
set found=
for %%F in (
  "C:\audiotomp3\renamefile\*.mp3"
  "C:\audiotomp3\renamefile\*.wav"
) do if exist %%F (set found=1 & goto :start)
if not defined found echo FILE KHONG DUNG & goto :info
ECHO.
:start
ECHO [%date% %time%] Bắt đầu đổi tên file
echo.====================================
set dy=2022
for %%f in (C:\audiotomp3\renamefile\*) do (
  set /p val=<%%f
  echo [Tên file: %%~nxf]
  set extension= %%~nxf
)
for /f "tokens=1,2 delims=_" %%a in ("%extension%") do set "first=%%a" & set "second=%%b"
ECHO.
echo.====================================
ECHO.

IF NOT EXIST "%USERPROFILE%\Desktop\File đã đổi tên" mkdir "%USERPROFILE%\Desktop\File đã đổi tên"
if %first:~0,5% EQU 2022 (
for %%f in ("C:\audiotomp3\renamefile\*") do move %%f "%USERPROFILE%\Desktop\File đã đổi tên\%extension:~0,15%_%extension:~-9%"
ECHO Đã đổi tên file thành công!
)
if %second:~0,4% EQU 2022 (
for %%f in ("C:\audiotomp3\renamefile\*") do move %%f "%USERPROFILE%\Desktop\File đã đổi tên\%second%_%first:~-5%.%extension:~-3%"
ECHO Đã đổi tên file thành công!
)
ECHO.

ECHO [%date% %time%] Kết thúc đổi tên file. Cửa sổ này sẽ đóng sau giây lát.....
:end
TIMEOUT /t 3 >nul
%SystemRoot%\explorer.exe "%USERPROFILE%\Desktop\File đã đổi tên\"
goto :dell
:info
mode con lines=20 cols=120
cls & echo.& echo.& echo.FILE VỪA CHỌN KHÔNG PHẢI LÀ FILE AUDIO, VUI LÒNG QUAY LẠI CHỌN FILE AUDIO (ĐUÔI FILE MP3 hoặc WAV)
color 3f & echo. & timeout /t 15 >nul
:dell
IF EXIST "C:\audiotomp3\renamefile\*mp3" del /f/s/q C:\audiotomp3\renamefile\*