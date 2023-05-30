#!/bin/bash

# Check if a virtual environment is activated
if [[ -z "$VIRTUAL_ENV" ]]; then
    echo "No virtual environment detected. Please activate a virtual environment first."
    exit 1
fi

# Look for the requirements.txt file in the parent directory
parent_dir=$(dirname $(pwd))
requirements_file="$parent_dir/requirements.txt"

if [[ ! -f $requirements_file ]]; then
    echo "requirements.txt file not found in the parent directory."
    exit 1
fi

source venv/bin/activate

# If the file is found, install the requirements using pip
pip install -r $requirements_file

echo "Requirements installed successfully into the virtual environment!"

# Install commitizen and pre-commit if they are not installed
if ! command -v cz &> /dev/null; then
    echo "Commitizen not found. Installing it now..."
    pip install commitizen
fi

if ! command -v pre-commit &> /dev/null; then
    echo "pre-commit not found. Installing it now..."
    pip install pre-commit
fi

# Write the contents of the .cz.yaml file
echo 'commitizen:' > .cz.yaml
echo '  name: cz_conventional_commit' >> .cz.yaml

# Write the contents of the .pre-commit-config.yaml file
echo "exclude: '.git|.tox'" > .pre-commit-config.yaml
echo 'default_stages: [commit]' > .pre-commit-config.yaml
echo 'fail_fast: true' > .pre-commit-config.yaml
echo 'repos:' > .pre-commit-config.yaml
echo '  - repo: https://github.com/commitizen-tools/commitizen' >> .pre-commit-config.yaml
echo '    rev: master' >> .pre-commit-config.yaml
echo '    hooks:' >> .pre-commit-config.yaml
echo '      - id: commitizen' >> .pre-commit-config.yaml
echo '        stages: [commit-msg]' >> .pre-commit-config.yaml

# Install the pre-commit hook
pre-commit install --hook-type commit-msg

echo "Python pre-commit hooks for Commitizen have been set up successfully!"

deactivate