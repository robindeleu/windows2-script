Write-Host "`n------------------------------------------------------" -ForegroundColor Green
Write-Host "                Checking 'CPU Usage'"
Write-Host "------------------------------------------------------`n" -ForegroundColor Green
     
Get-WmiObject Win32_Processor | Select LoadPercentage | Format-List
