# 🚀 Terraform AWS EC2 Deployment (Mumbai Region)

![Terraform](https://img.shields.io/badge/Terraform-IaC-blueviolet)
![AWS](https://img.shields.io/badge/AWS-Cloud-orange)
![Region](https://img.shields.io/badge/Region-ap--south--1-green)

---

## 📌 Project Overview

This project demonstrates how to provision an **EC2 instance on AWS** using **Terraform** along with complete networking setup.

✅ Infrastructure as Code (IaC)  
✅ Fully automated provisioning  
✅ Clean and modular Terraform files  

---

## 🏗️ Resources Created

- 🌐 **VPC (Virtual Private Cloud)**
- 📡 **Subnet**
- 🌍 **Internet Gateway (IGW)**
- 🛣️ **Route Table + Association**
- 🖥️ **EC2 Instance**
- 📦 **S3 Bucket + Object Upload**

---

## 📦 S3 Storage

- Created an **S3 bucket using Terraform**
- Uploaded `index.html` from local system
- Configured public access (for demo purpose)

---


---

## 📍 Region

All resources are deployed in:

ap-south-1 (Mumbai)

---

## ⚙️ How to Use

```bash
1️⃣ Initialize Terraform
terraform init

2️⃣ Preview Changes
terraform plan  (Dry run)

3️⃣ Apply Configuration
terraform apply



📂 Project Structure
.
├── provider.tf
├── vpc.tf
├── terraform.tf
├── .gitignore
└── README.md



💡 Key Highlights

✨ Beginner-friendly Terraform setup
✨ Real-world AWS infrastructure
✨ Clean and production-style structure

🙌 Author

Sayan Ray


---

If you want, I can also:
👉 :contentReference[oaicite:0]{index=0}  
👉 Or :contentReference[oaicite:1]{index=1} 🚀
