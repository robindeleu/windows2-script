function RAM-Usage {
    Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    Write-Host "                Checking 'RAM Usage WORKING'"
    Write-Host "------------------------------------------------------`n" -ForegroundColor Green
    $ComputerMemory = Get-WmiObject -Class win32_operatingsystem
    $Memory = ((($ComputerMemory.TotalVisibleMemorySize - $ComputerMemory.FreePhysicalMemory)*100)/ $ComputerMemory.TotalVisibleMemorySize)
    $RoundMemory = [math]::Round($Memory, 2)
    Write-Output "Live RAM-Usage: $RoundMemory%"
    #Get-Process | Group-Object -Property ProcessName |
    Get-Process | Sort-Object -Property WS -Descending | Select-Object -First 15| Format-Table `
    @{Label = "Used Memory(Mb)"; Expression = {[int]($_.WS / 1Mb)}},
    ProcessName -AutoSize
}