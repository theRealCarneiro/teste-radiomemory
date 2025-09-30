# Configure AWS

- Create root account
- Create IAM account
- Generate access keys for using with AWS CLI

# Create Terraform configuration

## Create EFS

## Configure Networking


## Create EC2 instances
- Generate RSA key in PEM format for SSH

```sh
aws ec2 create-key-pair \
    --key-name teste-radiomemory-key \
    --query 'KeyMaterial' \
    --output text > teste-radiomemory-key.pem
```

### Mount the EFS into the instances:
Install efs dependencies:
```sh
mkdir /mnt/efs
mount -t efs ${aws_efs_file_system.my_efs.id}:/ /mnt/efs
```

Single session: just use the mount command
- Persistent: add it to /etc/fstab
