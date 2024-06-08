#!/bin/bash

# Redirect stdout and stderr to the appropriate log file and console
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "Starting user data script execution..."

# Update the package list with retries on failure
echo "Updating package list..."
for i in {1..5}; do
    sudo apt-get update && echo "Package list updated successfully." && break || sleep 10
done

# Install Nginx with retries on failure
echo "Installing Nginx..."
for i in {1..5}; do
    sudo apt-get install -y nginx && echo "Nginx installed successfully." && break || sleep 10
done

# Install Docker using the official Docker installation script
echo "Installing Docker using the official Docker installation script..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh && echo "Docker installed successfully."

# Set up Node.js repository
echo "Setting up Node.js repository..."
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

# Install Node.js with retries on failure
echo "Installing Node.js..."
for i in {1..5}; do
    sudo apt-get install -y nodejs && echo "Node.js installed successfully." && break || sleep 10
done

echo "User data script execution completed."
