# Ansible Remediation Playbooks

This collection of playbooks provides self-adaptive remediation capabilities for both Linux and Windows systems. These playbooks are designed to be run through Semaphore UI and can be triggered by an AI system with specific arguments.

## Available Playbooks

### 1. Service Restart (`service_restart.yml`)
Restarts specified services on Linux or Windows systems.

Arguments:
- `target_hosts`: Target host group (default: all)
- `service_to_restart`: Name of the service to restart

Example:
```bash
ansible-playbook service_restart.yml -e "service_to_restart=nginx"
```

### 2. Log Cleanup (`log_cleanup.yml`)
Cleans up old log files and compresses logs on both Linux and Windows systems.

Arguments:
- `target_hosts`: Target host group (default: all)
- `log_directories`: List of log directories to clean (default: ['/var/log'])
- `days_to_keep`: Number of days to retain logs (default: 30)
- `max_size_mb`: Maximum log size in MB for Windows Event Logs (default: 1024)

Example:
```bash
ansible-playbook log_cleanup.yml -e "days_to_keep=15 max_size_mb=512"
```

### 3. Resource Management (`resource_management.yml`)
Manages high CPU/memory processes on both Linux and Windows systems.

Arguments:
- `target_hosts`: Target host group (default: all)
- `cpu_limit`: CPU usage threshold percentage (default: 80)
- `memory_limit`: Memory usage threshold percentage (default: 80)
- `process_exclusions`: List of processes to exclude from management
- `process_action`: Action to take (kill, restart, or nice) (default: kill)

Example:
```bash
ansible-playbook resource_management.yml -e "cpu_limit=90 process_action=nice"
```

## Integration with AI System

These playbooks are designed to be triggered by an AI system through Semaphore UI. The AI system can pass different arguments based on the specific remediation needed. Each playbook accepts default values for its parameters, making them flexible for various scenarios.

## Requirements

- Ansible 2.9 or higher
- For Windows hosts:
  - WinRM setup and configured
  - pywinrm Python package installed on the control node
- For Linux hosts:
  - SSH access configured
  - sudo privileges for the ansible user
