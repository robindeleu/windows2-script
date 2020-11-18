function CompareTXT {
    param (
        [string]$textBefore,
        [string]$textAfter
    )

    $File1 = Get-Content $textBefore | Foreach {$_.TrimEnd()}
    $File2 = Get-Content $textAfter | Foreach {$_.TrimEnd()}

    ForEach ($line in $File2)
    {
        If (!($File1 -contains $line))
        {
            Write-Output "$Line"
        }
    }
}