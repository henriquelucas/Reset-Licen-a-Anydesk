:start_any
:: Verifica se o serviço existe
sc query AnyDesk >nul 2>&1
if %errorlevel% neq 0 (
    echo Servico AnyDesk nao existe.
    goto start_exe
)

:: Tenta iniciar o serviço
sc start AnyDesk >nul 2>&1
if %errorlevel% neq 1056 (
    :: Se não está "already running", tenta novamente
    timeout /t 2 >nul
    goto start_any
)

:start_exe
:: Tenta iniciar o executável, se existir
set AnyDesk1=%SystemDrive%\Program Files (x86)\AnyDesk\AnyDesk.exe
set AnyDesk2=%SystemDrive%\Program Files\AnyDesk\AnyDesk.exe
if exist "%AnyDesk1%" start "" "%AnyDesk1%"
if exist "%AnyDesk2%" start "" "%AnyDesk2%"

exit /b
