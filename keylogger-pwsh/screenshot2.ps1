function Get-ScreenCapture {

    param (
        [Switch] $OfWindow
    )


    begin {
        Add-Type -AssemblyName System.Drawing
        $jpegCodec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | 
                        Where-Object { $_.MimeType -eq "image/jpeg" }
    }
    process {
        Start-Sleep -Milliseconds 250
        if ($OfWindow) {
            [Windows.Forms.SendKeys]::SendWait("%{PRTSC}")   
        } else {
            [Windows.Forms.SendKeys]::SendWait("{PRTSC}")
        }
        Start-Sleep -Milliseconds 250
        $bitmap = [Windows.Forms.Clipboard]::GetImage()
        $ep.Param[0] = New-Object Drawing.Imaging.EncoderParameters ([System.Drawing.Imaging.Encoder]::Quality, [long]100)
        $screenshotCapturePathBase = "$pwd\screenshot_$(Get-Random).jpg"
        $bitmap.Save($screenshotCapturePathBase, $jpegCodec, $ep.Param[0])
    }
}

Get-ScreenCapture -OfWindow:$false