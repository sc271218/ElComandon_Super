@echo off
title EL COMANDON: SUPER CLEAN EDITION
color 0C
echo ==============================
echo     EL COMANDON SUPER MODE
echo ==============================
echo Pulizia avanzata in corso...
echo.

:: DISATTIVA FILE DI IBERNAZIONE (libera molti GB)
echo Disattivazione file di ibernazione...
powercfg -h off

:: CHIUDE PROCESSI BLOCCANTI
echo Chiudendo processi bloccanti...
taskkill /f /im explorer.exe >nul 2>&1
taskkill /f /im dwm.exe >nul 2>&1

:: CANCELLA FILE TEMPORANEI
echo Pulizia file temporanei...
del /s /f /q "%temp%\*" >nul 2>&1
del /s /f /q "C:\Windows\Temp\*" >nul 2>&1
del /s /f /q "C:\Users\%USERNAME%\AppData\Local\Temp\*" >nul 2>&1

:: CANCELLA CACHE WINDOWS UPDATE
echo Pulizia di Windows Update...
net stop wuauserv >nul 2>&1
rd /s /q "C:\Windows\SoftwareDistribution" >nul 2>&1
net start wuauserv >nul 2>&1

:: PULISCE CARTELLA WINSXS (PESANTE, LIBERA ANCHE 10GB)
echo Pulizia della cartella WinSxS...
dism /online /cleanup-image /startcomponentcleanup /resetbase >nul 2>&1

:: SVUOTA IL CESTINO
echo Svuotando il Cestino...
rd /s /q C:\$Recycle.Bin >nul 2>&1

:: ESEGUE PULIZIA DISCO AUTOMATICA (STORAGE SENSE)
echo Pulizia avanzata con Storage Sense...
PowerShell -Command "& {Start-Process -FilePath 'cleanmgr.exe' -ArgumentList '/verylowdisk' -NoNewWindow -Wait}"

:: RIAVVIA ESPLORER
start explorer.exe
echo Pulizia completata!

:: MOSTRA SPAZIO LIBERO
wmic logicaldisk get size,freespace,caption
echo.
pause
