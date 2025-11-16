#!/bin/bash
# update_modpack.sh
# Zips a local folder on Windows (via Python), tracks with Git LFS, and pushes to GitHub

# --- PATHS ---
REPO_ROOT="$(dirname "$0")"
cd "$REPO_ROOT" || exit 1

SOURCE_DIR="$APPDATA/r2modmanPlus-local/REPO/profiles/REPOCymraeg"
OUTPUT_DIR="Mod"
ZIP_NAME="ModPack.zip"
ZIP_PATH="$OUTPUT_DIR/$ZIP_NAME"

# --- ENSURE OUTPUT DIRECTORY EXISTS ---
mkdir -p "$OUTPUT_DIR"

# --- CHECK SOURCE DIRECTORY ---
if [ ! -d "$SOURCE_DIR" ]; then
    echo "ERROR: Source folder not found: $SOURCE_DIR"
    exit 1
fi

echo "Creating zip using Python..."

# --- ZIP USING PYTHON ---
python - <<END
import zipfile, os

source_dir = r"$SOURCE_DIR"
output_path = r"$ZIP_PATH"

# Remove existing zip
if os.path.exists(output_path):
    os.remove(output_path)

with zipfile.ZipFile(output_path, "w", zipfile.ZIP_DEFLATED) as zf:
    for root, dirs, files in os.walk(source_dir):
        # Exclude .doorstop_version folder
        if ".doorstop_version" in dirs:
            dirs.remove(".doorstop_version")
        for f in files:
            file_path = os.path.join(root, f)
            arcname = os.path.relpath(file_path, start=source_dir)
            zf.write(file_path, arcname)
END

echo "Zip created at $ZIP_PATH"

# --- GIT LFS ---
git lfs track "$ZIP_PATH"
git add .gitattributes

# --- COMMIT & PUSH ---
git add "$ZIP_PATH"
git commit -m "Update ModPack.zip (excluded doorstop files)"
git push

echo "Done."
