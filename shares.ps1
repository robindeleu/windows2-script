function Shares {
    Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    Write-Host "                Checking 'All shares'"
    Write-Host "------------------------------------------------------`n" -ForegroundColor Green
    $checkshares = Get-SmbShare | Select-Object Name, Path, Description| Format-Table -AutoSize
    $checkshares
    #Dit is om op te slaan van alle shares op dit moment in een text file
    #$checkshares > D:\Users\deleu\Documents\VIVES\powershell1.txt
    #Dit is om te vergelijken tussen oud en nieuw
    #Compare-Object -ReferenceObject (Get-Content D:\Users\deleu\Documents\VIVES\powershell.txt) -DifferenceObject (Get-Content D:\Users\deleu\Documents\VIVES\powershell1.txt)
}