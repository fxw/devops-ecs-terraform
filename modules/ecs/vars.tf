variable "region" {
  type = string
}

variable "company" {
  type = string
}

variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "environment_variables" {
  type = map
}
variable "fsmcore_repository_url" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "default_tags" {
  type = map(string)
}

variable "cw_log_expiration_days" {
  type = number
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

variable "main-vpc-id" {
  type = string
}

variable "td_backend_fargate_cpu" {
  type = string
}

variable "td_backend_fargate_memory" {
  type = string
}

variable "td_backend_app_host_port" {
  type = string
}
variable "td_backend_app_cont_port" {
  type = string
}

variable "cluster_id" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "desired_count_backend" {
  type = string
}

variable "min_capacity_backend" {
  type = string
}

variable "max_capacity_backend" {
  type = string
}

variable "td_execution_role" {
  type = string
}

variable "sg_SG-I-EC2-FSMCORE" {
  type = string
}

variable "fargate_autoscale_role" {
  type = string
}

locals {
  container_name  = join("-", compact(list(var.project, var.environment)))
}