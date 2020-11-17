function Live-Processes {
    Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    Write-Host "                Checking 'All live processes working'"
    Write-Host "------------------------------------------------------`n" -ForegroundColor Green

    # This is just a simple CMDLET that makes that we can print out the processes and see the priority
    # $A = Get-Process
    # $A | Get-Process | Format-Table -View priority
    Get-Process | Sort-Object -Property cpu -Descending | Select-Object -First 10
}