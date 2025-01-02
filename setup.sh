#!/bin/bash

# Step 1: Move alacritty to /usr/bin and set permissions to 755
echo "Moving alacritty to /usr/bin and setting permissions to 755..."
sudo cp assets/alacritty /usr/bin/
sudo chmod 755 /usr/bin/alacritty
if [[ $? -eq 0 ]]; then
    echo "alacritty moved and permissions set successfully."
else
    echo "Failed to set up alacritty. Please check permissions or file path."
fi



# Step 2: Check if /usr/games exists and create if necessary, then move SuperMario4Advance.gba and DOOM1.WAD
echo "Preparing to move game files to /usr/games..."
if [[ ! -d /usr/games ]]; then
    echo "/usr/games does not exist. Creating directory..."
    sudo mkdir -p /usr/games
fi

sudo cp assets/SuperMario4Advance.gba /usr/games/
sudo cp assets/DOOM1.WAD /usr/games/
if [[ $? -eq 0 ]]; then
    echo "Game files moved successfully."
else
    echo "Failed to move game files. Please check permissions or file paths."
fi

# Step 3: Install required packages
echo "Installing required packages..."
sudo apt update
packages=(mednafen mecha-connect firefox-esr nautilus chocolate-doom unzip)
for package in "${packages[@]}"; do
    if sudo apt install -y "$package"; then
        echo "$package installed successfully."
    else
        echo "Failed to install $package. Skipping to the next package."
    fi
done

# Step 4: Unzip mednafen.zip into the home directory
echo "Unzipping mednafen.zip to the home directory..."
unzip -o assets/mednafen.zip -d ~/
if [[ $? -eq 0 ]]; then
    echo "mednafen.zip unzipped successfully."
else
    echo "Failed to unzip mednafen.zip. Please check the file path."
fi


# Step 5: Set up .config directory permissions and ownership
echo "Setting up .config directory permissions and ownership..."
sudo chown -R mecha:mecha ~/.config
sudo chmod 700 ~/.config
if [[ $? -eq 0 ]]; then
    echo ".config directory permissions set successfully."
else
    echo "Failed to set .config directory permissions."
fi



echo "Setup completed with any noted warnings."
