# Deployment Evidence — TechCorp AWS Infrastructure
### Month 1 Assessment | Student: Emem V. John | Region: us-east-1 | Tool: Terraform

---

## Evidence 1: Terraform Plan — Beginning of Execution Plan

This screenshot shows the start of the `terraform plan` output. Terraform analyzed all configuration files and generated a full execution plan. The first resource shown is `aws_eip.bastion` — the Elastic IP for the Bastion Host — confirming that Terraform correctly parsed all 30 resource definitions before any infrastructure was deployed.

![Terraform Plan - Start] <img width="907" height="473" alt="Screenshot from 2026-04-22 22-00-31" src="https://github.com/user-attachments/assets/8a396346-34f1-42c8-ada5-d3dcb6e7b051" />


---

## Evidence 2: Terraform Plan — VPC Resource Definition

This screenshot shows the planned creation of the `aws_vpc.main` resource — the core network for the TechCorp infrastructure. The plan confirms the CIDR block is set to `10.0.0.0/16`, DNS hostnames are enabled, DNS support is enabled, and the Name tag is set to `techcorp-vpc`. All values match the project requirements exactly.

![Terraform Plan - VPC] <img width="674" height="517" alt="Screenshot from 2026-04-22 21-48-27" src="https://github.com/user-attachments/assets/799ed8e9-8773-4f5f-94e3-5b67f28e9c02" />


---

## Evidence 3: Terraform Plan — Bastion Security Group

This screenshot shows the planned creation of the Bastion Host security group. The ingress rule restricts SSH (port 22) access to a single IP address — `41.58.204.128/32` — which is the engineer's current public IP address. This ensures that only the authorized administrator can SSH into the Bastion Host, meeting the security isolation requirement of the assessment.

![Terraform Plan - Bastion Security Group] <img width="674" height="517" alt="Screenshot from 2026-04-22 21-29-48" src="https://github.com/user-attachments/assets/49292495-989b-4ef0-aeba-82f65396b550" />


---

## Evidence 4: Terraform Plan — Summary (30 Resources)

This screenshot shows the final summary line of the `terraform plan` command. Terraform confirmed a total of **30 resources to be created**, with 0 changes and 0 destructions. The outputs section lists all expected values: `bastion_public_ip`, `db_private_ip`, `load_balancer_dns`, `vpc_id`, `web_1_private_ip`, and `web_2_private_ip`. No errors were found in the configuration.

![Terraform Plan - Summary] <img width="1294" height="561" alt="Screenshot from 2026-04-22 21-27-44" src="https://github.com/user-attachments/assets/67b70f0f-73f2-462d-b62c-91df158b4563" />
---

## Evidence 5: Terraform Apply — Infrastructure Successfully Deployed

This screenshot shows the successful completion of `terraform apply`. All 30 AWS resources were created without errors. The outputs section displays the actual values assigned by AWS:
- **Bastion Public IP:** 54.162.165.36
- **DB Private IP:** 10.0.3.58
- **Load Balancer DNS:** techcorp-alb-67810229.us-east-1.elb.amazonaws.com
- **VPC ID:** vpc-0ed1580dec21ca25a
- **Web Server 1 IP:** 10.0.3.160
- **Web Server 2 IP:** 10.0.4.149

![Terraform Apply - Complete] <img width="907" height="473" alt="Screenshot from 2026-04-22 22-49-50" src="https://github.com/user-attachments/assets/7a6bf630-45a8-44bc-9241-87d4168fc555" />

---

## Evidence 6: SSH Access — Bastion Host

This screenshot demonstrates successful SSH access to the Bastion Host using the EC2 key pair. The connection was made from the engineer's local machine directly to the Bastion's Elastic IP address (`54.162.165.36`) using the command:

```
ssh -i ~/.ssh/techcorp-key.pem ec2-user@54.162.165.36
```

