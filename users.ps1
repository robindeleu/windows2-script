function Users {
    Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    Write-Host "                Checking Users                           "
    Write-Host "------------------------------------------------------`n" -ForegroundColor Green

    $fileBefore = "../usersafter.txt"
    $fileAfter = "../usersbefore.txt"
    $fileBackup = "../backupUsers.txt"

    Get-LocalUser | Sort-Object PrincipalSource | Select Name, PrincipalSource, LastLogon, PasswordChangeableDate, PasswordLastSet, Description | Format-Table -AutoSize
    Get-Date -Format "dddd MM/dd/yyyy HH:mm K`n"

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

    Get-LocalUser | Sort-Object PrincipalSource | Select Name, PrincipalSource, LastLogon, PasswordChangeableDate, PasswordLastSet, Description > $fileAfter
    Compare-Object -ReferenceObject (Get-Content $fileBefore) -DifferenceObject (Get-Content $fileAfter)
    if(Compare-Object -ReferenceObject (Get-Content $fileBefore) -DifferenceObject (Get-Content $fileAfter)) {
        Write-Host "Files are different"
    }
    else {
        Write-Host  "Files are the same"
    }

    $Date = Get-Date -Format "dddd MM/dd/yyyy HH:mm K"
    $From = Get-Content -Path $fileBefore
    Add-Content -Path $fileBackup -Value $From
    Add-Content -Path $fileBackup -Value $Date
    
    Get-LocalUser | Sort-Object PrincipalSource | Select Name, PrincipalSource, LastLogon, PasswordChangeableDate, PasswordLastSet, Description > $fileBefore
}