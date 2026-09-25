resource "aws_sns_topic" "asg_notifications" {
  name = "terraform-web-asg-notifications"

  tags = {
    Name = "terraform-web-asg-notifications"
  }
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.asg_notifications.arn

  protocol = "email"

  endpoint = var.notification_email
}

resource "aws_autoscaling_notification" "web" {
  group_names = [
    aws_autoscaling_group.rx-asg-web.name
  ]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR"
  ]

  topic_arn = aws_sns_topic.asg_notifications.arn
}
