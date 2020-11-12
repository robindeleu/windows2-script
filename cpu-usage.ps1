function CPU-Usage {
    Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    Write-Host "                Checking 'CPU Usage WORKING'"
    Write-Host "------------------------------------------------------`n" -ForegroundColor Green
    $Processor = (Get-WmiObject -Class win32_processor| Measure-Object -Property LoadPercentage -Average | Select-Object Average).Average
    Write-Output "$Processor%"
}