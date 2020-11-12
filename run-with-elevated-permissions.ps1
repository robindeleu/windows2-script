function Run-Elevated {
    #Create a new Elevated process to Start PowerShell
    $ElevatedProcess = New-Object System.Diagnostics.ProcessStartInfo "PowerShell";
    
    # Specify the current script path and name as a parameter
    $ElevatedProcess.Arguments = "& '" + $script:MyInvocation.MyCommand.Path + "'"
    
    #Set the Process to elevated
    $ElevatedProcess.Verb = "runas"
    
    #Start the new elevated process
    [System.Diagnostics.Process]::Start($ElevatedProcess)
    
    #Exit from the current, unelevated, process
    Exit
}    