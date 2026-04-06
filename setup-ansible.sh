#!/bin/bash

# Ansible Setup Automation Script
# This script automates all Ansible installation and configuration steps

set -e

echo "=========================================="
echo "Ansible Setup Automation Script"
echo "=========================================="
echo ""

# Step 1: Install Ansible
echo "[Step 1] Installing Ansible..."
sudo apt update -y
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible
echo "✓ Ansible installed"
echo ""

# Step 2: Verify Installation
echo "[Step 2] Verifying Ansible installation..."
ansible --version
echo "✓ Ansible verified"
echo ""

# Step 3: Create SSH Key
echo "[Step 3] Setting up SSH key..."
SSH_KEY_PATH="$HOME/.ssh/id_rsa"

if [ -f "$SSH_KEY_PATH" ]; then
    echo "SSH key already exists at $SSH_KEY_PATH"
    read -p "Do you want to regenerate it? (y/n): " regenerate
    if [ "$regenerate" = "y" ]; then
        ssh-keygen -t rsa -C "devops default" -N "" -f "$SSH_KEY_PATH"
        echo "✓ SSH key regenerated"
    else
        echo "Using existing SSH key"
    fi
else
    ssh-keygen -t rsa -C "devops default" -N "" -f "$SSH_KEY_PATH"
    echo "✓ SSH key created"
fi
echo ""

# Step 4: Verify SSH keys
echo "[Step 4] Verifying SSH keys..."
ls -la "$HOME/.ssh"
echo "✓ SSH keys verified"
echo ""

# Step 5: Copy SSH key to server
echo "[Step 5] Copying SSH key to managed node..."
read -p "Enter target server address (user@ipaddress): " target_server

if [ -z "$target_server" ]; then
    echo "No target server provided. Skipping SSH key copy."
else
    ssh-copy-id -i "$SSH_KEY_PATH.pub" "$target_server"
    echo "✓ SSH key copied to $target_server"
fi
echo ""

# Step 6: Test SSH connection
echo "[Step 6] Testing SSH connection..."
if [ -n "$target_server" ]; then
    if ssh -i "$SSH_KEY_PATH" "$target_server" "echo 'SSH connection successful'" 2>/dev/null; then
        echo "✓ SSH connection successful"
    else
        echo "⚠ SSH connection failed. Please check credentials."
    fi
else
    echo "Skipping SSH test (no server provided)"
fi
echo ""

# Step 7: Create inventory file
echo "[Step 7] Creating Ansible inventory..."
INVENTORY_FILE="inventory"

if [ -f "$INVENTORY_FILE" ]; then
    read -p "Inventory file already exists. Overwrite? (y/n): " overwrite
    if [ "$overwrite" != "y" ]; then
        echo "Keeping existing inventory"
        echo ""
    else
        cat > "$INVENTORY_FILE" << 'EOF'
[servers]
EOF
        read -p "Enter server IP(s) (space-separated, or press Enter to skip): " servers
        for server in $servers; do
            echo "$server" >> "$INVENTORY_FILE"
        done
        echo "✓ Inventory created at $INVENTORY_FILE"
        cat "$INVENTORY_FILE"
    fi
else
    cat > "$INVENTORY_FILE" << 'EOF'
[servers]
EOF
    read -p "Enter server IP(s) (space-separated, or press Enter to skip): " servers
    if [ -n "$servers" ]; then
        for server in $servers; do
            echo "$server" >> "$INVENTORY_FILE"
        done
    fi
    echo "✓ Inventory created at $INVENTORY_FILE"
    if [ -n "$servers" ]; then
        cat "$INVENTORY_FILE"
    fi
fi
echo ""

# Step 8: Test Ansible connectivity
echo "[Step 8] Testing Ansible connectivity..."
if [ -f "$INVENTORY_FILE" ] && [ -s "$INVENTORY_FILE" ]; then
    if ansible all -i "$INVENTORY_FILE" --key-file "$SSH_KEY_PATH" -m ping 2>/dev/null; then
        echo "✓ Ansible ping successful"
    else
        echo "⚠ Ansible ping failed. Check inventory and SSH keys."
    fi
else
    echo "Skipping Ansible test (no inventory)"
fi
echo ""

# Step 9: Create playbook
echo "[Step 9] Creating sample playbook..."
PLAYBOOK_FILE="playbook.yml"

if [ -f "$PLAYBOOK_FILE" ]; then
    read -p "Playbook already exists. Overwrite? (y/n): " overwrite_playbook
    if [ "$overwrite_playbook" != "y" ]; then
        echo "Keeping existing playbook"
    else
        cat > "$PLAYBOOK_FILE" << 'EOF'
- name: Echo
  hosts: servers
  connection: local
  tasks:
    - name: Print ping message
      debug:
        msg: "Hello from Ansible!"
EOF
        echo "✓ Playbook created at $PLAYBOOK_FILE"
        cat "$PLAYBOOK_FILE"
    fi
else
    cat > "$PLAYBOOK_FILE" << 'EOF'
- name: Echo
  hosts: servers
  connection: local
  tasks:
    - name: Print ping message
      debug:
        msg: "Hello from Ansible!"
EOF
    echo "✓ Playbook created at $PLAYBOOK_FILE"
    cat "$PLAYBOOK_FILE"
fi
echo ""

# Step 10: Execute playbook
echo "[Step 10] Running playbook..."
if [ -f "$INVENTORY_FILE" ] && [ -s "$INVENTORY_FILE" ] && [ -f "$PLAYBOOK_FILE" ]; then
    read -p "Execute playbook now? (y/n): " execute_playbook
    if [ "$execute_playbook" = "y" ]; then
        ansible-playbook -i "$INVENTORY_FILE" --key-file "$SSH_KEY_PATH" "$PLAYBOOK_FILE"
        echo "✓ Playbook executed"
    else
        echo "To run the playbook later, execute:"
        echo "  ansible-playbook -i $INVENTORY_FILE --key-file $SSH_KEY_PATH $PLAYBOOK_FILE"
    fi
else
    echo "Cannot run playbook (missing inventory or playbook file)"
fi
echo ""

echo "=========================================="
echo "Ansible setup complete!"
echo "=========================================="
echo ""
echo "Quick reference:"
echo "  Inventory file: $INVENTORY_FILE"
echo "  Playbook file: $PLAYBOOK_FILE"
echo "  SSH key: $SSH_KEY_PATH"
echo ""
echo "To run commands later:"
echo "  ansible all -i $INVENTORY_FILE --key-file $SSH_KEY_PATH -m ping"
echo "  ansible-playbook -i $INVENTORY_FILE --key-file $SSH_KEY_PATH $PLAYBOOK_FILE"
echo ""
