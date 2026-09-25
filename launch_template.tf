resource "aws_launch_template" "rxweb" {
  name = "terraform-web-launch-template"

  image_id = var.ami_id

  instance_type = var.instance_type



  key_name = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.ec2.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "terraform-asg-web"
    }
  }

  tags = {
    Name = "terraform-web-launch-template"
  }
}