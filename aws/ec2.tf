data "local_file" "pubkey" {
  filename = pathexpand(var.public_key_path)
}

resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = chomp(data.local_file.pubkey.content)
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Ubuntu official

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "app" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_1.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.deployer.key_name

  tags = {
    Name = "${var.project_name}-app"
  }
}

resource "aws_instance" "tools" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_2.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.deployer.key_name

  tags = {
    Name = "${var.project_name}-tools"
  }
}

