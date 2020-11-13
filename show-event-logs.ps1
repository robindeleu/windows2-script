function Show-Event-Logs {
    # Date format has to be dd-mm-yyyy
    $compareDate = "11-11-2020"
    $logsDirectory = "logs"
    $Begin = Get-Date -Date '11/11/2020 08:00:00'
    
    Write-Host "`n------------------------------------------------------" -ForegroundColor Yellow
    Write-Host "                CHECKING SECURITY LOG                   "
    Write-Host "------------------------------------------------------`n" -ForegroundColor Yellow
    
    # Import hashtable of security event id's
    . .\log-event-ids\security-event-ids.ps1

    # GROUP ALL SECURITY LOG ENTRIES BY EVENT ID
    # AND PRINT OUT THE AMOUNTS FOR EVENT IDs OF INTEREST
    $securityEventsSummary = Get-Eventlog -Logname Security -After $Begin | where {($_.EntryType -NotMatch "Information")}  | Group-Object -property EventID | Sort-Object -Property Count -Descending
    $securityEventList = @()

    foreach ($event in $securityEventsSummary) {
        $amount = ($event | Select-Object -ExpandProperty Count)
        $name = ($event | Select-Object -ExpandProperty Name)
        $eventId = [int]::Parse($name)
        $info = if ($securityEventIds[$eventId]) {$securityEventIds[$eventId]} else {"No description"}
        $securityEventList += [pscustomobject]@{EventId = $eventId; Info = $info; Count = $amount}
    }

    $securityEventList | Format-Table EventId, Count, Info

    # Leave a blank line after the last output
    Write-Host "`n"



    Write-Host "`n------------------------------------------------------" -ForegroundColor Yellow
    Write-Host "                 CHECKING SYSTEM LOG                    "
    Write-Host "------------------------------------------------------`n" -ForegroundColor Yellow

    # Import hashtable of known system event id's
    . .\log-event-ids\system-event-ids.ps1

    # GROUP ALL SECURITY LOG ENTRIES BY EVENT ID
    # AND PRINT OUT THE AMOUNTS FOR EVENT IDs OF INTEREST
    $systemEventsSummary = Get-Eventlog -Logname System -After $Begin | where {($_.EntryType -NotMatch "Information")}  | Group-Object -property EventID | Sort-Object -Property Count -Descending
    $systemEventList = @()

    foreach ($event in $systemEventsSummary) {
        $amount = ($event | Select-Object -ExpandProperty Count)
        $name = ($event | Select-Object -ExpandProperty Name)
        $eventId = [int]::Parse($name)
        $info = if ($systemEventIds[$eventId]) {$systemEventIds[$eventId]} else {"No description"}
        $systemEventList += [pscustomobject]@{EventId = $eventId; Info = $info; Count = $amount}
    }

    $systemEventList | Format-Table EventId, Count, Info

    # Leave a blank line after the last output
    Write-Host "`n"



    Write-Host "`n------------------------------------------------------" -ForegroundColor Yellow
    Write-Host "             Checking Application Log                   "
    Write-Host "------------------------------------------------------`n" -ForegroundColor Yellow

    # Import hashtable of known application event id's
    . .\log-event-ids\application-event-ids.ps1

    # GROUP ALL APPLICATION LOG ENTRIES BY EVENT ID
    # AND PRINT OUT THE AMOUNTS FOR EVENT IDs OF INTEREST
    $applicationEventsSummary = Get-Eventlog -Logname Application -After $Begin | where {($_.EntryType -NotMatch "Information")}  | Group-Object -property EventID | Sort-Object -Property Count -Descending
    $applicationEventList = @()

    foreach ($event in $applicationEventsSummary) {
        $amount = ($event | Select-Object -ExpandProperty Count)
        $name = ($event | Select-Object -ExpandProperty Name)
        $eventId = [int]::Parse($name)
        $info = if ($applicationEventIds[$eventId]) {$applicationEventIds[$eventId]} else {"No description"}
        $applicationEventList += [pscustomobject]@{EventId = $eventId; Info = $info; Count = $amount}
    }
    
    $applicationEventList | Format-Table EventId, Count, Info

    # Leave a blank line after the last output
    Write-Host "`n"



    # Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    # Write-Host "                    Saving Logs                         "
    # Write-Host "------------------------------------------------------`n" -ForegroundColor Green
    # $date = Get-Date -format "dd-MM-yyyy"
    # $systemfileLocation = "./$logsDirectory/logfile-system-$date.txt"
    # New-Item -Path $systemfileLocation -ItemType File
    # $applicationfileLocation = "./$logsDirectory/logfile-application-$date.txt"
    # New-Item -Path $applicationfileLocation -ItemType File
    # Out-File -inputobject $systemEvents -filepath $systemfileLocation
    # Out-File -inputobject $applicationEvents -filepath $applicationfileLocation


    # Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    # Write-Host "                    Comparing Logs                      "
    # Write-Host "------------------------------------------------------`n" -ForegroundColor Green
    # $comparesystemlog = "./$logsDirectory/logfile-system-$compareDate.txt"
    # $compareapplicationlog = "./$logsDirectory/logfile-application-$compareDate.txt"

    # Compare-Object -ReferenceObject (Get-Content -Path $comparesystemlog) -DifferenceObject (Get-Content -Path $systemfileLocation)
    # Compare-Object -ReferenceObject (Get-Content -Path $compareapplicationlog) -DifferenceObject (Get-Content -Path $applicationfileLocation)

}