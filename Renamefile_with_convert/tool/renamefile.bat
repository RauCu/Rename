@echo off
color 0b
chcp 65001
title Đổi tên file mp3
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "dates=%YYYY%%MM%%DD%" & set "times=%HH%%Min%%Sec%"
:start
ECHO [%date% %time%] Bắt đầu đổi tên file
echo.====================================
echo.Nhập 5 số cuối điện thoại
set /p sdt=5 số cuối đuôi:
echo.====================================
For /F %%A In ('Dir "C:\audiotomp3\renamefile\*" /B /A-D ^| Find /C /V ""') Do Set FLCN=%%A
dir /b "C:\audiotomp3\renamefile\*" | findstr "^" >nul && (echo ☑ Có %FLCN% file đã thêm ) || (echo Không có file trong thư mục)
for %%f in (C:\audiotomp3\renamefile\*) do (
  set /p val=<%%f
  echo [Tên file: %%~nxf]
)
echo.====================================
IF NOT EXIST "%USERPROFILE%\Desktop\File đã đổi tên" mkdir "%USERPROFILE%\Desktop\File đã đổi tên"
For /F %%A In ('Dir "C:\audiotomp3\renamefile\*" /B /A-D ^| Find /C /V ""') Do Set FilCnt=%%A
Set Lst=
For %%A In ("C:\audiotomp3\renamefile\*") Do Call Set Lst=%%Lst%% -i "%%A"
:converter
ffmpeg %Lst% -filter_complex concat=n=%FilCnt%:v=0:a=1 -b:a 128K -vn -acodec libmp3lame "%USERPROFILE%\Desktop\File đã đổi tên\%dates%%times%_%sdt%_recfile.mp3"
echo %YYYY%/%MM%/%DD%-%HH%:%Min%:%Sec%_%sdt%_recfile.mp3 >> "%USERPROFILE%\Desktop\File đã đổi tên\Lich-su-file-[%DD%-%MM%].txt"
%SystemRoot%\explorer.exe "%USERPROFILE%\Desktop\File đã đổi tên\"
:dell
ECHO [%date% %time%] Kết thúc đổi tên file...
IF EXIST "C:\audiotomp3\renamefile\*mp3" del /f/s/q C:\audiotomp3\renamefile\*
:end
TIMEOUT 2
