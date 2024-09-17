# Terraform EC2 instances Networking

### Directory Structure

```css
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
