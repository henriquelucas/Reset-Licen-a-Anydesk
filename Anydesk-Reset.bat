@echo off
@echo Renovando licença de uso AnyDesk
if exist "c:\Program Files (x86)" (set ostype=64) else (set ostype=32)
cls
echo Finalizando processos do anydesk...
for /f "tokens=1,2 delims= " %%A in ('tasklist /FI "IMAGENAME eq Anydesk.exe" /NH') do echo %%A=%%B &tskill %%B>nul
for /f "tokens=1,2 delims= " %%A in ('tasklist /FI "IMAGENAME eq Anydesk.exe" /NH') do echo %%A=%%B &tskill %%B>nul
for /f "tokens=1,2 delims= " %%A in ('tasklist /FI "IMAGENAME eq Anydesk.exe" /NH') do echo %%A=%%B &tskill %%B>nul
cls
echo Resetando o Anydesk
c:
cd\
cd C:\ProgramData\AnyDesk\
if exist system.conf.backup del /f /q system.conf.backup
if exist service.conf.backup del /f /q service.conf.backup
rename system.conf system.conf.backup
rename service.conf service.conf.backup
cd\

if %ostype%==32 (set pdir="C:\Program Files\AnyDesk\") else (set pdir="C:\Program Files (x86)\AnyDesk\")
c:
cd\
cd %pdir%
start Anydesk.exe
