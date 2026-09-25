resource "aws_autoscaling_policy" "cpu_target_tracking_policy" {
  name                   = "terraform-web-cpu-target-tracking"
  autoscaling_group_name = aws_autoscaling_group.rx-asg-web.name

  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 50.0
  }
}