The Amazon Linux 2 welcome banner and the prompt `[ec2-user@ip-10-0-1-25 ~]$` confirm the Bastion Host is running and accessible. The Bastion serves as the secure entry point for all administrative access to the private network.

![SSH - Bastion Host] <img width="962" height="309" alt="Screenshot from 2026-04-22 22-59-17" src="https://github.com/user-attachments/assets/1d43f3ed-7c06-4290-ab3d-304540bce9e3" />


---

## Evidence 7: SSH Access — Web Server 1 (via Bastion)

This screenshot shows successful SSH access to Web Server 1 (private IP: `10.0.3.160`) via the Bastion Host. Since Web Server 1 is deployed in a private subnet with no direct internet access, the connection was routed through the Bastion using the EC2 key pair. The prompt `[ec2-user@ip-10-0-3-160 ~]$` confirms the engineer is inside the first web server instance running in the private subnet in `us-east-1a`.

![SSH - Web Server 1] <img width="962" height="359" alt="Screenshot from 2026-04-22 22-58-22" src="https://github.com/user-attachments/assets/af77d82e-8ea2-43a2-9c14-73433d9527e3" />

---

## Evidence 8: SSH Access — Web Server 2 (via Bastion)

This screenshot shows successful SSH access to Web Server 2 (private IP: `10.0.4.149`) via the Bastion Host. Web Server 2 is deployed in a different private subnet (`us-east-1b`) to ensure high availability across multiple availability zones. The prompt `[ec2-user@ip-10-0-4-149 ~]$` confirms access to the second web server, demonstrating multi-AZ connectivity through the Bastion.

![SSH - Web Server 2] <img width="1000" height="455" alt="Screenshot from 2026-04-22 23-01-05" src="https://github.com/user-attachments/assets/dc56507a-dca0-4939-91bc-9fefeadabc3a" />



---

## Evidence 9: SSH Access — Database Server (via Bastion)

This screenshot shows successful SSH access to the Database Server (private IP: `10.0.3.58`) via the Bastion Host. The DB server is in a private subnet and is only accessible through the Bastion, as enforced by the database security group which allows SSH only from the Bastion security group. The prompt `[ec2-user@ip-10-0-3-58 ~]$` confirms successful access to the `t3.small` database instance.

![SSH - Database Server] <img width="1000" height="388" alt="Screenshot from 2026-04-22 23-12-33" src="https://github.com/user-attachments/assets/da3b3820-2a68-4d36-9c99-2d48201c472b" />

---

## Evidence 10: PostgreSQL — Database Connection Established

This screenshot shows a successful connection to the PostgreSQL 14 database on the DB server. The connection was made using:

```
psql -U techcorp_user -d techcorp -h 127.0.0.1
```

The `techcorp=>` prompt confirms that the `techcorp` database was created successfully, the `techcorp_user` account is active, and PostgreSQL is running and accepting authenticated connections on the database server.

![PostgreSQL - Connected] <img width="1000" height="196" alt="Screenshot from 2026-04-23 04-16-58" src="https://github.com/user-attachments/assets/8419e3c4-6854-4a5f-ae09-c93605df459a" />

---

## Evidence 11: PostgreSQL — List of Databases

This screenshot shows the output of the `\l` command inside PostgreSQL, which lists all databases on the server. The `techcorp` database is visible, and the access privileges column shows `techcorp_user=CTc/postgres`, confirming that `techcorp_user` has been granted the correct permissions. This validates the complete PostgreSQL setup as required by the assessment.

![PostgreSQL - Database List] <img width="1054" height="292" alt="Screenshot from 2026-04-23 04-17-49" src="https://github.com/user-attachments/assets/cc3be94b-e743-4810-92a2-a9ed2c5b1452" />

---

## Evidence 12: Application Load Balancer — Serving Web Server 1

This screenshot shows the TechCorp web application being served through the Application Load Balancer (ALB) DNS:

