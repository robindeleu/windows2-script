function Show-Event-Logs {
    Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    Write-Host "                Checking Logs                           "
    Write-Host "------------------------------------------------------`n" -ForegroundColor Green
    #Write-Host (Get-WinEvent -ListLog * | where {$_.RecordCount -gt 0} | Out-String)
    #Logs:   Application, System, Security
    $Begin = Get-Date -Date '11/11/2020 08:00:00'
    $Stop = Get-Date -Date '11/11/2020 17:00:00'
    $mostRecentEvent = Get-Eventlog -LogName Application -Message *toestemming* -EntryType warning -After $Begin -Before $Stop | Select-Object -property *


    #Write-Host (Get-EventLog -LogName security -newest 1 | Get-Member | Out-String)
    Write-Host ($mostRecentEvent | Out-String)
}