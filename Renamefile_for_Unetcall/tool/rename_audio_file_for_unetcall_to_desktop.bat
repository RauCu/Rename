@echo off
color 0b
chcp 65001
title ĐỔI TÊN AUDIO CHO UNETCALL
set filedrive=%~d1
set filepath=%~p1
set filename=%~n1
set fileextension=%~x1

if "%fileextension%" == ".mp3" set found=true
if "%fileextension%" == ".wav" set found=true

if "%found%" == "true" (
  goto :start
)

if not defined found echo FILE KHONG DUNG & goto :info
ECHO.
:start

for /f "tokens=1,2 delims=_" %%a in ("%filename%") do set "first=%%a" & set "second=%%b"
IF NOT EXIST "%USERPROFILE%\Desktop\File đã đổi tên" mkdir "%USERPROFILE%\Desktop\File đã đổi tên"
set newfile=%first%_%second:~-5%_recfile%fileextension%
set newfilepath=%USERPROFILE%\Desktop\File đã đổi tên\%first%_%second:~-5%_recfile%fileextension%
echo.
echo Đổi tên %1
echo.
echo "------->       %newfilepath%"
IF /I NOT %1 == "%newfilepath%" copy %1 "%newfilepath%" && echo. && echo. && echo "------->       Thành công!"
IF /I %1 == "%newfilepath%" echo. && echo. && echo "------->       Thành công!"

goto :end

:info
mode con lines=20 cols=120
cls & echo.& echo.& echo.FILE VỪA CHỌN KHÔNG PHẢI LÀ FILE AUDIO, VUI LÒNG QUAY LẠI CHỌN FILE AUDIO (ĐUÔI FILE MP3 hoặc WAV)
color 3f & echo. & timeout /t 15 >nul

:end
%SystemRoot%\explorer.exe "%USERPROFILE%\Desktop\File đã đổi tên\"
