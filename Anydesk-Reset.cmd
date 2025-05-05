@echo off
setlocal enabledelayedexpansion

echo Fechando o AnyDesk...
taskkill /f /im anydesk.exe >nul 2>&1

echo Fazendo backup dos favoritos...
set "anydesk_conf=%APPDATA%\AnyDesk\user.conf"
set "favoritos_backup=%TEMP%\anydesk_favoritos.txt"

if exist "%anydesk_conf%" (
    for /f "delims=" %%a in ('findstr /b "ad.roster.favorites=" "%anydesk_conf%"') do (
        echo %%a > "%favoritos_backup%"
    )
)

echo Removendo configuracoes antigas...
del /f /a /q "%APPDATA%\AnyDesk\*"
rd /s /q "%APPDATA%\AnyDesk"

echo Restaurando arquivos do backup...
mkdir "%APPDATA%\AnyDesk"
copy /y "C:\BackupAnyDesk\*.*" "%APPDATA%\AnyDesk\" >nul

echo Restaurando favoritos...
if exist "%favoritos_backup%" (
    type "%favoritos_backup%" >> "%APPDATA%\AnyDesk\user.conf"
    del /f "%favoritos_backup%"
)

echo Abrindo o AnyDesk...
start "" "%ProgramFiles(x86)%\AnyDesk\AnyDesk.exe"

echo Processo concluído.
endlocal
pause
