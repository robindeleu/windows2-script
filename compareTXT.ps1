function CompareTXT {
    param (
        [string]$textBefore,
        [string]$textAfter
    )

    foreach($line in Get-Content $textBefore) {
        foreach($line2 in Get-Content $textAfter) {
            $line -match $line2
        }
    }
}