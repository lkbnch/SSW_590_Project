# Crypto Compass

A real-time cryptocurrency tracking application with interactive charts and operational metrics.

## Features

- Real-time cryptocurrency price tracking
- Interactive price charts
- Operational metrics dashboard
- SWOT analysis of tools used
- Secure login system
- AWS infrastructure as code

## Prerequisites

### AWS Account Setup
1. Create an AWS account at https://aws.amazon.com/
2. Set up an IAM user with AdministratorAccess:
   - Go to IAM Console
   - Create new user
   - Select "Attach existing policies directly"
   - Choose "AdministratorAccess"
   - Save the access key ID and secret access key

### Local Environment Setup
1. Install AWS CLI:
   ```bash
   # macOS
   brew install awscli
   
   # Windows
   winget install AWS.AWSCLI
   
   # Linux
   curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
   unzip awscliv2.zip
   sudo ./aws/install
   ```

2. Configure AWS CLI:
   ```bash
   aws configure
   # Enter your AWS Access Key ID
   # Enter your AWS Secret Access Key
   # Enter your preferred region (e.g., us-east-1)
   # Enter output format (json)
   ```

3. Install Terraform:
   ```bash
   # macOS
   brew install terraform
   
   # Windows
   winget install HashiCorp.Terraform
   
   # Linux
   curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
   sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
   sudo apt-get update && sudo apt-get install terraform
   ```

4. Install Node.js (for local development):
   ```bash
   # Using nvm (recommended)
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
   nvm install 16
   nvm use 16
   ```

## Infrastructure Setup

### AWS Resources
The project uses the following AWS services:
- S3 bucket for static website hosting
- CloudFront distribution for CDN
- Lambda function for price updates
- CloudWatch for scheduling and monitoring
- IAM roles and policies
- Secrets Manager for API keys

### Deployment Steps

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/crypto-compass.git
   cd crypto-compass
   ```

2. Create a CoinGecko API key:
   - Go to https://www.coingecko.com/en/api
   - Sign up for a free account
   - Generate an API key

3. Create a `terraform.tfvars` file:
   ```bash
   cat > terraform.tfvars << EOL
   coingecko_api_key = "your-api-key-here"
   region = "us-east-1"
   environment = "production"
   EOL
   ```

4. Initialize Terraform:
   ```bash
   terraform init
   ```

5. Review the planned changes:
   ```bash
   terraform plan
   ```

6. Apply the infrastructure:
   ```bash
   terraform apply
   ```

7. Deploy the website:
   ```bash
   # Install dependencies
   npm install
   
   # Build the project
   npm run build
   
   # Deploy to S3
   aws s3 sync dist/ s3://crypto-compass-static-website --exclude "*.tf*" --exclude ".git/*"
   ```

8. Verify the deployment:
   - Check the CloudFront distribution URL (output from terraform apply)
   - Verify the Lambda function is running in AWS Console
   - Check CloudWatch logs for any errors

### Post-Deployment Tasks

1. Set up monitoring:
   - Go to CloudWatch Console
   - Create a dashboard for:
     - Lambda invocation metrics
     - API Gateway metrics
     - CloudFront metrics

2. Configure alerts:
   - Set up CloudWatch alarms for:
     - Lambda errors
     - High latency
     - API rate limits

3. Security hardening:
   - Enable AWS WAF on CloudFront
   - Set up AWS Shield for DDoS protection
   - Configure AWS Config for compliance monitoring

## Local Development

1. Install dependencies:
   ```bash
   npm install
   ```

2. Start the development server:
   ```bash
   npm start
   ```

3. Access the application:
   - Open http://localhost:3000
   - Use test credentials:
     - Username: admin
     - Password: admin123

## Tool Comparison

The project uses several tools and technologies:

1. **Frontend:**
   - HTML/CSS/JavaScript
   - Chart.js for visualizations
   - Session Storage for authentication

2. **Backend:**
   - AWS Lambda for price updates
   - CoinGecko API for cryptocurrency data

3. **Infrastructure:**
   - AWS S3 for static hosting
   - CloudFront for CDN
   - Terraform for infrastructure as code

A detailed SWOT analysis of these tools is available in the application's SWOT Analysis page.

## Security Considerations

- API keys are stored securely in AWS Secrets Manager
- HTTPS enforced through CloudFront
- Rate limiting implemented for API calls
- Session-based authentication
- Regular security audits recommended
- Implement AWS WAF rules
- Enable AWS Shield protection

## Monitoring

The application includes:
- Real-time operational metrics
- API call tracking
- System uptime monitoring
- Data freshness indicators
- CloudWatch dashboards
- Lambda function metrics
- API Gateway metrics

## Troubleshooting

Common issues and solutions:

1. **Lambda Function Errors**
   - Check CloudWatch logs
   - Verify IAM permissions
   - Check environment variables

2. **S3 Deployment Issues**
   - Verify bucket permissions
   - Check CORS configuration
   - Validate file paths

3. **CloudFront Issues**
   - Check distribution status
   - Verify origin settings
   - Clear cache if needed

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## Support

For issues and support:
- Create GitHub issues
- Contact the development team
- Check AWS documentation
- Review CloudWatch logs
