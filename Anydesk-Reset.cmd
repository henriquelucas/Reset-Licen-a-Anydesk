@echo off & setlocal enableextensions
title Resete AnyDesk
reg query HKEY_USERS\S-1-5-19 >NUL || (echo Por favor, execute como administrador.& pause >NUL&exit)
chcp 437
call :stop_any
del /f "%ALLUSERSPROFILE%\AnyDesk\service.conf"
del /f "%APPDATA%\AnyDesk\service.conf"
copy /y "%APPDATA%\AnyDesk\user.conf" "%temp%\"
rd /s /q "%temp%\thumbnails" 2>NUL
xcopy /c /e /h /r /y /i /k "%APPDATA%\AnyDesk\thumbnails" "%temp%\thumbnails"
del /f /a /q "%ALLUSERSPROFILE%\AnyDesk\*"
del /f /a /q "%APPDATA%\AnyDesk\*"
call :start_any
:lic
type "%ALLUSERSPROFILE%\AnyDesk\system.conf" | find "ad.anynet.id=" || goto lic
call :stop_any
move /y "%temp%\user.conf" "%APPDATA%\AnyDesk\user.conf"
xcopy /c /e /h /r /y /i /k "%temp%\thumbnails" "%APPDATA%\AnyDesk\thumbnails" 
rd /s /q "%temp%\thumbnails"
call :start_any
echo *********
echo Reset realizado com sucessso!.
echo(
goto :eof
 
:start_any
sc start AnyDesk
sc start AnyDesk
if %errorlevel% neq 1056 goto start_any
set AnyDesk1=%SystemDrive%\Program Files (x86)\AnyDesk\AnyDesk.exe
set AnyDesk2=%SystemDrive%\Program Files\AnyDesk\AnyDesk.exe
if exist "%AnyDesk1%" start "" "%AnyDesk1%"
if exist "%AnyDesk2%" start "" "%AnyDesk2%"
exit /b
 
:stop_any
sc stop AnyDesk
sc stop AnyDesk
if %errorlevel% neq 1062 goto stop_any
taskkill /f /im "AnyDesk.exe"
exit /b