```
http://techcorp-alb-67810229.us-east-1.elb.amazonaws.com
```

The page displays **Instance ID: i-01845ae6f3f67f443**, which is Web Server 1. This confirms the ALB is healthy, the target group is correctly configured, Apache is running, and traffic is being successfully routed to the web servers in the private subnets.

![ALB - Web Server 1] <img width="1343" height="252" alt="Screenshot from 2026-04-23 05-23-47" src="https://github.com/user-attachments/assets/f4c68456-bb51-42ab-baec-d0c54a857278" />

---

## Evidence 13: Application Load Balancer — Load Balancing Confirmed (Web Server 2)

This screenshot shows the same ALB URL after refreshing the browser, now displaying a different **Instance ID: i-09e9ac34b6f5a9d8c**, which is Web Server 2. This proves the ALB is correctly distributing traffic between both web servers across two availability zones (`us-east-1a` and `us-east-1b`), fulfilling the high availability requirement of the TechCorp infrastructure.

![ALB - Web Server 2] <img width="1343" height="252" alt="Screenshot from 2026-04-23 05-24-44" src="https://github.com/user-attachments/assets/fe8549b1-6a8d-4421-9781-d8fb2e9da8e8" />

---

## Evidence 14: Password-Based SSH — Web Server 1 (techadmin)

This screenshot demonstrates password-based SSH access to Web Server 1 using the `techadmin` username — without an SSH key, using only a password. The connection was made from the Bastion Host using:

```
ssh techadmin@10.0.3.160
```

The prompt `[techadmin@ip-10-0-3-160 ~]$` confirms successful login. This satisfies the assessment requirement to set up username and password-based access from the Bastion to the web servers.

![Password SSH - Web Server 1] <img width="1030" height="278" alt="Screenshot from 2026-04-23 05-39-02" src="https://github.com/user-attachments/assets/9633130b-8567-42cb-bd53-c3015a8be0a5" />

---

## Evidence 15: Password-Based SSH — Web Server 2 (techadmin)

This screenshot demonstrates password-based SSH access to Web Server 2 (`10.0.4.149`) using the `techadmin` username from the Bastion Host. The prompt `[techadmin@ip-10-0-4-149 ~]$` confirms successful login with password authentication. Both web servers are configured to allow password-based SSH for administrative access, as required by the project specifications.

![Password SSH - Web Server 2] <img width="1030" height="278" alt="Screenshot from 2026-04-23 05-44-17" src="https://github.com/user-attachments/assets/f9b59a0d-2fcd-4482-b340-df246ef7160b" />

---

## Evidence 16: Password-Based SSH — Database Server (techadmin)

This screenshot demonstrates password-based SSH access to the Database Server (`10.0.3.58`) using the `techadmin` username from the Bastion Host. The prompt `[techadmin@ip-10-0-3-58 ~]$` confirms successful login. This completes the demonstration of password-based access to all three private servers through the Bastion Host, as required by the assessment.

![Password SSH - DB Server] <img width="1030" height="228" alt="Screenshot from 2026-04-23 05-47-58" src="https://github.com/user-attachments/assets/2f346bb0-cccc-4b76-bd73-ec65c047976d" />

---

## Evidence 17: Terraform Destroy — All Resources Removed

This screenshot shows the successful completion of `terraform destroy`, which cleanly removed all 30 AWS resources that were created during the deployment. The message **"Destroy complete! Resources: 30 destroyed."** confirms that every resource — including EC2 instances, NAT Gateways, the ALB, security groups, subnets, route tables, and the VPC — was removed from AWS. This is best practice to prevent ongoing charges after the assessment is complete.

![Terraform Destroy - Complete] <img width="788" height="80" alt="Screenshot from 2026-04-23 06-01-08" src="https://github.com/user-attachments/assets/fafa116b-1f39-4cde-8e92-f745521bae47" />

---

*End of Deployment Evidence*
