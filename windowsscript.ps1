. .\cpu-usage.ps1
. .\ram-usage.ps1
. .\disk-usage.ps1
. .\installed-programs.ps1
. .\live-processes.ps1
. .\show-event-logs.ps1
. .\show-installed-programs.ps1
. .\users.ps1
. .\run-with-elevated-permissions.ps1
. .\shares.ps1
. .\services.ps1
. .\compareTXT.ps1

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
    Write-Host "9: Show Shares"
    Write-Host "10: Show Services"
    Write-Host "11: Open current directory with elevated permissions"
    Write-Host "Q: Quit"
}

do{
    Show-Menu
    $selection = Read-Host "Please make a selection"
    switch ($selection)
    {
        '1' {
            $title = "<h2>Server Health Check</h2>"
            $cpu = CPU-Usage
            $ram = RAM-Usage
            $disks = Disk-Usage
            # Show-Event-Logs
            # Installed-Programs
            # Live-Processes
            $users = Get-LocalUser | ConvertTo-Html -Property FullName, Name
            $shares = Get-SmbShare | ConvertTo-Html -Property Name, Path

            $htmlpage = "<h1>$title</h1>
                        <table>
                            <tr>
                                <th>CPU Usage</th>
                                <th>RAM Usage</th>
                            </tr>
                            <tr>
                                <td>$cpu</td>
                                <td>$ram</td>
                            </tr>
                        </table>

                        <h3>Installed disks and usage</h3>
                        <p>$disks</p>

                        <h3>Current users</h3>
                        <p>$users</p>

                        <h3>Shares</h3>
                        <p>$shares</p>"
            ConvertTo-Html -CssUri "style.css" -Body $htmlpage -Title "Server Health Check" | Out-File healthcheck.html
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
            Installed-Programs
        }
        '7' {
            Live-Processes
        }
        '8' {
            Users
        }
        '9' {
            Shares
        }
        '10' {
            Show-Services
        }
        '11'{
            Run-Elevated
        }
        '12'{
            CompareTXT -textBefore "./serverlogs/before/logfile-security-11-11-2020.txt" -textAfter "./serverlogs/after/logfile-security-17-11-2020.txt"
        }
    }
 cmd /c pause
}
until ($selection -eq 'q')
