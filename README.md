# Terraform AWS EC2 Auto Scaling

This Terraform configuration files demonstrate provisioning for [Amazon EC2 auto scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/what-is-amazon-ec2-auto-scaling.html).

## Prerequisites

1. [Terraform](https://www.terraform.io/)
2. [Amazon Web Services account](https://aws.amazon.com/free/)
3. [Identity and Access Management (IAM) for your Terraform service account](https://blog.gruntwork.io/an-introduction-to-terraform-f17df9c6d180#a9b0)
4. [Amazon Web Service Command Line Interface (CLI)](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)

## Requirements

1. 1 [Virtual Private Cloud (VPC)]((https://aws.amazon.com/vpc/)).
2. 1 public subnetwork.
3. 1 private subnetwork connected with 1 [NAT Gateway](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html).
4. 1 [Amazon EC2 auto scaling group](https://docs.aws.amazon.com/autoscaling/ec2/userguide/AutoScalingGroup.html) with these specifications:
    - 2 `t2.micro` EC2 instances at minimum and 5 `t2.micro` EC2 instances at maximum with scaling policy if the CPU utilization reaches 45% or above it will scale out.
    - The EC2 instances must be created in the private subnetwork.

## Usage

Just simply run these Terraform commands below:
```sh
$ terraform init
$ terraform plan
$ terraform apply
```