function CPU-Usage {
    Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    Write-Host "                Checking 'CPU Usage WORKING'"
    Write-Host "------------------------------------------------------`n" -ForegroundColor Green
    $Processor = (Get-WmiObject -Class win32_processor| Measure-Object -Property LoadPercentage -Average | Select-Object Average).Average
    Write-Output "$Processor%"
}

function RAM-Usage {
    Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    Write-Host "                Checking 'RAM Usage WORKING'"
    Write-Host "------------------------------------------------------`n" -ForegroundColor Green
    $ComputerMemory = Get-WmiObject -Class win32_operatingsystem
    $Memory = ((($ComputerMemory.TotalVisibleMemorySize - $ComputerMemory.FreePhysicalMemory)*100)/ $ComputerMemory.TotalVisibleMemorySize)
    $RoundMemory = [math]::Round($Memory, 2)
    Write-Output "$RoundMemory%"
}

function Disk-Usage {
    Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    Write-Host "                Checking 'Disk Usage WORKING'"
    Write-Host "------------------------------------------------------`n" -ForegroundColor Green
    $TCapacity =@{  Expression = { "{0,19:n2}" -f ($_.Capacity / 1GB) };
                    Name= 'Total Capacity (GB)';}
    $Freespace =@{  Expression = { "{0,15:n2}" -f ($_.FreeSpace / 1GB) };
                    Name = 'Free Space (GB)';
    }
    $PercentFree =@{Expression = { [int]($_.Freespace * 100 / $_.Capacity) };
                    Name = 'Free (%)'
    }
    Write-Host (Get-WmiObject -namespace "root/cimv2" -query "SELECT Name, Capacity, FreeSpace FROM Win32_Volume WHERE Capacity > 0 and (DriveType = 2 OR DriveType = 3)" |
    Select-Object -Property Name, $TCapacity, $Freespace, $PercentFree  | Sort-Object 'Free (%)' -Descending | Out-String)
}

function Installed-Programs {
    Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    Write-Host "                Checking 'All installed programs working'"
    Write-Host "------------------------------------------------------`n" -ForegroundColor Green
    Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table -AutoSize
}

function Live-Processes {
    Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    Write-Host "                Checking 'All live processes working'"
    Write-Host "------------------------------------------------------`n" -ForegroundColor Green
    $A = Get-Process
    $A | Get-Process | Format-Table -View priority
}

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
function Installed-Programs {
    Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    Write-Host "                Checking Installed Programs                           "
    Write-Host "------------------------------------------------------`n" -ForegroundColor Green
    Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table -AutoSize
    
    #DIT DEEL WERKT NOG NIET
    # voor het opslaan van dit bestand:
    #$storelocation= D:\Users\deleu\Documents\VIVES\Fase 3\Windows2\windows2-script\script-befor.txt
    Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table -AutoSize > D:\Users\deleu\Documents\VIVES\powershell.txt


    #Als je wil vergelijken voor en na
    
    #$befor = C:\Users\deleu\Documents\InstalledPrograms-PS-befor.txt
    #$after = C:\Users\deleu\Documents\InstalledPrograms-PS-after.txt
    
    #Compare-Object -ReferenceObject (Get-Content C:\Users\deleu\Documents\InstalledPrograms-PS-befor.txt) -DifferenceObject (Get-Content C:\Users\deleu\Documents\InstalledPrograms-PS-after.txt)

}

CPU-Usage
RAM-Usage
Disk-Usage
Show-Event-Logs
Installed-Programs
#Live-Processes

cmd /c pause

