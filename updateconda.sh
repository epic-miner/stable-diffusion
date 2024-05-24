#!/bin/bash

# Function to deactivate active Conda environment
deactivate_conda_environment() {
    local CURRENT_ENV=$(conda info --envs | grep '*' | awk '{print $1}')
    if [ ! -z "$CURRENT_ENV" ]; then
        deactivate
    fi
}

# Find Conda executable path
CONDA_PATH=$(which conda)

if [ -z "$CONDA_PATH" ]; then
    echo "Conda not found. Please make sure Conda is installed and added to your PATH."
    exit 1
fi

# Extract directory containing Conda executable
CONDA_DIR=$(dirname "$CONDA_PATH")

# Deactivate any active Conda environment
deactivate_conda_environment

# Activate base environment
source "$CONDA_DIR/activate" base

# Update Conda
"$CONDA_PATH" update -y conda

# Update all packages
"$CONDA_PATH" update -y --all

# Deactivate environment
deactivate
