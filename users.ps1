Write-Host "`n------------------------------------------------------" -ForegroundColor Green
Write-Host "                Checking Users                           "
Write-Host "------------------------------------------------------`n" -ForegroundColor Green

Get-LocalUser | Sort-Object PrincipalSource | Select Name, PrincipalSource, LastLogon, PasswordChangeableDate, PasswordLastSet, Description | Format-Table -AutoSize

$Locals = Get-LocalUser | Where-Object PrincipalSource -eq "Local" | Select PrincipalSource
$mcAccounts = Get-LocalUser | Where-Object PrincipalSource -eq "MicrosoftAccount" | Select PrincipalSource

Foreach ($item in $Locals){
    $cntLocals ++
}

Foreach ($item in $mcAccounts) {
    $cntMCAccounts ++
}

Write-Host "Number of Local accounts: " $cntLocals
Write-Host "Number of Microsoft accounts: " $cntMCAccounts "`n"

$objects = @{
  ReferenceObject = (Get-Content -Path ../usersbefore.txt)
  DifferenceObject = (Get-Content -Path ../usersafter.txt)
}

#Get-LocalUser | Sort-Object PrincipalSource | Select Name, PrincipalSource, LastLogon, PasswordChangeableDate, PasswordLastSet, Description > ../usersafter.txt
Compare-Object -ReferenceObject (Get-Content ../usersbefore.txt) -DifferenceObject (Get-Content ../usersafter.txt)
if(Compare-Object -ReferenceObject (Get-Content ../usersbefore.txt) -DifferenceObject (Get-Content ../usersafter.txt)) {
    Write-Host "Files are different"
}
else {
    Write-Host  "Files are the same"
}
Get-LocalUser | Sort-Object PrincipalSource | Select Name, PrincipalSource, LastLogon, PasswordChangeableDate, PasswordLastSet, Description > ../usersbefore.txt