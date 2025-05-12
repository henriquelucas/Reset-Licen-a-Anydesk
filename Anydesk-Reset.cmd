@echo off & setlocal enableextensions
title Resetar AnyDesk

:: Verifica se o script está rodando como administrador (checa se a chave existe no registro)
reg query HKEY_USERS\S-1-5-19 >NUL || (
    echo Por favor, execute como administrador.
    pause >NUL
    exit
)

chcp 437 :: Define o código de página

call :stop_any

:: Remove arquivos de configuração do AnyDesk
del /f "%ALLUSERSPROFILE%\AnyDesk\service.conf"
del /f "%APPDATA%\AnyDesk\service.conf"

:: Salva o user.conf atual no TEMP
copy /y "%APPDATA%\AnyDesk\user.conf" "%temp%\"

:: Remove miniaturas antigas
rd /s /q "%temp%\thumbnails" 2>NUL

:: Copia as miniaturas atuais para o TEMP
xcopy /c /e /h /r /y /i /k "%APPDATA%\AnyDesk\thumbnails" "%temp%\thumbnails"

:: Remove todos os arquivos da pasta do AnyDesk (tanto do perfil do sistema quanto do usuário)
del /f /a /q "%ALLUSERSPROFILE%\AnyDesk\*"
del /f /a /q "%APPDATA%\AnyDesk\*"

call :start_any

:lic
:: Aguarda até o arquivo system.conf conter a linha "ad.anynet.id="
type "%ALLUSERSPROFILE%\AnyDesk\system.conf" | find "ad.anynet.id=" || goto lic

:: Restaura os arquivos de configuração
call :stop_any
move /y "%temp%\user.conf" "%APPDATA%\AnyDesk\user.conf"
xcopy /c /e /h /r /y /i /k "%temp%\thumbnails" "%APPDATA%\AnyDesk\thumbnails"
rd /s /q "%temp%\thumbnails"

call :start_any

echo *********
echo Concluído.
echo(
goto :eof

:start_any
:: Inicia o serviço AnyDesk
sc start AnyDesk
sc start AnyDesk
if %errorlevel% neq 1056 goto start_any

:: Tenta iniciar o executável, se existir
set AnyDesk1=%SystemDrive%\Program Files (x86)\AnyDesk\AnyDesk.exe
set AnyDesk2=%SystemDrive%\Program Files\AnyDesk\AnyDesk.exe
if exist "%AnyDesk1%" start "" "%AnyDesk1%"
if exist "%AnyDesk2%" start "" "%AnyDesk2%"
exit /b

:stop_any
:: Para o serviço e mata o processo
sc stop AnyDesk
sc stop AnyDesk
if %errorlevel% neq 1062 goto stop_any
taskkill /f /im "AnyDesk.exe"
exit /b
