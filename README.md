## 📌 Project Overview

This project demonstrates the design and deployment of AWS infrastructure across three independent environments:



- **Development**
- **Staging**
- **Production**

The infrastructure is built using reusable Terraform modules rather than duplicating infrastructure code for every environment.

Each environment consumes the same core modules while using environment-specific configuration for infrastructure sizing, scaling, networking, and database requirements.

### Key Objectives

- Build reusable Terraform modules
- Separate development, staging, and production environments
- Implement AWS networking infrastructure
- Deploy scalable compute infrastructure
- Deploy private RDS PostgreSQL databases
- Configure Terraform remote state
- Implement state locking
- Apply Infrastructure as Code best practices
- Maintain a clean and reproducible Git workflow

---

# 🏗️ Architecture

----



![Image description](https://dev-to-uploads.s3.us-east-2.amazonaws.com/uploads/articles/oxudoingcexr9048z7o2.jpg)




----

![Image description](https://dev-to-uploads.s3.us-east-2.amazonaws.com/uploads/articles/m1ie0wpk25k25c9xuf78.jpg)

----

![Image description](https://dev-to-uploads.s3.us-east-2.amazonaws.com/uploads/articles/hbjiblbxvj5l9aao4qcn.png)


---


# 📁 Repository Structure


```text
Terraform-Project/
│
├── .gitignore
├── .terraform.lock.hcl
│
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── nacl.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   │
│   ├── compute/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   │
│   └── database/
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
│
├── dev/
│   ├── .terraform.lock.hcl
│   ├── main.tf
│   ├── outputs.tf
│   ├── provider.tf
│   ├── variables.tf
│   └── versions.tf
│
├── stage/
│   ├── .terraform.lock.hcl
│   ├── main.tf
│   ├── outputs.tf
│   ├── provider.tf
│   ├── variables.tf
│   └── versions.tf
│
└── prod/
    ├── .terraform.lock.hcl
    ├── main.tf
    ├── outputs.tf
    ├── provider.tf
    ├── variables.tf
    └── versions.tf
```


### 🔐 Files intentionally excluded from Git

Environment-specific files such as:

```text
terraform.tfvars
backend.hcl
terraform.tfstate
tfplan
.terraform/
```

are excluded from the repository through `.gitignore`.

This prevents environment-specific configuration, state files, generated plans, and potentially sensitive values from being committed.

---

# 🧩 Terraform Modules

## 🌐 VPC Module

The networking module provisions the foundational AWS network infrastructure.

### Components

* VPC
* Public subnets
* Private subnets
* Internet Gateway
* NAT Gateways
* Route tables
* Route table associations
* Network ACL configuration

---

## 🖥️ Compute Module

The compute module provides scalable application infrastructure.

### Components

* EC2 Launch Template
* Auto Scaling Group
* Application Security Group
* Environment-specific scaling configuration

---

## 🗄️ Database Module

The database module provisions PostgreSQL infrastructure using Amazon RDS.

### Components

* RDS PostgreSQL
* DB subnet group
* Database Security Group
* Private database networking
* Encryption configuration
* Backup configuration
* Production Multi-AZ configuration

---

# 🌎 Environment Design

Each environment uses the same reusable modules while allowing infrastructure capacity to vary according to its purpose.

| Environment | VPC CIDR      | EC2 Type    | ASG Min | ASG Desired | ASG Max | RDS        | Multi-AZ |
| ----------- | ------------- | ----------- | ------: | ----------: | ------: | ---------- | -------- |
| Development | `10.0.0.0/16` | `t3.micro`  |       1 |           1 |       2 | PostgreSQL | No       |
| Staging     | `10.1.0.0/16` | `t3.small`  |       1 |           2 |       3 | PostgreSQL | No       |
| Production  | `10.2.0.0/16` | `t3.medium` |       2 |           3 |       5 | PostgreSQL | Yes      |

Production is intentionally configured with higher capacity and resilience than development and staging.

---

# ☁️ AWS Services

This project uses several AWS services:

| AWS Service      | Purpose                              |
| ---------------- | ------------------------------------ |
| Amazon VPC       | Network isolation                    |
| Subnets          | Public/private network segmentation  |
| Internet Gateway | Internet connectivity                |
| NAT Gateway      | Outbound private subnet connectivity |
| Route Tables     | Network traffic routing              |
| Network ACLs     | Subnet-level traffic control         |
| EC2              | Application compute                  |
| Auto Scaling     | Application scalability              |
| Launch Template  | EC2 configuration                    |
| Security Groups  | Instance-level network security      |
| Amazon RDS       | Managed PostgreSQL database          |
| Amazon S3        | Terraform remote state               |
| DynamoDB         | Terraform state locking              |

---

![Image description](https://dev-to-uploads.s3.us-east-2.amazonaws.com/uploads/articles/21219r7cdu051ed3d3yp.png)



# 🔐 Terraform Remote State

Terraform state is stored remotely using Amazon S3.

State locking is implemented using DynamoDB.

Example backend configuration:

```hcl
bucket         = "multi-environment-terraform-150926"
key            = "dev/terraform.tfstate"
region         = "eu-west-1"
dynamodb_table = "terraform-locks"
encrypt        = true
```

Each environment uses its own state key to maintain environment isolation.

> The actual backend configuration files are intentionally excluded from this repository.

---

# 🚀 Getting Started

## Prerequisites

Install and configure:

* Terraform
* AWS CLI
* AWS credentials
* Git

Your AWS identity must have appropriate permissions to provision the required infrastructure.

---

## Clone the Repository

Using SSH:

```bash
git clone git@github.com:Jahmeeu-Cloud/terraform-aws-multi-environment-infrastructure.git
```

Then:

```bash
cd terraform-aws-multi-environment-infrastructure
```

---

# 🔧 Deploy Development

```bash
cd dev
```

Initialize Terraform:

```bash
terraform init -backend-config=backend.hcl -reconfigure
```

Format:

```bash
terraform fmt -recursive
```

Validate:

```bash
terraform validate
```

Create a plan:

```bash
terraform plan -var-file=terraform.tfvars -out=tfplan
```

Apply:

```bash
terraform apply tfplan
```

View outputs:

```bash
terraform output
```

---

# 🔧 Deploy Staging

```bash
cd ../stage
```

Initialize:

```bash
terraform init -backend-config=backend.hcl -reconfigure
```

Validate:

```bash
terraform validate
```

Plan:

```bash
terraform plan -var-file=terraform.tfvars -out=tfplan
```

Apply:

```bash
terraform apply tfplan
```

---

# 🔧 Deploy Production

```bash
cd ../prod
```

Initialize:

```bash
terraform init -backend-config=backend.hcl -reconfigure
```

Validate:

```bash
terraform validate
```

Plan:

```bash
terraform plan -var-file=terraform.tfvars -out=tfplan
```

Apply:

```bash
terraform apply tfplan
```

---

# 🔄 Standard Terraform Workflow

```bash
terraform fmt
terraform validate
terraform plan
terraform apply
```

For a controlled deployment using a saved plan:

```bash
terraform plan -out=tfplan
terraform apply tfplan
```

To inspect deployed outputs:

```bash
terraform output
```

---

# 🛡️ Security Considerations

This project is designed as a practical cloud engineering and Infrastructure-as-Code portfolio project.

Several production hardening improvements should be considered before using the configuration for a real production workload.

### Current Security Design

* RDS is deployed in private subnets.
* Database access is controlled through security groups.
* Production RDS is encrypted.
* Production RDS uses Multi-AZ.
* Production RDS has deletion protection enabled.
* Terraform state is stored remotely.
* Environment-specific configuration files are excluded from Git.

### Recommended Improvements

* Replace direct SSH access with AWS Systems Manager Session Manager.
* Restrict SSH source IPs where SSH is required.
* Store database credentials in AWS Secrets Manager or Systems Manager Parameter Store.
* Place application instances in private subnets.
* Introduce an Application Load Balancer.
* Add CloudWatch monitoring and alarms.
* Implement least-privilege IAM policies.

---

# 💰 Cost Considerations

The infrastructure contains AWS resources that can generate ongoing costs, including:

* NAT Gateways
* EC2 instances
* Auto Scaling Groups
* RDS
* Elastic IPs

For development and testing, unused environments should be destroyed when no longer required.

```bash
terraform destroy -var-file=terraform.tfvars
```

> Always verify the Terraform plan before destroying infrastructure.

---

# 🧠 Skills Demonstrated

### Infrastructure as Code

* Terraform
* Terraform Modules
* Remote State
* State Locking
* Environment Isolation
* Infrastructure Automation

### AWS

* VPC
* EC2
* Auto Scaling
* RDS
* S3
* DynamoDB
* IAM
* Security Groups
* Network ACLs
* NAT Gateway
* Internet Gateway
* Route Tables

### DevOps

* Git
* GitHub
* Linux
* Infrastructure automation
* Environment management

### Architecture

* Modular infrastructure
* Public/private network segmentation
* High availability concepts
* Scalable compute
* Managed database architecture

---

# 📈 Future Improvements

Planned improvements include:

* [ ] Application Load Balancer
* [ ] Private application subnets
* [ ] AWS Systems Manager integration
* [ ] CloudWatch dashboards and alarms
* [ ] GitHub Actions CI/CD
* [ ] Terraform plan checks on pull requests
* [ ] Infracost integration
* [ ] Secrets Manager integration
* [ ] Additional security hardening
* [ ] Cost optimization for NAT Gateways
* [ ] Automated infrastructure testing

---

# 🎯 Project Purpose

This project was built to demonstrate practical experience designing and deploying cloud infrastructure using **Terraform and AWS**.

Rather than maintaining separate duplicated Terraform configurations, reusable modules are used across multiple environments.

The project demonstrates how infrastructure can be:

* **Reusable**
* **Scalable**
* **Environment-aware**
* **Version controlled**
* **Automated**
* **Easier to maintain**

It forms part of my ongoing Cloud, DevOps, and Platform Engineering learning journey.

---

# 👨🏾‍💻 Author

## Jamiu Olatunji Bakre

**Cloud / DevOps Engineer | AWS | Terraform | Kubernetes | Platform Engineering**

I build and automate cloud infrastructure with a focus on AWS, Infrastructure as Code, DevOps practices, and scalable platform engineering.

### Connect With Me

* **GitHub:** [Jahmeeu-Cloud](https://github.com/Jahmeeu-Cloud)
* **LinkedIn:** [Jamiu Bakre](https://linkedin.com/in/jamiu-bakre/)
* **Portfolio:** [CloudWithHorla Portfolio](https://jahmeeu-cloud.github.io/portfolio-project/)

---

## ⭐ If you find this project useful

Feel free to explore the repository, review the Terraform modules, and follow the project as it evolves.

**Built with Terraform + AWS ☁️**


