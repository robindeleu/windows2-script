function Disk-Usage {
    Write-Host "`n------------------------------------------------------" -ForegroundColor Green
    Write-Host "                Checking 'Disk Usage WORKING'"
    Write-Host "------------------------------------------------------`n" -ForegroundColor Green
    $TCapacity =@{  Expression = { "{0,19:n2}" -f ($_.Capacity / 1GB) };
                    Name= 'Total Capacity (GB)';}
    $Freespace =@{  Expression = { "{0,15:n2}" -f ($_.FreeSpace / 1GB) };
                    Name = 'Free Space (GB)';
    }
    $PercentFree =@{Expression = { [int]($_.Freespace * 100 / $_.Capacity) };
                    Name = 'Free (%)'
    }
    Write-Host (Get-WmiObject -namespace "root/cimv2" -query "SELECT Name, Capacity, FreeSpace FROM Win32_Volume WHERE Capacity > 0 and (DriveType = 2 OR DriveType = 3)" |
    Select-Object -Property Name, $TCapacity, $Freespace, $PercentFree  | Sort-Object 'Free (%)' -Descending | Out-String)
}