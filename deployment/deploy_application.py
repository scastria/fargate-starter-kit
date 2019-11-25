from deployment import config


def deploy():
    # Configure AWS credentials from profile
    config.configure_aws_credentials()
    # Create a zip file containing all the source code and supporting files
    config.zip_tree(config.local_code_dir, config.code_zip)
    # Upload the zip file to the S3 bucket monitored by CodePipeline
    config.upload_file(config.code_zip, config.bucket_name, config.code_zip_s3_key)

    print('Done')


if __name__ == '__main__':
    deploy()
