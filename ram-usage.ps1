function RAM-Usage {
    Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    Write-Host "                Checking 'RAM Usage WORKING'"
    Write-Host "------------------------------------------------------`n" -ForegroundColor Green
    $ComputerMemory = Get-WmiObject -Class win32_operatingsystem
    $Memory = ((($ComputerMemory.TotalVisibleMemorySize - $ComputerMemory.FreePhysicalMemory)*100)/ $ComputerMemory.TotalVisibleMemorySize)
    $RoundMemory = [math]::Round($Memory, 2)
    Write-Output "$RoundMemory%"
}