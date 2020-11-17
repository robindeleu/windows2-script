function Installed-Programs {
    $compareDate = "11-11-2020"
    $saveid="2"
    $logsDirectory = "logs"
    $referenceopbject = "./$logsDirectory/inst-prog-11-11-2020-1.txt"
    Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    Write-Host "                Checking Installed Programs                           "
    Write-Host "------------------------------------------------------`n" -ForegroundColor Green
    $console =  Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate -first 10| Format-Table -AutoSize
    $console 
    $data = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table -AutoSize

    $sharesave = "./$logsDirectory/inst-prog-$compareDate-$saveid.txt"
    New-Item -Path $sharesave -ItemType File -Force
    Out-File -inputobject $data -filepath $sharesave -Force
    Write-Host "saved in: $sharesave"

    Compare-Object -ReferenceObject (Get-Content -Path $referenceopbject) -DifferenceObject (Get-Content -Path $sharesave)
    #DIT DEEL WERKT NOG NIET
    # voor het opslaan van dit bestand:
    #$storelocation= D:\Users\deleu\Documents\VIVES\Fase 3\Windows2\windows2-script\script-befor.txt
 

    #Als je wil vergelijken voor en na
    
    #$befor = C:\Users\deleu\Documents\InstalledPrograms-PS-befor.txt
    #$after = C:\Users\deleu\Documents\InstalledPrograms-PS-after.txt
    
    #Compare-Object -ReferenceObject (Get-Content D:\Users\deleu\Documents\VIVES\powershell.txt) -DifferenceObject (Get-Content D:\Users\deleu\Documents\VIVES\powershell1.txt)

}