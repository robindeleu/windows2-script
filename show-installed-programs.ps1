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