#!/bin/sh
# Setup EFS mounting points on EC2 instance

EFS_DOMAIN="${EFS_ID}.efs.${REGION}.amazonaws.com"
MOUNT_OPTS="nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2"
MOUNT_POINT="/mnt/efs"

# Install nfs common
sudo apt update
sudo apt install -y nfs-common

# Create mounting dir
sudo mkdir /mnt/efs

# Mount the efs instance for that session
sudo mount -t nfs4 -o "$MOUNT_OPTS" "$EFS_DOMAIN:/" "$MOUNT_POINT"

# Append mounting options to fstab for persistence
echo "$EFS_DOMAIN:/ $MOUNT_POINT nfs4 $MOUNT_OPTS 0 0" | sudo tee -a /etc/fstab
