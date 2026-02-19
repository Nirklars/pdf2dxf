@echo off
setlocal enabledelayedexpansion

:: 1. Set the path to your compiled tool
:: If it's in the same folder as this bat file, just use "pdf2dxf.exe"
set "TOOL_PATH=%~dp0pdf2dxf.exe"

:: 2. Start from current directory
set "ROOT_FOLDER=%cd%"

echo --- Starting Batch PDF to DXF Conversion ---
echo Target Folder: %ROOT_FOLDER%
echo --------------------------------------------

:: 3. Loop through all .pdf files recursively (/R)
for /R "%ROOT_FOLDER%" %%F in (*.pdf) do (
    
    :: Check if the file is a PDF (prevents weird edge cases)
    if /I "%%~xF"==".pdf" (
        echo.
        echo Found: %%~nxF
        
        :: Run your compiled tool on the file
        :: We use quotes around "%%F" in case there are spaces in the path
        "!TOOL_PATH!" "%%F"
        
        if !errorlevel! equ 0 (
            echo [SUCCESS] Converted %%~nF.dxf
        ) else (
            echo [ERROR] Failed to convert %%~nF
        )
    )
)

echo.
echo --------------------------------------------
echo All files processed.
pause