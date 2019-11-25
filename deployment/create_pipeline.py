import boto3
from deployment import config


def create(is_update=False):
    # Configure AWS credentials from profile
    config.configure_aws_credentials()
    # Make sure ECS service linked role exists
    if not config.ecs_service_linked_role_exists():
        config.create_ecs_service_linked_role()
    # Make sure S3 bucket exists to store pipeline CF template
    if not config.bucket_exists(config.bucket_name):
        config.create_bucket(config.bucket_name)
    # Upload pipeline CF template
    config.upload_file(config.pipeline_template_location, config.bucket_name, config.pipeline_s3_key)
    # Setup all CF template parameter values
    stack_args = {
        'StackName': config.pipeline_stack_name,
        'TemplateURL': config.get_s3_url(config.bucket_name, config.pipeline_s3_key),
        'Parameters': [
            {
                'ParameterKey': 'FSKDeploymentProjectName',
                'ParameterValue': config.deployment_project_name
            },
            {
                'ParameterKey': 'ECRRepoName',
                'ParameterValue': config.container_repository_name
            },
            {
                'ParameterKey': 'ECSImageName',
                'ParameterValue': config.get_container_image_url(config.container_repository_name)
            },
            {
                'ParameterKey': 'ECSUseSSL',
                'ParameterValue': str(config.use_ssl).lower()
            },
            {
                'ParameterKey': 'ECSLogRegion',
                'ParameterValue': config.region_name
            },
            {
                'ParameterKey': 'ECSStackName',
                'ParameterValue': config.application_stack_name
            },
            {
                'ParameterKey': 'ECSVpc',
                'ParameterValue': config.vpc_id
            },
            {
                'ParameterKey': 'ECSSubnet1',
                'ParameterValue': config.container_subnet1
            },
            {
                'ParameterKey': 'ECSSubnet2',
                'ParameterValue': config.container_subnet2
            },
            {
                'ParameterKey': 'ECSCertificate',
                'ParameterValue': config.ssl_certificate
            },
            {
                'ParameterKey': 'ECSHealthCheck',
                'ParameterValue': config.service_health_check
            },
            {
                'ParameterKey': 'ECSDomainName',
                'ParameterValue': config.service_domain_name
            },
            {
                'ParameterKey': 'ECSDNSName',
                'ParameterValue': config.service_dns
            },
            {
                'ParameterKey': 'ECSReleaseVersion',
                'ParameterValue': config.release_version
            },
            {
                'ParameterKey': 'CBProjectDirEnv',
                'ParameterValue': config.main_project_dir
            },
            {
                'ParameterKey': 'CBBuildNumberName',
                'ParameterValue': config.build_number_parameter_name
            },
            {
                'ParameterKey': 'CPRegion',
                'ParameterValue': config.region_name
            },
            {
                'ParameterKey': 'CodeBucket',
                'ParameterValue': config.bucket_name
            },
            {
                'ParameterKey': 'CodeZip',
                'ParameterValue': config.code_zip_s3_key
            },
            {
                'ParameterKey': 'TagContact',
                'ParameterValue': config.email_address
            },
            {
                'ParameterKey': 'TagService',
                'ParameterValue': config.full_project_name
            },
            {
                'ParameterKey': 'TagEnvironment',
                'ParameterValue': config.deployment
            }
        ],
        'Capabilities': [
            'CAPABILITY_NAMED_IAM'
        ]
    }
    # Determine whether to create a new stack or update an existing one
    cf_client = boto3.client('cloudformation', region_name=config.region_name)
    if is_update:
        # Update stack
        cf_client.update_stack(**stack_args)
        # Wait for stack update to complete
        waiter = cf_client.get_waiter('stack_update_complete')
        waiter.wait(StackName=config.pipeline_stack_name)
    else:
        # Create stack
        cf_client.create_stack(**stack_args)
        # Wait for stack create to complete
        waiter = cf_client.get_waiter('stack_create_complete')
        waiter.wait(StackName=config.pipeline_stack_name)

    print('Done')


if __name__ == '__main__':
    create()
