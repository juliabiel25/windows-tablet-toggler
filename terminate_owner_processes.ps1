param (
    [string]$FilePath
)

if (-not $FilePath) {
    Write-Output "Usage: .\TerminateProcesses.ps1 -FilePath 'C:\Path\To\File'"
    exit
}

# Check if file path is valid
if (-not (Test-Path $FilePath)) {
    Write-Output "File path does not exist: $FilePath"
    exit
}

# Get a list of processes using the file
$processes = Get-Process | Where-Object {
    $_.Modules | Where-Object {
        $_.FileName -eq $FilePath
    }
}

# Check if any processes are using the file
if ($processes) {
    foreach ($process in $processes) {
        Write-Output "Terminating process $($process.Name) with PID $($process.Id)"
        Stop-Process -Id $process.Id -Force
    }
} else {
    Write-Output "No processes are using the file at: $FilePath"
}

Write-Output "Finished."
