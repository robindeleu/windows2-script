function CompareTXT {
    param (
        [string]$textBefore,
        [string]$textAfter
    )

    foreach($line in Get-Content $textBefore) {
        foreach($line2 in Get-Content $textAfter) {
            if($line -like $line2){
                write-host($line -like $line2)
                get-content $line
            }

        }
    }
}