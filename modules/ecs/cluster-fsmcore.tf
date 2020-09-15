locals {
  cluster_name = join("-", compact(list( "Cluster", upper(var.project), upper(var.environment), "INTERNAL")))
}

/* resource "aws_lb" "nlb_fsmcore_vpc_link" {
  name               = "NLB-FSMCORE-${upper(var.environment)}"
  internal           = true
  load_balancer_type = "network"
  subnets            = [var.private-1-id, var.private-2-id]
  enable_deletion_protection = false
  tags               = var.default_tags
} */

resource "aws_alb_target_group" "nlb_tg_fsmcore" {
  name     = "nlb-tg-fsmcore-dev"
  port     = "80"
  protocol = "TCP"
  vpc_id   = var.main-vpc-id

  stickiness {
    type = "lb_cookie"
    enabled = false
  }
}