# Creating an Application with Ansible - Very Basic Guide

This guide covers the basics of using Ansible to create and deploy a simple application.

## What is Ansible?

Ansible is a tool that automates tasks on remote servers using YAML playbooks. It's agentless, meaning you don't need to install anything on target machines (except SSH and Python).

## Basic Playbook Structure

A playbook is a YAML file that contains tasks to execute on servers.

```yaml
---
- name: Application Setup
  hosts: servers
  tasks:
    - name: Task Description
      module_name:
        option: value
```

## Step 1: Install Required Software

Create a playbook to install Node.js and npm:

```yaml
---
- name: Install Node.js Application
  hosts: servers
  tasks:
    - name: Update package manager
      apt:
        update_cache: yes
      become: yes

    - name: Install Node.js
      apt:
        name: nodejs
        state: present
      become: yes

    - name: Install npm
      apt:
        name: npm
        state: present
      become: yes
```

## Step 2: Clone or Create Application Files

```yaml
---
- name: Deploy Application
  hosts: servers
  tasks:
    - name: Clone repository
      git:
        repo: 'https://github.com/username/myapp.git'
        dest: /opt/myapp
        version: main

    - name: Install dependencies
      shell: cd /opt/myapp && npm install
```

## Step 3: Run the Application

```yaml
---
- name: Start Application
  hosts: servers
  tasks:
    - name: Start Node.js app
      shell: cd /opt/myapp && npm start
```

## Step 4: Create Application Directory

```yaml
---
- name: Create Application Structure
  hosts: servers
  tasks:
    - name: Create application directory
      file:
        path: /opt/myapp
        state: directory
        mode: '0755'
      become: yes

    - name: Create logs directory
      file:
        path: /opt/myapp/logs
        state: directory
        mode: '0755'
      become: yes
```

## Step 5: Copy Application Files

```yaml
---
- name: Copy Files to Server
  hosts: servers
  tasks:
    - name: Copy application files
      copy:
        src: ./myapp/
        dest: /opt/myapp/
        mode: '0644'
      become: yes
```

## Step 6: Simple Python Application Example

```yaml
---
- name: Deploy Python Application
  hosts: servers
  tasks:
    - name: Install Python3 and pip
      apt:
        name: ['python3', 'python3-pip']
        state: present
      become: yes

    - name: Create app directory
      file:
        path: /opt/pyapp
        state: directory

    - name: Copy Python app
      copy:
        src: ./app.py
        dest: /opt/pyapp/app.py

    - name: Install Python dependencies
      shell: pip3 install flask
```

## Common Ansible Modules for Applications

| Module | Purpose |
|--------|---------|
| `apt` | Install/remove packages |
| `git` | Clone repositories |
| `copy` | Copy files to servers |
| `file` | Create/delete files/directories |
| `shell` | Run shell commands |
| `systemd` | Manage system services |
| `template` | Deploy configuration files |

## Example: Complete Basic Playbook

```yaml
---
- name: Complete Application Setup
  hosts: servers
  become: yes
  
  tasks:
    - name: Update system
      apt:
        update_cache: yes

    - name: Install dependencies
      apt:
        name: ['nodejs', 'npm', 'git']
        state: present

    - name: Create app directory
      file:
        path: /opt/app
        state: directory
        mode: '0755'

    - name: Clone application
      git:
        repo: 'https://github.com/user/repo.git'
        dest: /opt/app
        version: main

    - name: Install Node packages
      shell: cd /opt/app && npm install

    - name: Run application
      shell: cd /opt/app && npm start &
```

## Example: Apache Web Server Setup

```yaml
---
- name: Setup Simple Web Application Infrastructure
  hosts: localhost
  become: yes

  tasks:
    - name: Install Apache web server
      apt:
        name: apache2
        state: present
        update_cache: yes

    - name: Start and enable Apache service
      service:
        name: apache2
        state: started
        enabled: yes

    - name: Deploy sample web page
      copy:
        dest: /var/www/html/index.html
        content: |
          <html>
          <head><title>My Web App</title></head>
          <body>
          <h1>Welcome to My Web Application</h1>
          <p>Deployed using Ansible</p>
          </body>
          </html>

    - name: Restart Apache
      service:
        name: apache2
        state: restarted
```

## Running Your Playbook

```bash
# Run on all servers in inventory
ansible-playbook -i inventory playbook.yml

# Run on specific host group
ansible-playbook -i inventory playbook.yml -l servers

# Run with extra verbosity to see details
ansible-playbook -i inventory playbook.yml -v
```

## Tips for Beginners

- Start with simple tasks and build up complexity
- Use `become: yes` to run tasks with sudo
- Use `state: present` to ensure packages are installed
- Use `handlers` to restart services after configuration changes
- Test on non-production servers first
- Use variables to make playbooks reusable

## Next Steps

- Learn about variables and loops
- Explore roles for organizing playbooks
- Set up error handling and notifications
- Create templates for configuration files
