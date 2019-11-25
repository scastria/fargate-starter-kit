import boto3
from deployment import config


def delete():
    # Configure AWS credentials from profile
    config.configure_aws_credentials()

    print('Deleting application stack...')
    cf_client = boto3.client('cloudformation', region_name=config.region_name)
    cf_client.delete_stack(
        StackName=config.application_stack_name,
    )
    waiter = cf_client.get_waiter('stack_delete_complete')
    waiter.wait(StackName=config.application_stack_name)

    print('Deleting all docker images...')
    ecr_client = boto3.client('ecr', region_name=config.region_name)
    images = ecr_client.list_images(repositoryName=config.container_repository_name)
    if len(images['imageIds']) > 0:
        ecr_client.batch_delete_image(repositoryName=config.container_repository_name, imageIds=images['imageIds'])

    print('Deleting pipeline stack...')
    cf_client = boto3.client('cloudformation', region_name=config.region_name)
    cf_client.delete_stack(
        StackName=config.pipeline_stack_name,
    )
    waiter = cf_client.get_waiter('stack_delete_complete')
    waiter.wait(StackName=config.pipeline_stack_name)

    print('Deleting S3 bucket folder...')
    s3_resource = boto3.resource('s3', region_name=config.region_name)
    bucket = s3_resource.Bucket(config.bucket_name)
    for obj in bucket.objects.filter(Prefix=config.bucket_path):
        obj.delete()

    print('Done')


if __name__ == '__main__':
    delete()
