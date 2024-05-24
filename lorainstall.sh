#!/bin/bash

# Function to extract filename from URL
extract_filename() {
    local url="$1"
    echo "${url##*/}"
}

# Function to rename the downloaded file
rename_downloaded_file() {
    local target_dir="$1"
    local old_filename="$2"
    local new_filename="$3"
    mv "$target_dir/$old_filename" "$target_dir/$new_filename"
}

# Target directory for Lora
lora_target_dir="/home/studio-lab-user/stable-diffusion-webui/models/Lora"
mkdir -p "$lora_target_dir"

# Prompt user for Lora download link
read -p "Enter the Lora download link: " lora_wget_link

# Get the filename from the URL
downloaded_filename=$(extract_filename "$lora_wget_link")

# Full path for the downloaded file
downloaded_file_path="$lora_target_dir/$downloaded_filename"

# Download Lora
wget -O "$downloaded_file_path" "$lora_wget_link"
download_result=$?

# Check if the download was successful
if [ $download_result -eq 0 ]; then
    # Ask user for new filename without extension
    read -p "Enter new filename (without extension): " new_filename_without_extension

    # Add .safetensors extension
    new_filename="$new_filename_without_extension.safetensors"

    # Rename the downloaded file
    rename_downloaded_file "$lora_target_dir" "$downloaded_filename" "$new_filename"

    echo -e "\e[1;32mLora downloaded and renamed successfully!\e[0m"
else
    echo -e "\e[1;31mFailed to download Lora. Please check the URL and try again.\e[0m"
fi
