resource "aws_security_group" "web_server_sg" {
  name        = "web-server-sg-${var.create_count}"
  description = "Security group for web server ${var.create_count}"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-web-server-sg-${var.create_count}",
    Owner       = var.owner,
    Environment = var.environment,
    Project     = var.project_name,
    Region      = var.region
  }
}

resource "aws_security_group_rule" "allow_lb_to_web_server" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.web_server_sg.id
  source_security_group_id = var.lb_sg_id
}

resource "aws_security_group_rule" "allow_ssh_to_web_server" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.web_server_sg.id
  source_security_group_id = var.ec2_connect_endpoint_sg_id
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  subnet_id     = var.subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]

  tags = {
    Name        = "${var.project_name}-web-server-${var.create_count}",
    Owner       = var.owner,
    Environment = var.environment,
    Project     = var.project_name,
    Region      = var.region
  }
}