import subprocess
import sys
import os
import cv2

def resource_path(relative_path):
    """ Get absolute path to resource, works for dev and for PyInstaller """
    try:
        # PyInstaller creates a temp folder and stores path in _MEIPASS
        base_path = sys._MEIPASS
    except Exception:
        base_path = os.path.abspath(".")
    return os.path.join(base_path, relative_path)

def run(cmd):
    # shell=True allows us to run the command string as is
    subprocess.check_call(cmd, shell=True)

if len(sys.argv) < 2:
    print("Usage: pdf2dxf.exe <input_pdf>")
    sys.exit(1)

pdf = sys.argv[1]
base = os.path.splitext(pdf)[0]

# Locate our bundled tools
gs_path = resource_path("gswin64c.exe")
potrace_path = resource_path("potrace.exe")

# 1. Rasterize PDF
# Note: We use the absolute path to the bundled GS
run(f'"{gs_path}" -dNOPAUSE -dBATCH -sDEVICE=png16m -r400 -sOutputFile="{base}.png" "{pdf}"')

# 2. Threshold to pure B/W
img = cv2.imread(f"{base}.png", cv2.IMREAD_GRAYSCALE)
if img is None:
    print("Error: Could not read rasterized image.")
    sys.exit(1)

_, bw = cv2.threshold(img, 150, 255, cv2.THRESH_BINARY)
pbm_path = f"{base}.pbm"
cv2.imwrite(pbm_path, bw)

# 3. Vectorize
run(f'"{potrace_path}" -b dxf "{pbm_path}" -o "{base}.dxf"')

print(f"Success! Created {base}.dxf")