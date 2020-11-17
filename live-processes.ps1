function Live-Processes {
    Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    Write-Host "                Checking 'All live processes working'"
    Write-Host "------------------------------------------------------`n" -ForegroundColor Green

    # This is just a simple CMDLET that makes that we can print out the processes sorted by CPU and display the first 10
    Write-Host(Get-Process | Sort-Object -Property cpu -Descending | Select-Object -First 10| Out-String) 
}