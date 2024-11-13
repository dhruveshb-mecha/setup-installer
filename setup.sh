#!/bin/bash

# Step 1: Move alacritty to /usr/bin
echo "Moving alacritty to /usr/bin..."
sudo cp assets/alacritty /usr/bin/
if [[ $? -eq 0 ]]; then
    echo "alacritty moved successfully."
else
    echo "Failed to move alacritty. Please check permissions or file path."
    exit 1
fi

# Step 2: Check if /usr/games exists and create if necessary, then move SuperMario4Advance.gba
echo "Preparing to move SuperMario4Advance.gba to /usr/games..."
if [[ ! -d /usr/games ]]; then
    echo "/usr/games does not exist. Creating directory..."
    sudo mkdir -p /usr/games
    if [[ $? -ne 0 ]]; then
        echo "Failed to create /usr/games. Exiting."
        exit 1
    fi
fi

sudo cp assets/SuperMario4Advance.gba /usr/games/
if [[ $? -eq 0 ]]; then
    echo "SuperMario4Advance.gba moved successfully."
else
    echo "Failed to move SuperMario4Advance.gba. Please check permissions or file path."
    exit 1
fi

# Step 3: Install required packages
echo "Installing required packages..."
sudo apt update
packages=(mednafen mecha-connect firefox-esr nautilus chocolate-doom)
for package in "${packages[@]}"; do
    sudo apt install -y "$package"
    if [[ $? -ne 0 ]]; then
        echo "Failed to install $package. Please check your package sources or internet connection."
        exit 1
    else
        echo "$package installed successfully."
    fi
done

echo "Setup completed successfully."
