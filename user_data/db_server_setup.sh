#!/bin/bash
set -e

# ── Install PostgreSQL ──────────────────────────────────
amazon-linux-extras enable postgresql14
yum install -y postgresql-server postgresql

# ── Initialize & start PostgreSQL ──────────────────────
postgresql-setup initdb
systemctl start postgresql
systemctl enable postgresql

# ── Create techcorp DB and user ────────────────────────
sudo -u postgres psql <<PSQL
CREATE DATABASE techcorp;
CREATE USER techcorp_user WITH ENCRYPTED PASSWORD 'TechCorpDB2024!';
GRANT ALL PRIVILEGES ON DATABASE techcorp TO techcorp_user;
PSQL

# ── Allow local password auth in pg_hba.conf ───────────
PG_HBA=$(find /var/lib/pgsql -name pg_hba.conf | head -1)
sed -i 's/^local\s\+all\s\+all\s\+peer/local   all             all                                     md5/' "$PG_HBA"
sed -i 's/^host\s\+all\s\+all\s\+127.0.0.1\/32\s\+ident/host    all             all             127.0.0.1\/32            md5/' "$PG_HBA"
systemctl restart postgresql

# ── Enable password-based SSH access ───────────────────
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart sshd

# ── Create admin user ──────────────────────────────────
useradd -m -s /bin/bash ${admin_username}
echo "${admin_username}:${admin_password}" | chpasswd
usermod -aG wheel ${admin_username}
