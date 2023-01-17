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


set "YY=%first:~2,2%" & set "YYYY=%first:~0,4%" & set "MM=%first:~4,2%" & set "DD=%first:~6,2%"
set "HH=%first:~8,2%" & set "Min=%first:~10,2%" & set "Sec=%first:~12,2%"
set /A YYYY_=YYYY
set /A MM_=MM
set /A DD_=DD
set /A HH_=HH
set /A Min_=Min
set /A Sec_=Sec
rem định dạng thời gian đầy đủ (lúc nào cũng 2 số) của Tấn thoái (YYYYMMDDHHmmss)
set "datesFull=%YYYY%%MM%%DD%" & set "timesFull=%HH%%Min%%Sec%"

rem định dạng thời gian chỉ có 1 hoặc 2 số của Unetcall
set "dates=%YYYY_%%MM_%%DD_%" & set "times=%HH_%%Min_%%Sec_%"

Set "_demo=%first%"
echo "CHUỖI THỜI GIAN: "
echo "%first%"
Call :strlen _demo _length

rem YYYYMMDDHHmmss
IF %_length% equ 14 (
  echo ... CÓ ĐỘ DÀI 14 KÝ TỰ, CHUYỂN SANG ĐỊNH DẠNG THỜI GIAN CỦA UNETCALL
  echo "%first%  ===>"
  set "first=%dates%%times%"
) ELSE IF %_length% LSS 14 (
  echo ... CÓ ĐỘ DÀI 14 KÝ TỰ, CÓ LẼ LÀ ĐỊNH DẠNG CỦA UNETCALL RỒI
) ELSE (
  goto :info_invalid_filename
)
echo "%first%"

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

:info_invalid_filename
mode con lines=20 cols=120
cls & echo.& echo.& echo.FILE VỪA CHỌN CÓ CHUỖI THỜI GIAN LỚN HƠN 14 KÝ TỰ (%_length%), DO ĐÓ KHÔNG PHẢI LÀ FILE AUDIO CỦA TẤN THOÁI DỊ GIẢNG THÔNG, VUI LÒNG KIỂM TRA LẠI (LEN=%_length%)
color 3f & echo. & timeout /t 15 >nul

:end
%SystemRoot%\explorer.exe "%USERPROFILE%\Desktop\File đã đổi tên\"

goto:eof
:strlen  StrVar  [RtnVar]
  setlocal EnableDelayedExpansion
  set "s=#!%~1!"
  set "len=0"
  for %%N in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
    if "!s:~%%N,1!" neq "" (
      set /a "len+=%%N"
      set "s=!s:~%%N!"
    )
  )
  endlocal&if "%~2" neq "" (set %~2=%len%) else echo %len%
exit /b
