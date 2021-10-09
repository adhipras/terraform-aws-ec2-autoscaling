#-------------------------------------------------------------------------------
# Region
#-------------------------------------------------------------------------------

variable "region" {
  description = "The Amazon Web Services region."
  type        = string
  default     = "ap-southeast-1"
}

#-------------------------------------------------------------------------------
# Availability Zone
#-------------------------------------------------------------------------------

variable "availability_zone" {
  description = "The Amazon Web Services availability zone."
  type        = string
  default     = "ap-southeast-1a"
}

#-------------------------------------------------------------------------------
# Virtual Private Cloud (VPC)
#-------------------------------------------------------------------------------

variable "vpc_cidr_block" {
  description = "The CIDR block of the VPC."
  type        = string
  default     = "10.100.0.0/16"
}

#-------------------------------------------------------------------------------
# Public Subnetwork
#-------------------------------------------------------------------------------

variable "public_subnet_cidr_block" {
  description = "The CIDR block for the public subnetwork."
  type        = string
  default     = "10.100.0.0/24"
}

#-------------------------------------------------------------------------------
# Private Subnetwork
#-------------------------------------------------------------------------------

variable "private_subnet_cidr_block" {
  description = "The CIDR block for the private subnetwork."
  type        = string
  default     = "10.100.10.0/24"
}

#-------------------------------------------------------------------------------
# Amazon Machine Image (AMI)
#-------------------------------------------------------------------------------

variable "ami_owner" {
  description = "The owner of the AMI."
  type        = string
  default     = "amazon"
}

variable "ami_name" {
  description = "The name of the AMI used for filtering."
  type        = list(string)
  default     = ["amzn-ami-hvm-*-x86_64-gp2"]
}

#-------------------------------------------------------------------------------
# EC2
#-------------------------------------------------------------------------------

variable "instance_type" {
  description = "The type of the instance."
  type        = string
  default     = "t2.micro"
}

#-------------------------------------------------------------------------------
# Autoscaling
#-------------------------------------------------------------------------------

variable "min_size" {
  description = "The minimum size of the Auto Scaling Group."
  type        = number
  default     = 2
}

variable "desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group."
  type        = number
  default     = 2
}

variable "max_size" {
  description = "The maximum size of the Auto Scaling Group."
  type        = number
  default     = 5
}

variable "cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start."
  type        = number
  default     = 30
}

#-------------------------------------------------------------------------------
# CloudWatch
#-------------------------------------------------------------------------------

variable "metric_name" {
  description = "The name for the alarm's associated metric."
  type        = string
  default     = "CPUUtilization"
}

variable "statistic" {
  description = "The statistic to apply to the alarm's associated metric."
  type        = string
  default     = "Average"
}

variable "threshold" {
  description = "The value against which the specified statistic is compared."
  type        = string
  default     = "45"
}

variable "period" {
  description = "The period in seconds over which the specified statistic is applied."
  type        = string
  default     = "60"
}

variable "evaluation_periods" {
  description = "The number of periods over which data is compared to the specified threshold."
  type        = string
  default     = "2"
}

variable "namespace" {
  description = "The namespace for the alarm's associated metric."
  type        = string
  default     = "AWS/EC2"
}
