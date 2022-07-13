resource "aws_lb" "public_gateway" {
  internal = false
  load_balancer_type = "application"
  subnets = var.subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "PublicGatewayService"
  }
}

resource "aws_lb_target_group" "public_gateway" {
  target_type = "instance"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
}

resource "aws_lb_listener" "public_gateway" {
  load_balancer_arn = aws_lb.public_gateway.arn
  port = 80
  protocol = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.public_gateway.arn
    type = "forward"
  }
}

resource "aws_launch_configuration" "config" {
  associate_public_ip_address = true
  instance_type = "t2.micro"
  image_id = "ami-0cff7528ff583bf9a"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "public_gateway" {
  availability_zones = var.availability_zones
  min_size = 1
  max_size = 2
  launch_configuration = aws_launch_configuration.config.name
  target_group_arns = [ aws_lb_target_group.public_gateway.arn ]

  lifecycle {
    create_before_destroy = true
  }
}