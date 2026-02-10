# Launch Template
resource "aws_launch_template" "app_lt" {
  name_prefix   = "cloud-devops-lt-"
  image_id      = "ami-0a7cf821b91bcccbc" # Amazon Linux 2 (ap-south-1)
  instance_type = "t3.micro"


  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.ec2_sg.id]
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              service docker start
              docker run -d -p 80:80 nginx
              EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "cloud-devops-instance"
    }
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "app_asg" {
  desired_capacity     = 2
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier  = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]

  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.app_tg.arn]

  health_check_type         = "ELB"
  health_check_grace_period = 60

  tag {
    key                 = "Name"
    value               = "cloud-devops-asg"
    propagate_at_launch = true
  }
}
