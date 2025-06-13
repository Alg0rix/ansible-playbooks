#!/bin/bash
# Emergency Apache Troubleshooting Script
# Run this script to quickly diagnose Apache issues

echo "=== Apache Emergency Diagnostics ==="
echo "Timestamp: $(date)"
echo

echo "1. Testing Apache configuration syntax..."
httpd -t
echo "Apache config test exit code: $?"
echo

echo "2. Checking for port conflicts..."
netstat -tulpn | grep -E ':(80|443)\s'
echo

echo "3. Checking Apache processes..."
ps aux | grep httpd | grep -v grep
echo

echo "4. Checking recent Apache error logs..."
tail -20 /var/log/httpd/error_log 2>/dev/null || echo "Error log not accessible"
echo

echo "5. Checking systemd journal for Apache..."
journalctl -u httpd -n 20 --no-pager
echo

echo "6. Checking SELinux status..."
getenforce 2>/dev/null || echo "SELinux not available"
echo

echo "7. Checking disk space..."
df -h /var/log /tmp /var/www
echo

echo "8. Checking Apache configuration files..."
ls -la /etc/httpd/conf/httpd.conf
echo

echo "9. Checking document root..."
ls -la /var/www/html/
echo

echo "10. Attempting to start Apache manually..."
systemctl start httpd
echo "Start attempt exit code: $?"
echo

echo "11. Final status check..."
systemctl status httpd --no-pager
