#!/bin/bash

# Prompt the user for the remote username
read -p "Enter the remote username (e.g. 'john'): " remote_user

# Prompt the user for the remote server or IP
read -p "Enter the remote server (e.g. 'example.com' or '10.0.0.1'): " remote_server

# Prompt for a custom key name
read -p "Enter a name for the new SSH key (e.g. 'my_new_key'): " key_name

# Validate that the key name is not empty
if [ -z "$key_name" ]; then
    echo "Key name cannot be empty. Please run the script again."
    exit 1
fi

# Optional check: ensure a key with this name doesn't already exist
if [ -f "$HOME/.ssh/$key_name" ] || [ -f "$HOME/.ssh/$key_name.pub" ]; then
    echo "A key named '$key_name' already exists. Please choose a different name."
    exit 1
fi

# Generate the SSH key (will prompt for passphrase unless you use -N "")
ssh-keygen -t rsa -b 2048 -f "$HOME/.ssh/$key_name"

# ssh-copy-id will prompt you for the remote password if no key is installed yet
ssh-copy-id -i "$HOME/.ssh/$key_name.pub" "$remote_user@$remote_server"

# Optionally add the key to the local SSH agent
ssh-add "$HOME/.ssh/$key_name"

echo "SSH key '$key_name' has been created and copied to '$remote_user@$remote_server'."
