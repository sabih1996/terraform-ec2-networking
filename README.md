# Terraform VPC, EC2, Security Groups, and Network ACLs Setup

This Terraform project is designed to provision a Virtual Private Cloud (VPC) on AWS with public and private subnets, along with EC2 instances, Security Groups, and Network ACLs (NACLs). The project ensures a secure networking environment for running applications (like NestJS) by controlling traffic at both the instance level (Security Groups) and the subnet level (NACLs).

### Features
- **VPC Creation:** A custom VPC with CIDR block 10.0.0.0/16 is created.
- **Public and Private Subnets:** Two subnets (public and private) are provisioned with different CIDR blocks:
    - Public Subnet: 10.0.1.0/24
    - Private Subnet: 10.0.2.0/24
- **Security Groups:** Security groups for both public and private instances to control inbound and outbound traffic.
- **Network ACLs (NACLs):** Stateless network ACLs for public and private subnets that add an extra security layer at the subnet level.
- **NAT Gateway:** Allows instances in the private subnet to access the internet while preventing inbound traffic.
- **Application Load Balancer:** Can be configured for load balancing across EC2 instances in private subnets.
- **EC2 Instances:** Instances running in both public and private subnets, with SSH access, HTTP, and HTTPS enabled for public instances.
- **AWS Secret Manager:** Storing sensitive information securely, like database credentials or API keys.


### Directory Structure

```graphql
├── main.tf
├── variables.tf
├── outputs.tf
├── modules/
│   ├── networking/
│   │   ├── vpc.tf
│   │   ├── subnets.tf
│   │   ├── nat_gateway.tf
│   │   ├── internet_gateway.tf
│   │   ├── route_tables.tf
│   │   ├── nacl.tf
│   │   ├── public_nacl.tf
│   │   ├── private_nacl.tf
│   │   ├── output.tf
│   ├── ec2/
│   │   ├── public_ec2.tf
│   │   ├── private_ec2.tf
│   │   ├── output.tf
│   ├── security_groups/
│   │   ├── public_sg.tf
│   │   ├── private_sg.tf
│   │   ├── output.tf
│   ├── secrets/
│   │   ├── secrets.tf
└── terraform.tfvars
```

### Prerequisites
Before starting, ensure you have the following installed:

- Terraform (v1.x.x or later)
- AWS CLI (Configure with your credentials)
- AWS Account with sufficient permissions to provision resources like EC2,  VPC, NAT Gateway, Security Groups, NACLs, etc.

### Configuration

Make sure you update the variable values in terraform.tfvars to match your environment:

```hcl
region              = "us-west-2"
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidr  = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"
instance_type       = "t2.micro"
key_pair_name       = "my-ec2-key"
```

### Secrets Management
Sensitive information, such as database credentials or API keys, is managed securely using ***AWS Secrets Manager***. Ensure that the secrets are created and managed in the AWS Secrets Manager, and reference them in the configuration.

### How to Use
**Step 1: Initialize Terraform**
First, you need to initialize the Terraform project to download necessary providers and modules.
```bash
$ terraform init
```

**Step 2: Validate the Configuration**
Validate all configurations to ensure validation is good to go.
```bash
$ terraform validate
```

**Step 3: Apply the Configuration**
After configuring your variables and ensuring your AWS credentials are set, apply the Terraform plan to provision the infrastructure.
```bash
$ terraform apply
```
Terraform will output the resources to be created, and you will need to confirm the action by typing `yes`.

**Step 4: Destroy the Infrastructure**
Once you're done with the infrastructure and no longer need the resources, use the following command to clean up:

```bash
$ terraform destroy
```
### Security Groups
Security Groups are defined to allow or deny traffic at the instance level. Below is a summary of the security group configurations:

##### Public Security Group (`public_sg.tf`)
- Inbound Rules:
    - HTTP (80), HTTPS (443), SSH (22) from 0.0.0.0/0
- Outbound Rules:
    - Allow all outbound traffic
##### Private Security Group (`private_sg.tf`)
- Inbound Rules:
   - Allow traffic from the public subnet and private subnet (internal VPC communication)
- Outbound Rules:
   - Allow all outbound traffic

### Network ACLs (NACLs)
Network ACLs (NACLs) provide an extra layer of security at the subnet level. They are stateless, which means both inbound and outbound rules need to be explicitly defined.

##### Public Subnet NACL (`public_nacl.tf`)

- Inbound Rules:
   - Allow HTTP (80), HTTPS (443), SSH (22), and ephemeral ports (1024-65535)
- Outbound Rules:
   - Allow HTTP (80), HTTPS (443), and ephemeral ports (1024-65535)

##### Private Subnet NACL (`private_nacl.tf`)

- Inbound Rules:
   - Allow HTTP, HTTPS, SSH traffic from within the VPC
- Outbound Rules:
   - Allow all outbound traffic   

### Modules
This project uses modules to organize the Terraform configuration into reusable parts:

1. ***Networking Module (`modules/networking/`):*** Contains the configuration for the VPC, subnets, NAT Gateway, route tables, and NACLs.
2. ***EC2 Module (`modules/ec2/`):*** Contains the configuration for launching EC2 instances in both public and private subnets.
3. ***Security Groups Module (`modules/security_groups/`):*** Defines security groups for controlling inbound and outbound traffic to the EC2 instances.
4. ***Secrets Module (`modules/secrets/`):*** Contains configuration for managing sensitive data using AWS Secrets Manager.

### Outputs
Once the Terraform configuration is applied, you will see the following outputs:

***VPC ID:*** The ID of the created VPC.
***Public Subnet ID:*** The ID of the public subnet.
***Private Subnet ID:*** The ID of the private subnet.
***Public EC2 Instance IP:*** The public IP of the EC2 instance in the public subnet.
***Private EC2 Instance IP:*** The private IP of the EC2 instance in the private subnet.

### Troubleshooting
- ***Failed to SSH into Public Instance:*** Ensure the correct key pair is provided and the public security group allows inbound SSH traffic on port 22.
- ***Private EC2 Cannot Access the Internet:*** Check that the NAT Gateway is correctly associated with the public subnet and the route tables are properly configured.

