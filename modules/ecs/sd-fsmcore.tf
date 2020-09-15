locals {
  service_name = join("-", compact(list(var.project, var.environment)))
}

resource "aws_ecs_service" "fsmcore" {
  name            = local.service_name
  cluster         = var.cluster_id
  launch_type     = "FARGATE"
  task_definition = "${aws_ecs_task_definition.fsmcore.family}:${max("${aws_ecs_task_definition.fsmcore.revision}", "${data.aws_ecs_task_definition.fsmcore.revision}")}"
  desired_count   = var.desired_count_backend

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = local.container_name
    container_port   = "80"
  }

  network_configuration {
    security_groups = [var.sg_SG-I-EC2-FSMCORE]
    subnets         = [var.private-1-id, var.private-2-id]
  }
}

#autoscaling
resource "aws_appautoscaling_target" "backend-target" {
  service_namespace      = "ecs"
  resource_id            = "service/${var.cluster_name}/${aws_ecs_service.fsmcore.name}"
  scalable_dimension     = "ecs:service:DesiredCount"
  role_arn               = var.fargate_autoscale_role
  min_capacity           = var.min_capacity_backend
  max_capacity           = var.max_capacity_backend
}

# Automatically scale capacity up by one
resource "aws_appautoscaling_policy" "fsmcore-up" {
  name               = "scale_up_fsmcore"
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${aws_ecs_service.fsmcore.name}"
  scalable_dimension = "ecs:service:DesiredCount"
 step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"
    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
 depends_on = [aws_appautoscaling_target.backend-target]
}

# Automatically scale capacity down by one
resource "aws_appautoscaling_policy" "fsmcore-down" {
  name               = "scale_down_fsmcore"
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${aws_ecs_service.fsmcore.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"
    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = -1
    }
  }
  depends_on = [aws_appautoscaling_target.backend-target]
}

# CloudWatch alarm that triggers the autoscaling up policy
resource "aws_cloudwatch_metric_alarm" "fsmcore_cpu_high" {
  alarm_name          = "cb_cpu_utilization_high_fsmcore"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = aws_ecs_service.fsmcore.name
  }
  alarm_actions = [aws_appautoscaling_policy.fsmcore-up.arn]
}

# CloudWatch alarm that triggers the autoscaling down policy
resource "aws_cloudwatch_metric_alarm" "fsmcore_cpu_low" {
  alarm_name          = "cb_cpu_utilization_low_fsmcore"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "30"
  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = aws_ecs_service.fsmcore.name
  }
  alarm_actions = [aws_appautoscaling_policy.fsmcore-down.arn]
}