#!/bin/bash
# download_large_file.sh
# Downloads a single large zip file from Google Drive

# --- CONFIG ---
PYTHON_PATH="/c/Users/iwanw/AppData/Local/Programs/Python/Python314/python.exe"
DATA_DIR="data"
GDRIVE_FILE_ID="1hXY7ofxGXL6ALVEXckGRi0BmgYrHvt0B"
ZIP_NAME="large_file.zip"

# --- CREATE DATA DIRECTORY ---
mkdir -p "$DATA_DIR"

# --- CHECK PYTHON ---
if [ ! -f "$PYTHON_PATH" ]; then
    echo "Python not found at $PYTHON_PATH. Please adjust PYTHON_PATH in the script."
    exit 1
fi

# --- CHECK PIP ---
"$PYTHON_PATH" -m ensurepip --default-pip >/dev/null 2>&1
"$PYTHON_PATH" -m pip install --upgrade pip --user

# --- CHECK GDOWN ---
if ! "$PYTHON_PATH" -m pip show gdown >/dev/null 2>&1; then
    echo "Installing gdown..."
    "$PYTHON_PATH" -m pip install --user gdown
fi

# --- DOWNLOAD ZIP FILE ---
echo "Downloading Google Drive file $GDRIVE_FILE_ID into $DATA_DIR/$ZIP_NAME..."
"$PYTHON_PATH" -m gdown "https://drive.google.com/uc?id=$GDRIVE_FILE_ID" -O "$DATA_DIR/$ZIP_NAME"

echo "Download complete. File saved to $DATA_DIR/$ZIP_NAME"
