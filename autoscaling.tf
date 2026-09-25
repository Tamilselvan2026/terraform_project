resource "aws_autoscaling_group" "rx-asg-web" {
  name = "terraform-web-asg"

  min_size         = 2
  desired_capacity = 2
  max_size         = 4

  vpc_zone_identifier = [
    aws_subnet.oregan_vpc_public[0].id,
    aws_subnet.oregan_vpc_public[1].id
  ]

  target_group_arns = [
    aws_lb_target_group.oregan_vpc_alb_tg.arn
  ]

  health_check_type = "ELB"

  health_check_grace_period = 120

  launch_template {
    id = aws_launch_template.rxweb.id

    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "terraform-asg-web"
    propagate_at_launch = true
  }
}