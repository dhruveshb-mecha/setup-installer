#!/bin/bash



# Step 1: Check if /usr/games exists and create if necessary, then move SuperMario4Advance.gba and Doom1.gba
echo "Preparing to move game files to /usr/games..."
if [[ ! -d /usr/games ]]; then
    echo "/usr/games does not exist. Creating directory..."
    sudo mkdir -p /usr/games
fi

sudo cp assets/SuperMario4Advance.gba /usr/games/
sudo cp assets/Doom1.gba /usr/games/
if [[ $? -eq 0 ]]; then
    echo "Game files moved successfully."
else
    echo "Failed to move game files. Please check permissions or file paths."
fi

# Step 2: Install required packages
echo "Installing required packages..."
sudo apt update
packages=(mednafen chocolate-doom unzip htop)
for package in "${packages[@]}"; do
    if sudo apt install -y "$package"; then
        echo "$package installed successfully."
    else
        echo "Failed to install $package. Skipping to the next package."
    fi
done

# Step 3: Set up mednafen configuration
echo "Setting up mednafen configuration..."

# Create the ~/.mednafen directory if it doesn't already exist
rm -rf ~/.mednafen
mkdir -p ~/.mednafen

# Copy mednafen.cfg into the ~/.mednafen directory
cp assets/mednafen.cfg ~/.mednafen/

# Check if the copy operation was successful
if [[ $? -eq 0 ]]; then
    echo "mednafen.cfg copied successfully to ~/.mednafen."
else
    echo "Failed to copy mednafen.cfg. Please check the file path."
fi

# Step 4: move mednafen.desktop to /usr/share/applications
echo "Moving mednafen.desktop to /usr/share/applications..."
sudo cp assets/mednafen.desktop /usr/share/applications/
if [[ $? -eq 0 ]]; then
    echo "mednafen.desktop moved successfully."
else
    echo "Failed to move mednafen.desktop. Please check the file path."
fi


# Step 5: Set up .mednafen directory permissions and ownership
echo "Setting up .mednafen directory permissions and ownership..."
sudo chown -R mecha:mecha ~/.mednafen
sudo chmod 700 ~/.mednafen
if [[ $? -eq 0 ]]; then
    echo ".mednafen directory permissions set successfully."
else
    echo "Failed to set .mednafen directory permissions."
fi

# Step 6: Alacritty migrate
echo "Migrating alacritty..."
alacritty migrate
if [[ $? -eq 0 ]]; then
    echo "alacritty migrated successfully."
else
    echo "Failed to migrate alacritty Please check the file path."
fi

# Step 6: Extract Papirus-PNG.zip to /usr/share/icons/
echo "Extracting Papirus-PNG.zip to /usr/share/icons/..."
sudo unzip -o assets/Papirus-PNG.zip -d /usr/share/icons/
if [[ $? -eq 0 ]]; then
echo "Papirus-PNG.zip extracted successfully."
else
echo "Failed to extract Papirus-PNG.zip. Please check the file path."
fi

# Step 6: Remove cursor
echo "Removing cursor..."
sudo cp -f assets/default /usr/share/icons/Adwaita/cursors/
if [[ $? -eq 0 ]]; then
    echo "cursor removed successfully."
else
    echo "Failed to remove cursor."
fi

# Step 7: Remove unnecessary desktop files
echo "Removing unnecessary desktop files..."
sudo rm /usr/share/applications/org.chocolate_doom.* /usr/share/applications/mednaffe.desktop /usr/share/applications/io.github.* /usr/share/applications/dsda-doom.desktop
if [[ $? -eq 0 ]]; then
    echo "unnecessary desktop files removed successfully."
else
    echo "Failed to remove unnecessary desktop files."
fi

echo "Setup completed with any noted warnings."
