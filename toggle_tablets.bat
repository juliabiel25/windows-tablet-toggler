@echo off
setlocal

:: Define registry key and value
set "regKey=HKCU\TabletToggle"
set "regValue=1"

:: Define paths and filenames
set "psScriptPath=%~dp0\terminate_owner_processes.ps1"
set "tablet1SourcePath=%~dp0\TABLET_1_DLL_FILE\wintab32.dll"
set "tablet2SourcePath=%~dp0\TABLET_2_DLL_FILE\wintab32.dll"
set "configPath=%~dp0\config.txt"
set "windowsPath=C:\Windows"

:: Check for administrative privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrative privileges...
    :: Prompt for administrative privileges
    powershell -Command "Start-Process cmd -ArgumentList '/c %~s0 %*' -Verb RunAs"
    exit /b
)

:: Get path to Windows from config.txt
if not exist "%configPath%" (
    echo Config file not found at %configPath%
    echo Please make sure config.txt is located at the specified path.
    pause
    exit /b
)
for /f "usebackq tokens=1,2 delims=: " %%A in ("%configPath%") do (
    if /i "%%A"=="windowsFolderPath" (
        set "windowsPath=%%B"
    )
)
set "targetPath=%windowsPath%\System32\wintab32.dll"
echo Windows path: %windowsPath%

:: Check if the registry key exists
reg query "%regKey%" /v "%regValue%" >nul 2>&1
if %errorLevel% neq 0 (
    :: If the key does not exist, create it and set the initial value
    reg add "%regKey%" /v "%regValue%" /t REG_SZ /d "1" /f
)

:: Load the current value from the registry
for /f "tokens=3*" %%A in ('reg query "%regKey%" /v "%regValue%" 2^>nul') do set "tablet=%%A"
echo Tablet currently in use: %tablet%

:: Check if the PowerShell script exists
if not exist "%psScriptPath%" (
    echo PowerShell script not found at %psScriptPath%
    echo Please make sure TerminateProcesses.ps1 is located at the specified path.
    pause
    exit /b
)

if "%tablet%"=="2" (
    :: Check if the to-be-copied file exists   
    if not exist "%tablet1SourcePath%" (
        echo File not found at %tablet1SourcePath%
        echo Please make sure the file exists at the specified path.
        pause
        exit /b
    )

    :: Check if the to-be-copied file is being used by another process and terminate it
    echo Terminating any processes using the to-be-copied file...
    powershell -ExecutionPolicy Bypass -File "%psScriptPath%" -FilePath "%tablet1SourcePath%"
    if %errorLevel% neq 0 (
        echo Error executing PowerShell script.
        pause
        exit /b
    )

    :: Check if the target file exists and if it does -- terminate the process using it
    if not exist "%targetPath%" (
        echo Target file not found at %targetPath%. Moving on...
        pause
        exit /b
    ) else (
        echo Terminating any processes using the to-be-overwritten file in the windows directory...
        powershell -ExecutionPolicy Bypass -File "%psScriptPath%" -FilePath "%targetPath%"
        if %errorLevel% neq 0 (
            echo Error executing PowerShell script.
            pause
            exit /b
        )
    )

    :: Copy the file and overwrite if it exists
    echo Copying file...
    xcopy /Y "%tablet1SourcePath%" "%targetPath%"
    if %errorLevel% neq 0 (
        echo Error copying file.
        pause
        exit /b
    )

    :: Save the new value to the registry
    reg add "%regKey%" /v "%regValue%" /t REG_SZ /d "1" /f
    if %errorLevel% neq 0 (
        echo Error updating registry.
        pause
        exit /b
    )
) else (
    if not exist "%tablet2SourcePath%" (
        echo File not found at %tablet2SourcePath%
        echo Please make sure the file exists at the specified path.
        pause
        exit /b
    )

    :: Check if the to-be-copied file is being used by another process and terminate it
    echo Terminating any processes using the to-be-copied file...
    powershell -ExecutionPolicy Bypass -File "%psScriptPath%" -FilePath "%tablet2SourcePath%"
    if %errorLevel% neq 0 (
        echo Error executing PowerShell script.
        pause
        exit /b
    )

    :: Check if the target file exists and if it does -- terminate the process using it
    if not exist "%targetPath%" (
        echo Target file not found at %targetPath%. Moving on...
        pause
        exit /b
    ) else (
        echo Terminating any processes using the to-be-overwritten file in the windows directory...
        powershell -ExecutionPolicy Bypass -File "%psScriptPath%" -FilePath "%targetPath%"
        if %errorLevel% neq 0 (
            echo Error executing PowerShell script.
            pause
            exit /b
        )
    )

    :: Copy the file and overwrite if it exists
    echo Copying file...
    xcopy /Y "%tablet2SourcePath%" "%targetPath%"
    if %errorLevel% neq 0 (
        echo Error copying file.
        pause
        exit /b
    )

    :: Save the new value to the registry
    reg add "%regKey%" /v "%regValue%" /t REG_SZ /d "2" /f
    if %errorLevel% neq 0 (
        echo Error updating registry.
        pause
        exit /b
    )
)

echo Toggle complete.
pause
endlocal