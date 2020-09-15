locals {
  spot_lc_name = join("-", compact(list("launch", var.project, var.environment)))
  ondemmand_lc_name = join("-", compact(list("ondemmand", "launch", var.project, var.environment)))
}

/* resource "aws_launch_configuration" "LAUNCH-FSMCORE" {
  name_prefix           = upper(local.spot_lc_name)
  image_id              = var.ami-image-id
  instance_type         = var.lc_instance_type
  iam_instance_profile  = var.iam-instance-profile
  key_name              = var.key_name
  security_groups       = [aws_security_group.SG-I-EC2-FSMCORE.id]
  enable_monitoring     = false
  ebs_optimized         = false
  spot_price            = var.enable_spot_price ? var.lc_spot_price : null

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 50
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_launch_configuration" "LAUNCH-ONDEMMAND-FSMCORE" {
  name_prefix           = upper(local.ondemmand_lc_name)
  image_id              = var.ami-image-id
  instance_type         = var.lc_instance_type
  iam_instance_profile  = var.iam-instance-profile
  key_name              = var.key_name
  security_groups       = [aws_security_group.SG-I-EC2-FSMCORE.id]
  enable_monitoring     = false
  ebs_optimized         = false
  
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 50
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }

}
 */