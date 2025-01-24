#!/bin/bash

PLUGIN_NAME="UnescapePlugin"
OUTPUT_FILE="${PLUGIN_NAME}.sublime-package"
SOURCE_DIR=$(pwd)  # Use the current directory as the source

if [[ ! -d "$SOURCE_DIR" ]]; then
    echo "Error: Source directory does not exist."
    exit 1
fi

if [[ -f "$OUTPUT_FILE" ]]; then
    echo "Removing existing package file: $OUTPUT_FILE"
    rm -f "$OUTPUT_FILE"
fi

# Create the .sublime-package file (zip format)
echo "Creating package file: $OUTPUT_FILE"
zip -r "$OUTPUT_FILE" ./* -x "*.sh"  # Exclude the script itself

if [[ -f "$OUTPUT_FILE" ]]; then
    echo "Package created successfully: $OUTPUT_FILE"
else
    echo "Error: Failed to create package."
    exit 1
fi

echo -e "\nTo install the plugin:"
echo "1. Move $OUTPUT_FILE to the 'Installed Packages' folder in Sublime Text."
echo "2. Restart Sublime Text."
