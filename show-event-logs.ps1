. .\compareTXT.ps1

function Show-Event-Logs {
    # Date format has to be dd-mm-yyyy
    $compareDate = "11-11-2020"
    $logsDirectory = "logs"
    $Begin = Get-Date -Date '12/11/2020 00:00:00'
    $End = Get-Date -Date '12/11/2020 23:59:59'
    
    Write-Host "`n------------------------------------------------------" -ForegroundColor Yellow
    Write-Host "                CHECKING SECURITY LOG                   "
    Write-Host "------------------------------------------------------`n" -ForegroundColor Yellow
    
    # Import hashtable of security event id's
    . .\log-event-ids\security-event-ids.ps1

    # GROUP ALL SECURITY LOG ENTRIES BY EVENT ID
    # AND PRINT OUT THE AMOUNTS FOR EVENT IDs OF INTEREST
    $securityEventsSummary = Get-Eventlog -Logname Security -After $Begin -Before $End | Group-Object -property EventID | Sort-Object -Property Count -Descending
    $securityEventList = @()

    foreach ($event in $securityEventsSummary) {
        $amount = ($event | Select-Object -ExpandProperty Count)
        $name = ($event | Select-Object -ExpandProperty Name)
        $eventId = [int]::Parse($name)
        $info = if ($securityEventIds[$eventId]) {$securityEventIds[$eventId]} else {"No description"}
        $securityEventList += [pscustomobject]@{EventId = $eventId; Info = $info; Count = $amount}
    }

    $securityEventListFormated = $securityEventList | Format-Table EventId, Info
    $securityEventListFormated

    # Leave a blank line after the last output
    Write-Host "`n"



    Write-Host "`n------------------------------------------------------" -ForegroundColor Yellow
    Write-Host "                 CHECKING SYSTEM LOG                    "
    Write-Host "------------------------------------------------------`n" -ForegroundColor Yellow

    # Import hashtable of known system event id's
    . .\log-event-ids\system-event-ids.ps1

    # GROUP ALL SECURITY LOG ENTRIES BY EVENT ID
    # AND PRINT OUT THE AMOUNTS FOR EVENT IDs OF INTEREST
    $systemEventsSummary = Get-Eventlog -Logname System -After $Begin -Before $End | where {($_.EntryType -NotMatch "Information")}  | Group-Object -property EventID | Sort-Object -Property Count -Descending
    $systemEventList = @()

    foreach ($event in $systemEventsSummary) {
        $amount = ($event | Select-Object -ExpandProperty Count)
        $name = ($event | Select-Object -ExpandProperty Name)
        $eventId = [int]::Parse($name)
        $info = if ($systemEventIds[$eventId]) {$systemEventIds[$eventId]} else {"No description"}
        $systemEventList += [pscustomobject]@{EventId = $eventId; Info = $info; Count = $amount}
    }

    $systemEventListFormated = $systemEventList | Format-Table EventId, Info
    $systemEventListFormated

    # Leave a blank line after the last output
    Write-Host "`n"



    Write-Host "`n------------------------------------------------------" -ForegroundColor Yellow
    Write-Host "             CHECKING APPLICATION LOG                   "
    Write-Host "------------------------------------------------------`n" -ForegroundColor Yellow

    # Import hashtable of known application event id's
    . .\log-event-ids\application-event-ids.ps1

    # GROUP ALL APPLICATION LOG ENTRIES BY EVENT ID
    # AND PRINT OUT THE AMOUNTS FOR EVENT IDs OF INTEREST
    $applicationEventsSummary = Get-Eventlog -Logname Application -After $Begin -Before $End | where {($_.EntryType -NotMatch "Information")}  | Group-Object -property EventID | Sort-Object -Property Count -Descending
    $applicationEventList = @()

    foreach ($event in $applicationEventsSummary) {
        $amount = ($event | Select-Object -ExpandProperty Count)
        $name = ($event | Select-Object -ExpandProperty Name)
        $eventId = [int]::Parse($name)
        $info = if ($applicationEventIds[$eventId]) {$applicationEventIds[$eventId]} else {"No description"}
        $applicationEventList += [pscustomobject]@{EventId = $eventId; Info = $info; Count = $amount}
    }
    
    $applicationEventListFormated = $applicationEventList | Format-Table EventId, Info
    $applicationEventListFormated

    # Leave a blank line after the last output
    Write-Host "`n"



    Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    Write-Host "                    Saving Logs                         "
    Write-Host "------------------------------------------------------`n" -ForegroundColor Green


    $date = Get-Date -format "dd-MM-yyyy"
    
    $systemFileLocation = "./$logsDirectory/logfile-system-$date.txt"
    New-Item -Path $systemFileLocation -ItemType File -Force
    Out-File -inputobject $systemEventListFormated -filepath $systemFileLocation -Force
    Write-Host "Log saved: $systemFileLocation"

    $securityFileLocation = "./$logsDirectory/logfile-security-$date.txt"
    New-Item -Path $securityFileLocation -ItemType File -Force
    Out-File -inputobject $securityEventListFormated -filepath $securityFileLocation -Force
    Write-Host "Log saved: $securityFileLocation"

    $applicationFileLocation = "./$logsDirectory/logfile-application-$date.txt"
    New-Item -Path $applicationFileLocation -ItemType File -Force
    Out-File -inputobject $applicationEventListFormated -filepath $applicationFileLocation -Force
    Write-Host "Log saved: $applicationFileLocation"



    Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    Write-Host "                    Comparing Logs                      "
    Write-Host "------------------------------------------------------`n" -ForegroundColor Green
    $comparesystemlog = "./$logsDirectory/logfile-system-$compareDate.txt"
    $compareapplicationlog = "./$logsDirectory/logfile-application-$compareDate.txt"
    $comparesecuritylog = "./$logsDirectory/logfile-security-$compareDate.txt"

    if (Test-Path -Path $comparesystemlog) {
        Write-Host "========> Comparing System log (whats new in todays log)"
        Write-Host "EventId   Info"
        $SystemCompare = Compare-Object -ReferenceObject (Get-Content -Path $comparesystemlog) -DifferenceObject (Get-Content -Path $systemfileLocation)
        foreach ($item in $SystemCompare) {
            if ($item.sideindicator -eq '=>')
            {
                Write-Host $item.InputObject
            }
        }
    } else {
        Write-Host "========> No System log to compare with"
    }

    # Leave a blank line after the last output
    Write-Host "`n"

    if (Test-Path -Path $compareapplicationlog) {
        Write-Host "========> Comparing Application log (whats new in todays log)"
        Write-Host "EventId   Info"
        $ApplicationCompare = Compare-Object -ReferenceObject (Get-Content -Path $compareapplicationlog) -DifferenceObject (Get-Content -Path $applicationfileLocation)
        foreach ($item in $ApplicationCompare) {
            if ($item.sideindicator -eq '=>')
            {
                Write-Host $item.InputObject
            }
        }
    } else {
        Write-Host "========> No Application log to compare with"
    }
    
    # Leave a blank line after the last output
    Write-Host "`n"

    if (Test-Path -Path $comparesecuritylog) {
        Write-Host "========> Comparing Security log (whats new in todays log)"
        Write-Host "EventId   Info"

        CompareTXT -textBefore "$comparesecuritylog" -textAfter "$securityFileLocation"

        # $SecurityCompare = Compare-Object -ReferenceObject (Get-Content -Path $comparesecuritylog) -DifferenceObject (Get-Content -Path $securityFileLocation)
        # foreach ($item in $SecurityCompare) {
        #     if ($item.sideindicator -eq '=>')
        #     {
        #         Write-Host $item.InputObject
        #     }
        # }
    } else {
        Write-Host "========> No Security log to compare with"
    }

    # Leave a blank line after the last output
    Write-Host "`n"

}