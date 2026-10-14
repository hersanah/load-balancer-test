resource "aws_security_group" "lb_sg" {
  name        = "${var.project_name}-lb-sg-${var.create_count}"
  description = "Security group for the load balancer ${var.create_count}"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-lb-sg-${var.create_count}",
    Owner       = var.owner,
    Environment = var.environment,
    Project     = var.project_name,
    Region      = var.region
  }
}

resource "aws_lb" "main" {
  name               = "${var.project_name}-lb-${var.create_count}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = var.public_subnet_ids

  tags = {
    Name        = "${var.project_name}-lb-${var.create_count}",
    Owner       = var.owner,
    Environment = var.environment,
    Project = var.project_name,
    Region      = var.region
  }
}

resource "aws_lb_target_group" "main" {
  name     = "${var.project_name}-tg-${var.create_count}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
  }

  tags = {
    Name        = "${var.project_name}-tg-${var.create_count}",
    Owner       = var.owner,
    Environment = var.environment,
    Project     = var.project_name,
    Region      = var.region
  }
}

resource "aws_lb_target_group_attachment" "name" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id = var.ec2_instance_id
  port      = 8080
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}