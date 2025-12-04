Overview
In this task, I designed and deployed a custom VPC on AWS using Terraform.
The objective was to build a clean and secure network foundation that can support scalable applications.
The setup includes public and private subnets, an Internet Gateway, a NAT Gateway, proper route tables, and security groups.
This is the same structure commonly used in real production applications, so completing this task helped me understand how networking actually works inside AWS.
What I Built
1. Custom VPC
I created a Virtual Private Cloud (VPC) with the CIDR range 10.0.0.0/16, which gives enough IP addresses for future scaling.
2. Public & Private Subnets
Two public subnets for internet-facing components.
Two private subnets for backend services or EC2 instances that should not be exposed directly.
3. Internet Gateway
Attached an Internet Gateway (IGW) to the VPC to allow public subnets to communicate with the internet.
4. NAT Gateway
A NAT Gateway was added in a public subnet so instances in private subnets can access the internet securely (for updates, package installs, etc.), without receiving external traffic.
5. Route Tables
Public Route Table → Routes all internet traffic (0.0.0.0/0) to the IGW
Private Route Table → Routes 0.0.0.0/0 to the NAT Gateway
This separation ensures proper traffic flow and security.
6. Security Groups
I created Security Groups following basic best practices:
Allow HTTP (80) only on public resources
Restrict SSH access to only my personal IP
Allow communication between private resources internally
Important AWS Best Practices Followed
✔ Private subnets for internal EC2 instances
✔ NAT Gateway for secure outbound access
✔ Principle of least privilege on Security Groups
✔ Clean separation between web tier and private tier
Screenshots
1. VPC
/assets/vpc.png
2. Subnets
/assets/subnets.png
3. Route Tables
/assets/route_tables.png
4. NAT Gateway
/assets/nat-gateway.png