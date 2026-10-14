output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "ec2_connect_endpoint_id" {
  value = aws_ec2_instance_connect_endpoint.main.id
}

output "ec2_connect_sg_id" {
  value = aws_security_group.ec2_connect_sg.id
}