python.exe -m pip install --upgrade pip
pip install pyinstaller
pip install cv2
pip install opencv-python
pyinstaller --onefile --add-binary "potrace.exe;." --add-binary "gswin64c.exe;." --add-binary "gsdll64.dll;." pdf2dxf.py
pause