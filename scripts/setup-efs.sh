#!/bin/sh
# Setup EFS mounting points on EC2 instance
# ${EFS_ID} env is set up by terraform

# Install efs utils
apt update
apt install -y amazon-efs-utils

# Create mounting dir and mount the instance for that session
mkdir /mnt/efs
mount -t efs ${EFS_ID}:/ /mnt/efs

# Configure FSTAB with new mounting point for persistence
echo "${EFS_ID}:/ /mnt/efs efs defaults,_netdev 0 0" >> /etc/fstab
