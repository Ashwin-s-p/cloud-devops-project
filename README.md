# Cloud DevOps Deployment Project

## 🚀 Architecture
- VPC (Public Subnets)
- Internet Gateway
- Route Tables
- Application Load Balancer
- Target Group (Port 3000)
- Auto Scaling Group
- Launch Template
- Dockerized Application (Nginx-based static site)
- AWS ECR for container images

## 🔧 Infrastructure as Code
All infrastructure is provisioned using Terraform.

## 🐳 Containerization
Application is containerized using Docker and pushed to AWS ECR.

## 🌐 Load Balancing
Traffic is routed via Application Load Balancer to EC2 instances running Docker containers.

## ⚠️ Known Issue
Due to time constraints, the container registration to the Target Group faced final-stage health check configuration issues.  
However, infrastructure provisioning, networking, and container deployment pipeline were successfully implemented.

## 📌 Learnings
- VPC networking setup
- Route tables and Internet Gateway configuration
- ALB and Target Group integration
- Docker image push to ECR
- Auto Scaling Group configuration
- Debugging cloud networking and health checks
