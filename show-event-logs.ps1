function Show-Event-Logs {
    # Date format has to be dd-mm-yyyy
    $compareDate = "11-11-2020"
    $logsDirectory = "logs"
    $Begin = Get-Date -Date '11/11/2020 08:00:00'

    Write-Host "`n------------------------------------------------------" -ForegroundColor Yellow
    Write-Host "                CHECKING SECURITY LOG                   "
    Write-Host "------------------------------------------------------`n" -ForegroundColor Yellow

    # EVENT IDs OF INTEREST
    $eventIds = @{
        1102 = "The audit log was cleared"

        4608 = "Windows is starting up"
        4609 = "Windows is shutting down"

        4624 = "Successful User Logins"
        4625 = "Failed User Account Logins"

        
        4728 = "A member was added to a security-enabled global group"
        4729 = "A member was removed from a security-enabled global group"
        
        4732 = "Users Added to Privileged Group"

        4740 = "Account Lockouts"

        4756 = "Users Added to Privileged Group"
    }

    # GROUP ALL SECURITY LOG ENTRIES BY EVENT ID
    # AND PRINT OUT THE AMOUNTS FOR EVENT IDs OF INTEREST
    $securityEventsSummary = Get-Eventlog -Logname Security -After $Begin | where {($_.EntryType -NotMatch "Information")}  | Group-Object -property EventID | Sort-Object -Property Count -Descending
    foreach ($event in $eventIds.keys) {
        $amount = ($securityEventsSummary | where {($_.Name -Match "$event")} | Select-Object -ExpandProperty count | Out-String)
        if ($amount -gt 0) {
            Write-Host $eventIds[$event] ": " $amount
        }
    }




    # Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    # Write-Host "                 CHECKING SYSTEM LOG                    "
    # Write-Host "------------------------------------------------------`n" -ForegroundColor Green
    # Write-Host "`n========> System-log: All non-information Entries`n" -ForegroundColor Yellow
    # $systemEvents = Get-Eventlog -logname System -After $Begin | where {($_.EntryType -NotMatch "Information")} | Sort-Object -Property EventId | Format-Table EventId, Timegenerated, EntryType, Source, Message -autosize
    # Write-Host ($systemEvents | Out-String)

    # Write-Host "`n========> System-log: Summary`n" -ForegroundColor Yellow
    # $systemEventsSummary = Get-Eventlog -Logname System -After $Begin | where {($_.EntryType -NotMatch "Information")}  | Group-Object -property EventID | Sort-Object -Property Count -Descending
    # Write-Host ($systemEventsSummary | Out-String)


    # Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    # Write-Host "             Checking Application Log                   "
    # Write-Host "------------------------------------------------------`n" -ForegroundColor Green
    # Write-Host "`n========> Application-log: All non-information Entries`n" -ForegroundColor Yellow
    # $applicationEvents = Get-Eventlog -Logname Application -After $Begin | where {($_.EntryType -NotMatch "Information")} | Sort-Object -Property EventId | Format-Table EventId, Timegenerated, EntryType, Source, Message -autosize
    # Write-Host ($applicationEvents | Out-String)

    # Write-Host "`n========> Application-log: Summary`n" -ForegroundColor Yellow
    # $applicationEventsSummary = Get-Eventlog -Logname Application -After $Begin | where {($_.EntryType -NotMatch "Information")}  | Group-Object -property EventID | Sort-Object -Property Count -Descending
    # Write-Host ($applicationEventsSummary | Out-String)

    # Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    # Write-Host "             Checking Security Log                   "
    # Write-Host "------------------------------------------------------`n" -ForegroundColor Green
    # Write-Host "`n========> Security-log: All non-information Entries`n" -ForegroundColor Yellow
    # $securityEvents = Get-Eventlog -Logname Security -After $Begin | where {($_.EntryType -NotMatch "Information")} | Sort-Object -Property EventId | Format-Table EventId, Timegenerated, EntryType, Source, Message -autosize
    # Write-Host ($securityEvents | Out-String)

    # Write-Host "`n========> Security-log: Summary`n" -ForegroundColor Yellow
    # $securityEventsSummary = Get-Eventlog -Logname Security -After $Begin | where {($_.EntryType -NotMatch "Information")}  | Group-Object -property EventID | Sort-Object -Property Count -Descending
    # Write-Host ($securityEventsSummary | Out-String)

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