#!/bin/bash



# Step 1: Check if /usr/games exists and create if necessary, then move SuperMario4Advance.gba and DOOM1.WAD
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

# Step 2: Install required packages
echo "Installing required packages..."
sudo apt update
packages=(mednafen chocolate-doom unzip)
for package in "${packages[@]}"; do
    if sudo apt install -y "$package"; then
        echo "$package installed successfully."
    else
        echo "Failed to install $package. Skipping to the next package."
    fi
done

# Step 3: Unzip mednafen.zip into the home directory
echo "Unzipping mednafen.zip to the home directory..."
unzip -o assets/mednafen.zip -d ~/
if [[ $? -eq 0 ]]; then
    echo "mednafen.zip unzipped successfully."
else
    echo "Failed to unzip mednafen.zip. Please check the file path."
fi

# Step 4: move mednafen.desktop to /usr/share/applications
echo "Moving mednafen.desktop to /usr/share/applications..."
sudo cp assets/mednafen.desktop /usr/share/applications/
if [[ $? -eq 0 ]]; then
    echo "mednafen.desktop moved successfully."
else
    echo "Failed to move mednafen.desktop. Please check the file path."
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


# Step 6: Extract Papirus-PNG.zip to /usr/share/icons/
echo "Extracting Papirus-PNG.zip to /usr/share/icons/..."
sudo unzip -o assets/Papirus-PNG.zip -d /usr/share/icons/
if [[ $? -eq 0 ]]; then
echo "Papirus-PNG.zip extracted successfully."
else
echo "Failed to extract Papirus-PNG.zip. Please check the file path."
fi

# Step 7: Extract Papirus-PNG.zip to /usr/share/icons/
echo "Extracting Papirus-PNG.zip to /usr/share/icons/..."
sudo unzip -o assets/Papirus-PNG.zip -d /usr/share/icons/
if [[ $? -eq 0 ]]; then
echo "Papirus-PNG.zip extracted successfully."
else
echo "Failed to extract Papirus-PNG.zip. Please check the file path."
fi

# Step 8: trigger gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled true to enable the on-screen keyboard
echo "Enabling the on-screen keyboard..."
gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled true
if [[ $? -eq 0 ]]; then
    echo "On-screen keyboard enabled."
else
    echo "Failed to enable on-screen keyboard."
fi

echo "Setup completed with any noted warnings."
