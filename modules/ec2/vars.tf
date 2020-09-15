variable "region" {
  type = string
}

variable "company" {
  type = string
}

variable "project" {
  type = string
}

variable "project_short_name" {
  type = string
}

variable "environment" {
  type = string
}

/* variable "key_name" {
  type = string
} */

variable "main-vpc-id" {
  type = string
}

variable "private-1-id" {
  type = string
}

variable "private-2-id" {
  type = string
}

variable "public-1-id" {
  type = string
}

variable "public-2-id" {
  type = string
}

variable "certificate_arn" {
  type = string
}

variable "iam-instance-profile" {
  type = string
}

variable "default_tags" {
  type = map(string)
}

/* variable "sg_alb_cidr_blocks" {
  type = list(string)
} */

variable "sg_ec2_cidr_blocks" {
  type = list(string)
}

/* variable "enable_autoscaling" {
  description = "If set to true, enable auto scaling"
  type = bool
}

variable "asg_max_size" {
  type = number
}

variable "asg_min_size" {
  type = number
}

variable "asg_desired_capacity" {
  type = number
}

variable "enable_spot_price" {
  type = bool
}

variable "lc_spot_price" {
  type = string
}

variable "lc_instance_type" {
  type = string
} 

variable "bucket_log" {
  type = string
} */