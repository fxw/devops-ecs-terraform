locals {
  sg_ec2_name = join("-", compact(list("sg", "i", "ec2", var.project, var.environment)))

  sg_ec2_tags = {
    Name        = upper(local.sg_ec2_name),
    Function    = "SECURITY GROUP"
  }
}

resource "aws_security_group" "SG-I-EC2-FSMCORE" {
  name        = upper(local.sg_ec2_name)
  description = "security group for ec2 FSMCORE ${upper(var.environment)}"
  vpc_id      = var.main-vpc-id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.sg_ec2_cidr_blocks
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.default_tags, local.sg_ec2_tags)
}
