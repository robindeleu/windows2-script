function Shares {

    $compareDate = "11-11-2020"
    $saveid="2"
    $logsDirectory = "logs"
    $referenceopbject = "./$logsDirectory/shares-11-11-2020-1.txt"
    Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    Write-Host "                Checking 'All shares'"
    Write-Host "------------------------------------------------------`n" -ForegroundColor Green
    $checkshares = Get-SmbShare | Select-Object Name, Path, Description| Format-Table -AutoSize
    $checkshares
    #Dit is om op te slaan van alle shares op dit moment in een text file
    $sharesave = "./$logsDirectory/shares-$compareDate-$saveid.txt"
    New-Item -Path $sharesave -ItemType File -Force
    Out-File -inputobject $checkshares -filepath $sharesave -Force
    Write-Host "saved in: $sharesave"
    #$checkshares > D:\Users\deleu\Documents\VIVES\powershell1.txt
    #Dit is om te vergelijken tussen oud en nieuw
    Compare-Object -ReferenceObject (Get-Content -Path $referenceopbject) -DifferenceObject (Get-Content -Path $sharesave)
}