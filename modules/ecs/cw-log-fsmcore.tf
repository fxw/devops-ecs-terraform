locals {
  log_group_name = join("/", compact(list(var.company, var.project, "logs", var.environment)))

  cw_log_tags = {
    Name         = upper(local.log_group_name),
    Descritption = "CloudWatch logs FSMCORE ${upper(var.environment)}",
    Function     = "CLOUD WATCH LOGS"
  }
}
  
resource "aws_cloudwatch_log_group" "fsmcore_logs" {
  name              = local.log_group_name
  retention_in_days = var.cw_log_expiration_days
  tags              = merge(var.default_tags, local.cw_log_tags)
}
