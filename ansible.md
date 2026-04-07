# Ansible Installation and Sample Playbook Guide

This guide walks through installing Ansible, setting up SSH access, defining inventory, and running a sample playbook.

## Step 1: Install Ansible

Install Ansible on your control node using the system package manager.

```bash
sudo apt update
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible
```

### Troubleshooting: User not in sudoers

If your user is not in the sudoers list:

```bash
su
sudo usermod -aG sudo "username"
su "username"
```

## Step 2: Verify Installation

Ensure Ansible is installed successfully.

```bash
ansible --version
```

You can also run:

```bash
ansible
```

### Troubleshooting: UTF-8 locale errors

Option 1 (recommended):

```bash
sudo update-locale LANG=en_US.UTF-8 LC_CTYPE=en_US.UTF-8
```

Then restart your shell/session.

Option 2: edit locale file manually:

```bash
sudo nano /etc/default/locale
```

Add or update:

```text
LANG="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
```

## Step 3: Create an SSH Key

Create a public/private SSH key pair for password-less access.

```bash
ssh-keygen -t rsa -C "devops default"
```

Verify keys:

```bash
ls -la ~/.ssh
cat ~/.ssh/id_rsa.pub
cat ~/.ssh/id_rsa
```

## Step 4: Copy the SSH Key to the Server

Copy your public key to the managed node:

```bash
ssh-copy-id -i ~/.ssh/id_rsa.pub "username@ipaddress"
```

## Step 5: Test the New Key

Verify SSH login without password prompt:

```bash
ssh -i ~/.ssh/id_rsa "username@ipaddress"
```

### Troubleshooting: "Connection refused" on port 22

Install and restart OpenSSH server on the target node:

```bash
sudo apt install -y openssh-server
sudo systemctl restart sshd
```

## Step 6: Connect to the Server

Connect directly to your server:

```bash
ssh "username@ipaddress"
```

## Step 7: Create an Inventory File

Create an Ansible inventory file:

```bash
nano inventory
```

Add your server group and hosts:

```ini
[servers]
localhost ansible_connection = local
```

## Step 8: Connect via Ansible

Run a ping module test using your inventory:

```bash
ansible all -i inventory --key-file ~/.ssh/id_rsa -m ping
```

Alternative inventory-only test:

```bash
ansible all -i inventory -m ping
```

### Troubleshooting: "Permission denied" for SSH key

```bash
chmod 600 ~/.ssh/id_rsa
```

## Step 9: Create a Playbook

Create a playbook file:

```bash
nano playbook.yml
```

Add the following content:

```yaml
- name: Echo
  hosts: servers
  connection: local
  tasks:
    - name: Print ping message
      debug:
        msg: "Hello!"
```

## Step 10: Execute the Playbook

Run your playbook:

```bash
ansible-playbook -i inventory playbook.yml
```
