@echo off
setlocal

:: 1. Create the virtual environment folder if it doesn't exist
if not exist "venv" (
    echo Creating virtual environment...
    python -m venv venv
)

:: 2. Activate the environment
:: Use 'call' so the batch script doesn't stop after activation
call venv\Scripts\activate

:: 3. Upgrade pip and install dependencies
echo Installing dependencies...
python -m pip install --upgrade pip
pip install pyinstaller opencv-python numpy

:: 4. Run PyInstaller
echo Building executable...
pyinstaller --noconfirm --onefile ^
    --add-binary "dependencies/potrace.exe;." ^
    --add-binary "dependencies/gswin64c.exe;." ^
    --add-binary "dependencies/gsdll64.dll;." ^
    pdf2dxf.py

:: 5. Cleanup
echo Deactivating environment...
call deactivate

echo Done! Your EXE is in the 'dist' folder.
pause