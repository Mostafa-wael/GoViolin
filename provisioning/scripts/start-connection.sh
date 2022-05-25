#!/bin/bash
set -e

env="$1" 
instance_id=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${env}" --region us-east-2 --query 'Reservations[-1].Instances[0].InstanceId' --output text)

echo "Starting instance ${instance_id}..."
aws ec2 start-instances --instance-ids $instance_id --region us-east-2

DNS=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${env}" --region us-east-2 --query 'Reservations[-1].Instances[*].PublicDnsName' --output text)
echo "You can connect to the instance at: ${DNS}"
