provider "aws" {
  #region = "sa-east-1"
}

locals {
  workspace = jsondecode(file("./environments/${terraform.workspace}.json"))
  #workspace = jsondecode(file("./environments/develop.json"))

  default_tags = {
    Company     = upper(local.workspace["company"])
    System      = upper(local.workspace["project_name"])
    Area        = upper(local.workspace["area"])
    SubArea     = upper(local.workspace["sub_area"])
    Environment = upper(local.workspace["environment"])
  }
}

module "ecr" {
  source       = "./modules/ecr"
  environment  = local.workspace["environment"]
  default_tags = local.default_tags
}

module "ecs" {
  source      = "./modules/ecs"
  region      = local.workspace["region"]
  company     = local.workspace["company"]
  project     = local.workspace["project_name"]
  environment = local.workspace["environment"]
  #iam_role                      = local.workspace["iam_role"]
  environment_variables     = local.workspace["environment_variables"]
  fsmcore_repository_url    = module.ecr.fsmcore_repository_url
  sg_SG-I-EC2-FSMCORE       = module.ec2.sg_SG-I-EC2-FSMCORE
  cw_log_expiration_days    = local.workspace["cw_log_expiration_days"]
  td_backend_fargate_cpu    = local.workspace["td_backend_fargate_cpu"]
  td_backend_fargate_memory = local.workspace["td_backend_fargate_memory"]
  td_backend_app_cont_port  = local.workspace["td_backend_app_cont_port"]
  td_backend_app_host_port  = local.workspace["td_backend_app_host_port"]
  desired_count_backend     = local.workspace["desired_count_backend"]
  min_capacity_backend      = local.workspace["min_capacity_backend"]
  max_capacity_backend      = local.workspace["max_capacity_backend"]
  main-vpc-id               = local.workspace["main_vpc_id"]
  private-1-id              = local.workspace["private-1-id"]
  private-2-id              = local.workspace["private-2-id"]
  public-1-id               = local.workspace["public-1-id"]
  public-2-id               = local.workspace["public-2-id"]
  cluster_id                = local.workspace["cluster_id"]
  cluster_name              = local.workspace["cluster_name"]
  td_execution_role         = local.workspace["td_execution_role"]
  fargate_autoscale_role    = local.workspace["fargate_autoscale_role"]
  default_tags              = local.default_tags
  target_group_arn          = module.ecs.target_group_arn
}

module "ec2" {
  source             = "./modules/ec2"
  region             = local.workspace["region"]
  company            = local.workspace["company"]
  project            = local.workspace["project_name"]
  project_short_name = local.workspace["project_short_name"]
  environment        = local.workspace["environment"]
  # key_name             = local.workspace["key_name"]
  main-vpc-id     = local.workspace["main_vpc_id"]
  private-1-id    = local.workspace["private-1-id"]
  private-2-id    = local.workspace["private-2-id"]
  public-1-id     = local.workspace["public-1-id"]
  public-2-id     = local.workspace["public-2-id"]
  certificate_arn = local.workspace["certificate_arn"]
  # sg_alb_cidr_blocks   = local.workspace["sg_alb_cidr_blocks"]
  sg_ec2_cidr_blocks = local.workspace["sg_ec2_cidr_blocks"]
  # ami-image-id         = local.workspace["ami-image-id"]
  iam-instance-profile = local.workspace["iam-instance-profile"]
  # enable_autoscaling   = local.workspace["enable_autoscaling"]
  # asg_max_size         = local.workspace["asg_max_size"]
  # asg_min_size         = local.workspace["asg_min_size"]
  # asg_desired_capacity = local.workspace["asg_desired_capacity"]
  # enable_spot_price    = local.workspace["enable_spot_price"]
  # lc_spot_price        = local.workspace["lc_spot_price"]
  # lc_instance_type     = local.workspace["lc_instance_type"]
  default_tags = local.default_tags
  # bucket_log           = local.workspace["bucket_log"]

}