# Ansible Playbooks - Configuration Guide

## Inventory Configuration

The `inventory` file contains the list of hosts that Ansible will manage. Edit this file to add your servers:

```ini
[web_servers]
webserver1.example.com ansible_host=192.168.1.10
webserver2.example.com ansible_host=192.168.1.11

[database_servers]
dbserver1.example.com ansible_host=192.168.1.20
```

## Password Management

Sensitive information like passwords is stored in the `passwords.vault` file using Ansible Vault for encryption.

### Setting up Ansible Vault

1. **Create/Edit the vault file:**
   ```bash
   ansible-vault create passwords.vault
   ```
   or to edit an existing vault:
   ```bash
   ansible-vault edit passwords.vault
   ```

2. **Example vault content:**
   ```yaml
   ---
   ansible_ssh_pass: "your_ssh_password"
   ansible_become_pass: "your_sudo_password"
   mysql_root_password: "your_mysql_password"
   ```

3. **Encrypt the vault file:**
   ```bash
   ansible-vault encrypt passwords.vault
   ```

### Running Playbooks

To run playbooks with vault-encrypted passwords:

```bash
# Service restart playbook
ansible-playbook -i inventory remediation/service_restart.yml --ask-vault-pass -e service_to_restart=apache2

# Target specific host group
ansible-playbook -i inventory remediation/service_restart.yml --ask-vault-pass -e target_hosts=web_servers -e service_to_restart=nginx

# With additional parameters
ansible-playbook -i inventory remediation/service_restart.yml --ask-vault-pass -e service_to_restart=mysql -e max_attempts=5 -e delay=10
```

## Security Notes

- The `inventory` and `passwords.vault` files are excluded from git via `.gitignore`
- Always encrypt sensitive data using `ansible-vault`
- Use SSH keys when possible instead of passwords
- Store vault passwords securely (consider using external password managers)

## Available Playbooks

### Service Restart (`service_restart.yml`)
Restarts services with comprehensive error handling and diagnostics.

**Parameters:**
- `service_to_restart`: Name of the service to restart (required)
- `target_hosts`: Host group to target (default: all)
- `max_attempts`: Maximum restart attempts (default: 3)
- `delay`: Delay between attempts in seconds (default: 5)

**Example:**
```bash
ansible-playbook -i inventory remediation/service_restart.yml --ask-vault-pass -e service_to_restart=apache2 -e target_hosts=web_servers
```

## Configuration Files

- `ansible.cfg`: Main Ansible configuration
- `inventory`: Host definitions
- `passwords.vault`: Encrypted sensitive data
- `.gitignore`: Excludes sensitive files from version control
