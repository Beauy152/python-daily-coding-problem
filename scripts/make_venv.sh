#!/bin/bash

# Check if python3-venv is installed
if ! command -v python3 -m venv &> /dev/null; then
    echo "python3-venv could not be found. Installing it now..."
    sudo apt-get install python3-venv -y
fi

# Create the virtual environment
python3 -m venv venv

echo "Virtual environment '$1' created successfully!"
echo "Run 'source venv/bin/activate' to activate the virtual environment."