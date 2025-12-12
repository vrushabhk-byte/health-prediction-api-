## 🏗️ Architecture

The application is deployed using AWS managed services with a fully automated CI/CD pipeline.

- Source code is hosted on GitHub
- GitHub Actions builds, tests, and deploys the application
- Docker images are stored in Amazon ECR
- Application runs on Amazon ECS using Fargate
- Monitoring and alerting are handled via Amazon CloudWatch
- ECS task definition is defined declaratively and stored under /iac

The architecture ensures scalability, security, and zero-downtime deployments.
