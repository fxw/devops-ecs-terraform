/* locals {
  sg_alb_name = join("-", compact(list("sg", "i", "alb", var.project, var.environment)))

  sg_alb_tags = {
    Name        = upper(local.sg_alb_name),
    Function    = "SECURITY GROUP"
  }
}

resource "aws_security_group" "SG-I-ALB-FSMCORE" {
  name        = upper(local.sg_alb_name)
  description = "Load balancer terraform FSMCORE ${upper(var.environment)}"
  vpc_id      = var.main-vpc-id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.sg_alb_cidr_blocks
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.sg_alb_cidr_blocks
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.default_tags, local.sg_alb_tags)
}
 */