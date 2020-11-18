$first= get-content "./logs/proc-11-11-2020-1.txt" | Out-String
$second = get-content "./logs/proc-11-11-2020-2.txt" | Out-String
$finaldest2       = "./logs/test.txt"

Write-Host(Compare-Object -ReferenceObject ($first) -DifferenceObject ($second) |Out-String)