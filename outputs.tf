output "vpc_id" {
  value = aws_vpc.oregan_vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.oregan_vpc.cidr_block
}

output "public_subnet_ids" {
  value = aws_subnet.oregan_vpc_public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.oregan_vpc_private[*].id
}

output "alb_dns_name" {
  value = aws_lb.oregan_vpc_alb.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.oregan_vpc_alb_tg.arn
}

output "autoscaling_group_name" {
  value = aws_autoscaling_group.rx-asg-web.name
}

output "launch_template_id" {
  value = aws_launch_template.rxweb.id
}

output "autoscaling_policy_name" {
  value = aws_autoscaling_policy.cpu_target_tracking_policy.name
}

output "autoscaling_policy_arn" {
  value = aws_autoscaling_policy.cpu_target_tracking_policy.arn
}