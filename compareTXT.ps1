function CompareTXT {
    param (
        [string]$textBefore,
        [string]$textAfter
    )

<<<<<<< HEAD
    foreach($line in Get-Content $textBefore) {
        foreach($line2 in Get-Content $textAfter) {
            if($line -like $line2){
                write-host($line -like $line2)
                get-content $line
            }

=======
    $File1 = Get-Content $textBefore | Foreach {$_.TrimEnd()}
    $File2 = Get-Content $textAfter | Foreach {$_.TrimEnd()}

    ForEach ($line in $File2)
    {
        If (!($File1 -contains $line))
        {
            Write-Output "$Line"
>>>>>>> 16199d7af4a2459056d6e354f8d25020443748e2
        }
    }
}