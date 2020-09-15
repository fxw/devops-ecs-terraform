/* locals {
  alb_name = join("-", compact(list("alb", "i", var.project, var.environment)))
  tg_name  = join("-", compact(list("tg", "i", var.project, var.environment)))

  alb_tags = {
    Name         = upper(local.alb_name)
    Descritption = "Aplication Load Balancer FSMCORE ${upper(var.environment)}",
    Function     = "LOAD BALANCER"
  }

  alb_tg_tags = {
    Name         = upper(local.tg_name),
    Descritption = "Aplication Load Balancer FSMCORE ${upper(var.environment)}",
    Function     = "LOAD BALANCER"
  }
}

resource "aws_lb" "ALB-FSMCORE" {
  name                       = upper(local.alb_name)
  internal                   = true
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.SG-I-ALB-FSMCORE.id]
  subnets                    = [var.private-1-id, var.private-2-id]
  idle_timeout               = 180
  enable_deletion_protection = true

  tags = merge(var.default_tags, local.alb_tags)
  access_logs {
    bucket  = var.bucket_log
    prefix  = "LB"
    enabled = true
  }
} */