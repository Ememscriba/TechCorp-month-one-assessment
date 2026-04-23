# TechCorp AWS Infrastructure — Terraform Assessment

## Architecture Overview
- VPC (10.0.0.0/16) across 2 AZs (us-east-1a, us-east-1b)
- 2 public subnets + 2 private subnets
- Internet Gateway + 2 NAT Gateways
- Bastion Host (public) → Web Servers x2 (private) → DB Server (private)
- Application Load Balancer serving traffic to both web servers

---

## Prerequisites
- AWS CLI configured (`aws configure`)
- Terraform >= 1.0 installed
- An EC2 Key Pair created in `us-east-1`

---

## Deployment Steps

### 1. Clone / enter the project folder
```bash
cd terraform-assessment
```

### 2. Create your tfvars file
```bash
cp terraform.tfvars.example terraform.tfvars
```
Edit `terraform.tfvars` and fill in:
- `key_pair_name` — your EC2 key pair name
- `my_ip` — your public IP in CIDR format (get it: `curl ifconfig.me` then append `/32`)
- `admin_password` — strong password for techadmin user on private servers

### 3. Initialize Terraform
```bash
terraform init
```

### 4. Plan
```bash
terraform plan
```
Review output. Should show ~25 resources to create.

### 5. Apply
```bash
terraform apply
```
Type `yes` when prompted. Takes ~5 minutes (NAT Gateways are slow).

### 6. Get outputs
```bash
terraform output
```
Note the `bastion_public_ip` and `load_balancer_dns`.

---

## Accessing Servers

### SSH to Bastion
```bash
ssh -i ~/.ssh/YOUR_KEY.pem ec2-user@<bastion_public_ip>
```

### SSH from Bastion to Web Servers (password)
```bash
ssh techadmin@<web_1_private_ip>
# Enter the admin_password you set in tfvars
```

### SSH from Bastion to DB Server (password)
```bash
ssh techadmin@<db_private_ip>
```

### Connect to PostgreSQL on DB Server
```bash
# Once SSH'd into DB server:
psql -U techcorp_user -d techcorp -h 127.0.0.1
# Password: TechCorpDB2024!
```

### Access Web App
Open in browser:
```
http://<load_balancer_dns>
```
Refresh to see traffic hitting both instances (different instance IDs).

---

## ⚠️ Cleanup — Run Immediately After Taking Screenshots

```bash
terraform destroy
```
Type `yes`. This removes ALL resources and stops all charges.

**Most expensive resources (destroy first if needed):**
- NAT Gateways (~$0.045/hr each)
- EC2 Instances
- Application Load Balancer
- Elastic IPs (release if not attached)
