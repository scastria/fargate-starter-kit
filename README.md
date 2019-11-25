# Introduction 
This project is intended to give teams building serverless container applications based on
[Fargate](https://aws.amazon.com/fargate/) technology a quick start.  It includes:
1. A sample web service, written in both C# and Python, for accessing a password hash database
2. A sample [CloudFormation](https://aws.amazon.com/cloudformation/) template for deploying the web services to Fargate
3. A sample [CodePipeline](https://aws.amazon.com/codepipeline/) for automating the build and release of the web
services
4. Miscellaneous python scripts to bootstrap the CodePipeline

# Prerequisites
NOTE: For simplicity, this starter kit assumes the VPC is setup in default mode where all subnets are public with an
Internet Gateway attached.  This causes the Fargate containers to require a public IP address which is not good practice.
1. Use the included `samples/dump.sql` file to create an [RDS](https://aws.amazon.com/rds/) instance with a Postgres
database named `decryptor`
2. Create a `DecryptorRDSPassword` secret in [Secrets Manager](https://aws.amazon.com/secrets-manager/) that contains
the correct username and password for the `decryptor` database
3. Turn on all 3 `Amazon ECS ARN and resource ID settings` in the `Account Settings` section of
[ECS](https://aws.amazon.com/ecs/)
4. Create a [Route53](https://aws.amazon.com/route53/) public hosted zone suitable to act as the endpoint for the web services

# Getting Started
1. Fork and Clone this starter kit repository
2. Modify `deployment/config.py` by changing all `placeholder` values with values that correspond to your AWS account
AND by changing the `language` setting as desired
3. Modify the RDS_HOST value in either the C# or Python application python source code based on your `language` choice
above so that it matches the host of the `decryptor` database created in the prerequisites
4. Verify your AWS CLI credentials profile chosen in `deployment/config.py` is valid
5. Run `python deployment/create_pipeline.py` to create the CodePipeline
6. Run `python deployment/deploy_application.py` to zip up the source code and copy to
[S3](https://aws.amazon.com/secrets-manager/) to start the CodePipeline