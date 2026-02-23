# pdf2dxf-converter

An automated command-line tool for Windows that converts and vectorizes PDF documents into DXF format. This tool automates the pipeline of rasterizing a PDF, performing black-and-white thresholding, and tracing the result into a CAD-ready vector file. To convert DXF to DWG open it in Autodesk AutoCAD or similar software and save as.

https://github.com/Nirklars/pdf2dxf

<img src="/example/screenshot example pdf to dxf.png" alt="Preview" width="400">

## How it Works

The tool follows a three-stage conversion:
1. **Ghostscript**: Rasterizes the PDF into a high-resolution PNG.
2. **OpenCV**: Processes the image into a clean, high-contrast black-and-white PBM file.
3. **Potrace**: Vectorizes the PBM file into a DXF (AutoCAD Drawing Exchange Format).

## Features
- **Standalone EXE**: No Python installation required for end-users.
- **Batch Processing**: Includes a `.bat` script to process entire directories/subfolders.
- **High Resolution**: Default 400 DPI rasterization for accurate vector tracing.

## Installation

### Option A: Using the Compiled Version (Recommended)
1. Download the latest `pdf2dxf.exe` and `convert-all-pdf-files-in-folder.bat` from the [Releases](#) page.
2. Place both files in the folder containing your PDFs.
3. Run `convert-all-pdf-files-in-folder.bat` to convert all files at once.
4. OPTIONAL: Convert a single file by opening a command line or power shell in the current folder and typing `pdf2dxf.exe` followed by the filename of the PDF you want to convert.

### Option B: Building from Source
If you want to modify the code:
1. Install Python 3.x.
2. Install dependencies: `pip install opencv-python numpy pyinstaller`.
3. Ensure `potrace.exe`, `gswin64c.exe`, and `gsdll64.dll` are in the root directory.
4. Run the provided `compile.bat` or use:
   ```powershell
   pyinstaller --onefile --add-binary "dependencies/potrace.exe;." --add-binary "dependencies/gswin64c.exe;." --add-binary "dependencies/gsdll64.dll;." pdf2dxf.py
   ```

## Known limitations and end notes
- Limited to black and white image tracing. Colors will not affect the result.
- The tool uses outline tracing, meaning it follows edges of solid objects. This may not "work" for all applications. Try setting the whole drawing to the same color with a very narrow line weight in your AutoCAD plot styles.
- Scaling is not consistent. You need to properly scale the result in AutoCAD using SCALE by REFERENCE.
- For more specific and detailed vectorization try Inkscape https://inkscape.org/

## Dependencies & Licensing

This project is a wrapper that utilizes several open-source tools. By using this software, you agree to the terms of the following licenses:
They are bundled for ease of use under fair use.

- **Ghostscript**: Used under the [GNU AGPLv3](https://artifex.com/licensing/gnu-agpl-v3).
- **Potrace**: Used under the [GNU GPLv2](https://potrace.sourceforge.net/#license).
- **OpenCV**: Licensed under the [Apache License 2.0](https://opencv.org/license/).
- **NumPy**: Licensed under the [BSD 3-Clause License](https://numpy.org/doc/stable/license.html).

The source code for this `pdf2dxf` wrapper itself is provided under the [MIT License](LICENSE.txt).