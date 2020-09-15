locals {
  asg_name = join("-", compact(list("asg", var.project, var.environment)))
}

/* resource "aws_autoscaling_group" "ASG-FSMCORE" {
    name                      = upper(local.asg_name)
    
    min_size                  = var.asg_min_size
    max_size                  = var.asg_max_size
    desired_capacity          = var.asg_desired_capacity

    health_check_grace_period = 60
    health_check_type         = "EC2"
    launch_configuration      = aws_launch_configuration.LAUNCH-FSMCORE.name
    
    vpc_zone_identifier       = [var.private-1-id, var.private-2-id]

    tag {
        key                 = "Area"
        value               = "DELIVERY"
        propagate_at_launch = true
    }

    tag {
        key                 = "Backup"
        value               = "NO"
        propagate_at_launch = true
    }

    tag {
        key                 = "DeleteBkp"
        value               = "YES"
        propagate_at_launch = true
    }

    tag {
        key                 = "Description"
        value               = "Servidores do ECS para o cluster ${upper(var.project)}"
        propagate_at_launch = true
    }

    tag {
        key                 = "Environment"
        value               = upper(var.environment)
        propagate_at_launch = true
    }

    tag {
        key                 = "Function"
        value               = "FULL"
        propagate_at_launch = true
    }

    tag {
        key                 = "Name"
        value               = "AWS-FSMCORE-DKR"
        propagate_at_launch = true
    }

    tag {
        key                 = "SubArea"
        value               = "SYSOPS"
        propagate_at_launch = true
    }

    tag {
        key                 = "System"
        value               = "FSMCORE"
        propagate_at_launch = true
    }
}

# Stop all instances each weekday at 19pm 
resource "aws_autoscaling_schedule" "fsmcore-stop" {
  count = var.enable_autoscaling ? 1 : 0

  scheduled_action_name = "fsmcore-stop"
  min_size = 0
  max_size = 0
  desired_capacity = 0
  recurrence = "00 01 * * TUE-SAT"
  autoscaling_group_name = aws_autoscaling_group.ASG-FSMCORE.name
}

# Startup 1 instance each weekday at 10am 
resource "aws_autoscaling_schedule" "fsmcore-start" {
  count = var.enable_autoscaling ? 1 : 0

  scheduled_action_name  = "fsmcore-start"

  min_size               = var.asg_min_size
  max_size               = var.asg_max_size
  desired_capacity       = var.asg_desired_capacity

  recurrence             = "0 10 * * MON-FRI"
  autoscaling_group_name = aws_autoscaling_group.ASG-FSMCORE.name
} */