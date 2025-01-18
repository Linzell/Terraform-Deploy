# Medications Application - AWS Deployment Guide

A full-stack application for managing medication data, deployed on AWS infrastructure using Terraform.

## 🏗️ Architecture

The application follows a modern cloud-native architecture:

```
├── frontend/        # React TypeScript application
├── backend/         # ElysiaJS API
└── terraform/       # Infrastructure as Code
```

### Infrastructure Components

- **VPC** with public and private subnets
- **ECS Fargate** for container orchestration
- **RDS PostgreSQL** for database
- **Application Load Balancer** for traffic distribution
- **ECR** for container registry
- **CloudWatch** for logging and monitoring

## 🚀 Prerequisites

- AWS CLI installed and configured
- Terraform installed (v1.0.0+)
- Docker installed
- Node.js 18+ and Bun runtime
- AWS Account with appropriate permissions

## 🛠️ Deployment Steps

### 1. Initial Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd medications-app
```

2. Create an S3 bucket for Terraform state:
```bash
aws s3 mb s3://your-terraform-state-bucket --region eu-west-3
```

3. Create a DynamoDB table for state locking:
```bash
aws dynamodb create-table \
  --table-name terraform-state-lock \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
  --region eu-west-3
```

### 2. SSL Certificate Setup

1. Request an SSL certificate in AWS Certificate Manager:
```bash
aws acm request-certificate \
  --domain-name your-domain.com \
  --validation-method DNS \
  --region eu-west-3
```

2. Complete DNS validation for the certificate

### 3. Environment Configuration

1. Create `terraform.tfvars`:
```hcl
aws_region         = "eu-west-3"
environment        = "production"
app_name           = "medications-app"
database_name      = "medications_db"
database_username  = "admin"
database_password  = "your-secure-password"
domain_name        = "your-domain.com"
frontend_url       = "https://your-frontend-domain.com"
backend_url        = "https://api.your-domain.com"
api_url           = "https://api.your-domain.com"
fda_api_key       = "your-fda-api-key"
jwt_access_secret = "your-jwt-access-secret"
jwt_refresh_secret = "your-jwt-refresh-secret"
certificate_arn    = "arn:aws:acm:region:account:certificate/certificate-id"
```

### 4. Infrastructure Deployment

1. Initialize Terraform:
```bash
cd terraform
terraform init
```

2. Plan the deployment:
```bash
terraform plan
```

3. Apply the infrastructure:
```bash
terraform apply
```

### 5. Application Deployment

1. Build and push backend container:
```bash
cd backend
docker build -t medications-backend .
aws ecr get-login-password --region eu-west-3 | docker login --username AWS --password-stdin $(terraform output -raw backend_repository_url)
docker tag medications-backend:latest $(terraform output -raw backend_repository_url):latest
docker push $(terraform output -raw backend_repository_url):latest
```

2. Build and push frontend container:
```bash
cd frontend
docker build -t medications-frontend .
aws ecr get-login-password --region eu-west-3 | docker login --username AWS --password-stdin $(terraform output -raw frontend_repository_url)
docker tag medications-frontend:latest $(terraform output -raw frontend_repository_url):latest
docker push $(terraform output -raw frontend_repository_url):latest
```

### 6. DNS Configuration

1. Update your domain's DNS settings to point to the ALB:
```bash
aws route53 change-resource-record-sets \
  --hosted-zone-id YOUR_HOSTED_ZONE_ID \
  --change-batch '{
    "Changes": [{
      "Action": "UPSERT",
      "ResourceRecordSet": {
        "Name": "your-domain.com",
        "Type": "A",
        "AliasTarget": {
          "HostedZoneId": "'$(terraform output -raw alb_zone_id)'",
          "DNSName": "'$(terraform output -raw alb_dns_name)'",
          "EvaluateTargetHealth": true
        }
      }
    }]
  }'
```

## 📊 Monitoring and Maintenance

### Logs

View application logs in CloudWatch:
```bash
aws logs get-log-events \
  --log-group-name $(terraform output -raw log_group_name) \
  --log-stream-name your-stream-name
```

### Scaling

Update ECS service desired count:
```bash
aws ecs update-service \
  --cluster $(terraform output -raw ecs_cluster_name) \
  --service $(terraform output -raw backend_service_name) \
  --desired-count 2
```

### Database Backups

RDS automated backups are enabled with a 7-day retention period.

## 🔄 Update Procedure

1. Update application code
2. Build and push new container images
3. Update ECS services:
```bash
aws ecs update-service \
  --cluster $(terraform output -raw ecs_cluster_name) \
  --service $(terraform output -raw backend_service_name) \
  --force-new-deployment
```

## 🧹 Cleanup

To destroy all resources:
```bash
terraform destroy
```

## ⚠️ Important Notes

- Keep your terraform.tfvars and other sensitive information secure
- Regularly update your dependencies and security patches
- Monitor AWS costs through AWS Cost Explorer
- Set up AWS Budget Alerts to avoid unexpected charges
- Regular backup verification is recommended
- Monitor application metrics and set up alerts

## 📚 Additional Resources

- [AWS Documentation](https://docs.aws.amazon.com/)
- [Terraform Documentation](https://www.terraform.io/docs/)
- [ECS Best Practices](https://docs.aws.amazon.com/AmazonECS/latest/bestpracticesguide/intro.html)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)

## 🤝 Contributing

Contributions are welcome! Please read our contributing guidelines before submitting pull requests.

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.
