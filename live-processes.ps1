function Live-Processes {
    Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    Write-Host "                Checking 'All live processes working'"
    Write-Host "------------------------------------------------------`n" -ForegroundColor Green
    $A = Get-Process
    $A | Get-Process | Format-Table -View priority
}