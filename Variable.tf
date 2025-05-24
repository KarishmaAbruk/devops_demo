variable "region" {
  description = "AWS Region"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
}

variable "key_name" {
  description = "Name of the AWS key pair"
  type        = string
}
