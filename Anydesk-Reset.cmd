@echo off & setlocal enableextensions
title Resetar AnyDesk

:: Verifica se o script está rodando como administrador (checa se a chave existe no registro)
reg query HKEY_USERS\S-1-5-19 >NUL || (
    echo Por favor, execute como administrador.
    pause >NUL
    exit
)

chcp 437 
:: Define o código de página

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
:wait_lic
find "ad.anynet.id=" "%ALLUSERSPROFILE%\AnyDesk\system.conf" >nul 2>&1
if %errorlevel% neq 0 (
    timeout /t 1 >nul
    goto wait_lic
)

:: Restaura os arquivos de configuração
call :stop_any

move /y "%temp%\user.conf" "%APPDATA%\AnyDesk\user.conf" >nul 2>&1
xcopy /c /e /h /r /y /i /k "%temp%\thumbnails" "%APPDATA%\AnyDesk\thumbnails" >nul 2>&1
rd /s /q "%temp%\thumbnails" >nul 2>&1

call :start_any

echo *********
echo Concluído.
echo(
goto :eof


:: ================================
:: START ANYDESK
:: ================================
:start_any
echo Iniciando serviço AnyDesk...

:: Se já estiver rodando, não tenta iniciar de novo
sc query AnyDesk | find "RUNNING" >nul
if %errorlevel%==0 (
    echo Serviço já está em execução.
    goto open_any
)

sc start AnyDesk >nul 2>&1

:: Aguarda até 15 segundos para subir
set count=0
:wait_start
sc query AnyDesk | find "RUNNING" >nul
if %errorlevel%==0 goto open_any

timeout /t 1 >nul
set /a count+=1
if %count% lss 15 goto wait_start

echo Falha ao iniciar serviço.
goto :eof


:open_any
echo Abrindo executável...

set "AnyDesk1=%ProgramFiles(x86)%\AnyDesk\AnyDesk.exe"
set "AnyDesk2=%ProgramFiles%\AnyDesk\AnyDesk.exe"

if exist "%AnyDesk1%" start "" "%AnyDesk1%"
if exist "%AnyDesk2%" start "" "%AnyDesk2%"

exit /b


:: ================================
:: STOP ANYDESK
:: ================================
:stop_any
echo Parando serviço AnyDesk...

:: Se já estiver parado
sc query AnyDesk | find "STOPPED" >nul
if %errorlevel%==0 goto kill_proc

sc stop AnyDesk >nul 2>&1

:: Aguarda até parar
set count=0
:wait_stop
sc query AnyDesk | find "STOPPED" >nul
if %errorlevel%==0 goto kill_proc

timeout /t 1 >nul
set /a count+=1
if %count% lss 15 goto wait_stop

echo Serviço não respondeu corretamente.

:kill_proc
taskkill /f /im "AnyDesk.exe" >nul 2>&1
exit /b
