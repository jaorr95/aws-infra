

resource "aws_instance" "public_instance" {
  count                       = var.public_instance_quantity
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.public_instance_type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.http_from_lb.id]
  user_data                   = templatefile("${path.module}/config/ec2/user-data.tpl", { config_server = local.config_server })
  iam_instance_profile        = aws_iam_instance_profile.ec2_role_profile.name

  tags = {
    Name = "${var.public_instance_prefix_name}${count.index + 1}"
  }

}