function Show-Event-Logs {
    # Date format has to be dd-mm-yyyy
    $compareDate = "11-11-2020"
    $logsDirectory = "logs"


    Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    Write-Host "                 CHECKING SYSTEM LOG                    "
    Write-Host "------------------------------------------------------`n" -ForegroundColor Green
    Write-Host "`n========> System-log: All non-information Entries`n" -ForegroundColor Yellow
    $Begin = Get-Date -Date '11/11/2020 08:00:00'
    $systemEvents = Get-Eventlog -logname System -After $Begin | where {($_.EntryType -NotMatch "Information")} | Sort-Object -Property EventId | Format-Table EventId, Timegenerated, EntryType, Source, Message -autosize
    Write-Host ($systemEvents | Out-String)

    Write-Host "`n========> System-log: Summary`n" -ForegroundColor Yellow
    $systemEventsSummary = Get-Eventlog -Logname System -After $Begin | where {($_.EntryType -NotMatch "Information")}  | Group-Object -property EventID | Sort-Object -Property Count -Descending
    Write-Host ($systemEventsSummary | Out-String)


    Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    Write-Host "             Checking Application Log                   "
    Write-Host "------------------------------------------------------`n" -ForegroundColor Green
    Write-Host "`n========> Application-log: All non-information Entries`n" -ForegroundColor Yellow
    $Begin = Get-Date -Date '11/11/2020 08:00:00'
    $applicationEvents = Get-Eventlog -Logname Application -After $Begin | where {($_.EntryType -NotMatch "Information")} | Sort-Object -Property EventId | Format-Table EventId, Timegenerated, EntryType, Source, Message -autosize
    Write-Host ($applicationEvents | Out-String)

    Write-Host "`n========> Application-log: Summary`n" -ForegroundColor Yellow
    $applicationEventsSummary = Get-Eventlog -Logname Application -After $Begin | where {($_.EntryType -NotMatch "Information")}  | Group-Object -property EventID | Sort-Object -Property Count -Descending
    Write-Host ($applicationEventsSummary | Out-String)

    Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    Write-Host "                    Saving Logs                         "
    Write-Host "------------------------------------------------------`n" -ForegroundColor Green
    $date = Get-Date -format "dd-MM-yyyy"
    $systemfileLocation = "./$logsDirectory/logfile-system-$date.txt"
    New-Item -Path $systemfileLocation -ItemType File
    $applicationfileLocation = "./$logsDirectory/logfile-application-$date.txt"
    New-Item -Path $applicationfileLocation -ItemType File
    Out-File -inputobject $systemEvents -filepath $systemfileLocation
    Out-File -inputobject $applicationEvents -filepath $applicationfileLocation


    Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    Write-Host "                    Comparing Logs                      "
    Write-Host "------------------------------------------------------`n" -ForegroundColor Green
    $comparesystemlog = "./$logsDirectory/logfile-system-$compareDate.txt"
    $compareapplicationlog = "./$logsDirectory/logfile-application-$compareDate.txt"

    Compare-Object -ReferenceObject (Get-Content -Path $comparesystemlog) -DifferenceObject (Get-Content -Path $systemfileLocation)
    Compare-Object -ReferenceObject (Get-Content -Path $compareapplicationlog) -DifferenceObject (Get-Content -Path $applicationfileLocation)

}