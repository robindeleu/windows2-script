. .\cpu-usage.ps1
. .\ram-usage.ps1
. .\disk-usage.ps1
. .\installed-programs.ps1
. .\live-processes.ps1
. .\show-event-logs.ps1
. .\show-installed-programs.ps1
. .\users.ps1

function Show-Menu {
    param (
        [string]$Title = 'Powershell health check'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "1: Perform Full health check"
    Write-Host "2: Check CPU-usage"
    Write-Host "3: Check RAM-usage"
    Write-Host "4: Check Disk-usage"
    Write-Host "5: Show Event Logs"
    Write-Host "6: Show Installed Programs"
    Write-Host "7: Show Live Processes"
    Write-Host "8: Show Users"
    Write-Host "Q: Quit"
}

do{
    Show-Menu
    $selection = Read-Host "Please make a selection"
    switch ($selection)
    {
        '1' {
            CPU-Usage
            RAM-Usage
            Disk-Usage
            Show-Event-Logs
            #Installed-Programs
            #Live-Processes
            Users
        }
        '2' {
            CPU-Usage
        } 
        '3' {
            RAM-Usage
        } 
        '4' {
            Disk-Usage
        }
        '5' {
            Show-Event-Logs
        }
        '6' {
            #Installed-Programs
        }
        '7' {
            #Live-Processes
        }
        '8' {
            Users
        }
    }
 cmd /c pause
}
until ($selection -eq 'q')
