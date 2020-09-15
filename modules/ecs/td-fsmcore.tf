locals {
  td_family_name = join("-", compact(list(var.project, var.environment)))
  environment = {
    dev = "Development"
    homol = "Homol"
    prod = "Production"
  }
}

resource "aws_ecs_task_definition" "fsmcore" {
  family                = local.td_family_name
  container_definitions = data.template_file.fsmcore_template.rendered
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.td_backend_fargate_cpu
  memory                   = var.td_backend_fargate_memory
  execution_role_arn       = var.td_execution_role
  network_mode             = "awsvpc"
}

data "aws_ecs_task_definition" "fsmcore" {
  task_definition = aws_ecs_task_definition.fsmcore.family
  depends_on      = [aws_ecs_task_definition.fsmcore]
}

data "template_file" "fsmcore_template" {
  template = file("${path.module}/td-fsmcore.json")

  vars = {
  	# container
    container_name                                  = local.container_name
    image_url                                       = "${var.fsmcore_repository_url}:latest"
    tz                                              = var.environment_variables["tz"]

    # log
    log_group_name                                  = aws_cloudwatch_log_group.fsmcore_logs.name
    log_group_region                                = var.region
    log_group_prefix                                = "fsmcore"

    # common envs
    aspnetcore_environment                          = local.environment[var.environment]

    #crypto key
    token_criptographic_key                         = var.environment_variables["token_criptographic_key"]

    # elasticsearch log
    log_elasticsearch_url                           = var.environment_variables["log_elasticsearch_url"]
    log_elasticsearch_index_prefix                  = var.environment_variables["log_elasticsearch_index_prefix"]
    min_log_level                                   = var.environment_variables["min_log_level"]

    # apm envs
    elastic_apm_service_name                        = var.environment_variables["elastic_apm_service_name"]
    elastic_apm_environment                         = var.environment_variables["elastic_apm_environment"]
    elastic_apm_transaction_max_spans               = var.environment_variables["elastic_apm_transaction_max_spans"]
    elastic_apm_secret_token                        = var.environment_variables["elastic_apm_secret_token"]
    elastic_apm_server_urls                         = var.environment_variables["elastic_apm_server_urls"]
    elastic_apm_transaction_sample_rate             = var.environment_variables["elastic_apm_transaction_sample_rate"]
    elastic_apm_log_level                           = var.environment_variables["elastic_apm_log_level"]

    url_api_base                                    = var.environment_variables["url_api_base"]
    url_api_base_presentationapi                    = var.environment_variables["url_api_base_presentationapi"]
  }
}
