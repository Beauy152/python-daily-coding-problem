#!/bin/bash

# Check if a virtual environment is activated
if [[ -z "$VIRTUAL_ENV" ]]; then
    echo "No virtual environment detected. Please activate a virtual environment first."
    exit 1
fi

# Define the parent directory as the directory containing the current working directory
parent_dir=$(pwd)

# Create a requirements.txt file in the parent directory
pip freeze > "requirements.txt"

echo "requirements.txt file has been successfully created in the parent directory!"
