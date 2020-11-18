
$inputLines = Get-Content -Path "./logs/proc-11-11-2020-1.txt"
$compareLines = Get-Content -Path "./logs/proc-11-11-2020-2.txt"
$inputLines = import-csv ./logs/proc-11-11-2020-1.txt -delimiter "`t" | export-csv csvfile.csv

#Importing CSV
$File1 = Import-Csv $inputLines
 
#Importing CSV 
$File2 = Import-Csv $compareLines
 
#Compare both CSV files - column SamAccountName
$Results = Compare-Object  $File1 $File2 -Property SamAccountName -IncludeEqual
 
$Array = @()       
Foreach($R in $Results)
{
    If( $R.sideindicator -eq "==" )
    {
        $Object = [pscustomobject][ordered] @{
 
            Username = $R.SamAccountName
            "Compare indicator" = $R.sideindicator
 
        }
        $Array += $Object
    }
}
 
#Count users in both files
($Array | sort-object username | Select-Object * -Unique).count
 
#Display results in console
$Array