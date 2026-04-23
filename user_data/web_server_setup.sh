#!/bin/bash
set -e

# ── Install & start Apache ──────────────────────────────
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# ── Create web page showing instance ID ────────────────
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head><title>TechCorp Web Server</title></head>
<body style="font-family:Arial;text-align:center;padding:50px;">
  <h1>TechCorp Web Application</h1>
  <p>Instance ID: <strong>$INSTANCE_ID</strong></p>
  <p>Status: Running</p>
</body>
</html>
EOF

# ── Enable password-based SSH access ───────────────────
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart sshd

# ── Create admin user ──────────────────────────────────
useradd -m -s /bin/bash ${admin_username}
echo "${admin_username}:${admin_password}" | chpasswd
usermod -aG wheel ${admin_username}
