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

# Target directory for checkpoints
checkpoints_target_dir="/home/studio-lab-user/stable-diffusion-webui/models/Stable-diffusion"
mkdir -p "$checkpoints_target_dir"

# Prompt user for checkpoints download link
read -p "Enter the checkpoints download link: " checkpoints_wget_link

# Download checkpoints quietly with progress bar
wget -q --show-progress -O "$checkpoints_target_dir/$(extract_filename "$checkpoints_wget_link")" "$checkpoints_wget_link"
download_result=$?

# Check if the download was successful
if [ $download_result -eq 0 ]; then
    # Get the downloaded filename
    downloaded_checkpoints_filename=$(extract_filename "$checkpoints_wget_link")

    # Ask user for new filename for checkpoints without extension
    read -p "Enter new filename for checkpoints (without extension): " new_checkpoints_filename_without_extension

    # Add .safetensors extension to checkpoints filename
    new_checkpoints_filename="$new_checkpoints_filename_without_extension.safetensors"

    # Rename the downloaded checkpoints file
    rename_downloaded_file "$checkpoints_target_dir" "$downloaded_checkpoints_filename" "$new_checkpoints_filename"

    echo -e "\e[1;32mCheckpoints downloaded and renamed successfully!\e[0m"
else
    echo -e "\e[1;31mFailed to download checkpoints. Please check the URL and try again.\e[0m"
fi
