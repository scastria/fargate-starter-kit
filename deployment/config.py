import os
import boto3
from botocore.exceptions import ClientError
import zipfile


#####################
### Zip Constants ###
#####################
OMIT_DIRS = ['.git', '.idea', '.vs', 'bin', 'obj', 'publish']
OMIT_EXTENSIONS = ['.pyc', '.zip', '.user']


##################################
### Deployment Phase Constants ###
##################################
DEV = 'Dev'
TEST = 'Test'
STAGE = 'Stage'
PROD = 'Prod'


##########################
### Language Constants ###
##########################
CSHARP = 'csharp'
PYTHON = 'python'


############################
### Common Config Values ###
############################
project_name = 'placeholder'  # Change this to your project name
project_suffix = ''  # Like '-Shawn'.  Used to further distinguish different users deploying their own version of the same project
deployment = DEV  # Choose from deployment constants above
language = CSHARP  # Choose from language constants above.  Source code is taken using this value with an 'application_' prefix.
main_project_dir = 'Service'  # The subdirectory of code_dir to use as the main entrypoint during runtime
release_version = '1.0.0'  # Version to be used for docker image tag appended by an auto incrementing build number
region_name = 'placeholder'  # AWS region
bucket_name = 'placeholder'  # Bucket to store CF templates and code zips during deployment
pipeline_template_location = 'pipeline.yml'  # Relative path to CF template which creates the CodePipeline for build/deployment automation
code_zip = 'code.zip'  # Name of code zip to be built and deployed by CodePipeline stack
email_address = 'placeholder'  # Email to be used for Contact tag on all AWS resources
credentials_profile = 'placeholder'  # Name of AWS CLI credentials profile to be used for all AWS commands
container_subnet1 = 'placeholder'  # First subnet to use for the fargate container
container_subnet2 = 'placeholder'  # Second subnet to use for the fargate container


###########################################
### Service Mode Specific Config Values ###
###########################################
service_health_check = '/api/health'  # The path to use to check health if application code deploys a Service
service_domain_name = 'placeholder'  # DNS suffix to use if application code deploys a Service
vpc_id = 'placeholder'  # AWS VPC


#################################################
### Service Mode - TLS Specific Config Values ###
#################################################
use_ssl = False
ssl_certificate = 'placeholder'  # Certificate to use for TLS if application code deploys persistent services


#############################
### Derived Config Values ###
#############################
code_dir = 'application_' + language  # Directory containing application code relative to this repo's top level
local_code_dir = '..' + os.sep + code_dir
full_project_name = project_name + project_suffix
deployment_project_name = full_project_name + '-' + deployment
pipeline_stack_name = deployment_project_name + '-Pipeline'
application_stack_name = deployment_project_name + '-Application'
build_number_parameter_name = deployment_project_name + '-BuildNumber'
bucket_path = full_project_name + '/' + deployment
pipeline_s3_file = os.path.basename(pipeline_template_location)
pipeline_s3_key = bucket_path + '/' + pipeline_s3_file
pipeline_s3_path = bucket_name + '/' + pipeline_s3_key
code_zip_s3_key = bucket_path + '/' + code_zip
code_zip_s3_path = bucket_name + '/' + code_zip_s3_key
container_repository_name = deployment_project_name.lower()
service_dns = deployment_project_name.lower() + '.' + service_domain_name


#################
### Functions ###
#################
def configure_aws_credentials():
    os.environ['AWS_PROFILE'] = credentials_profile


def get_s3_url(bucket_name, object_key):
    # Configure AWS credentials from profile
    configure_aws_credentials()
    s3_client = boto3.client('s3', region_name=region_name)
    return s3_client.meta.endpoint_url + '/' + bucket_name + '/' + object_key


def get_container_image_url(repo_name):
    # Configure AWS credentials from profile
    configure_aws_credentials()
    sts_client = boto3.client('sts', region_name=region_name)
    account_id = sts_client.get_caller_identity()['Account']
    return account_id + '.dkr.ecr.' + region_name + '.amazonaws.com/' + repo_name


def zip_tree(input_dir, output_zip, destination='', is_append=False):
    if not input_dir.endswith(os.sep):
        input_dir = input_dir + os.sep
    zip_action = 'a' if is_append else 'w'
    zip_file = zipfile.ZipFile(output_zip, zip_action, zipfile.ZIP_DEFLATED)
    input_dir_prefix_length = len(input_dir)
    # Walk through all children files and dirs of top level code directory
    for root, dirs, files in os.walk(input_dir):
        destination_root = os.path.join(destination, root[input_dir_prefix_length:])
        for file in files:
            if zip_this_file(file):
                zip_file.write(os.path.join(root, file), os.path.join(destination_root, file))
        for i in range(len(dirs) - 1, -1, -1):
            dir = dirs[i]
            if not zip_this_dir(dir):
                # Removing this directory from dirs prevents it from being walked in outer for loop
                dirs.remove(dir)
    zip_file.close()


def zip_this_dir(dir_name):
    for omit_dir in OMIT_DIRS:
        if dir_name == omit_dir:
            return False
    return True


def zip_this_file(file_name):
    for omit_ext in OMIT_EXTENSIONS:
        if file_name.endswith(omit_ext):
            return False
    return True


def upload_file(file_path, bucket_name, object_key):
    s3_resource = boto3.resource('s3', region_name=region_name)
    bucket = s3_resource.Bucket(bucket_name)
    bucket.upload_file(file_path, object_key)


def bucket_exists(bucket_name):
    s3_client = boto3.client('s3', region_name=region_name)
    retval = True
    try:
        s3_client.head_bucket(Bucket=bucket_name)
    except ClientError as err:
        if err.response['Error']['Code'] not in ['403', '404']:
            raise
        retval = False
    return retval


def create_bucket(bucket_name):
    s3_client = boto3.client('s3', region_name=region_name)
    if region_name == 'us-east-1':  # Need to handle this region differently due to legacy weirdness in AWS API.
        s3_client.create_bucket(Bucket=bucket_name, ACL='private')
    else:
        s3_client.create_bucket(Bucket=bucket_name, ACL='private',
                                CreateBucketConfiguration={'LocationConstraint': region_name})

    # Verify successful creation
    s3_resource = boto3.resource('s3', region_name=region_name)
    bucket = s3_resource.Bucket(bucket_name)
    bucket.wait_until_exists()
    return bucket


def ecs_service_linked_role_exists():
    iam_client = boto3.client('iam')
    roles_response = iam_client.list_roles(PathPrefix='/aws-service-role/ecs.amazonaws.com')
    return len(roles_response['Roles']) > 0


def create_ecs_service_linked_role():
    iam_client = boto3.client('iam')
    iam_client.create_service_linked_role(AWSServiceName='ecs.amazonaws.com')
