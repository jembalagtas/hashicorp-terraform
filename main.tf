provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "terraform-sg" {
  name        = "terraform-sg"
  description = "Test Security Group"

  ingress {
      from_port     = 0
      to_port       = 65535
      protocol      = "tcp"
      cidr_blocks   = ["0.0.0.0/0"]
  }

  egress {
      from_port     = 0
      to_port       = 65535
      protocol      = "tcp"
      cidr_blocks   = ["0.0.0.0/0"]
  }
  tags  =   {
        Name = "terraform-sg"
  }
}


resource "aws_instance" "terraform-instance" {
  ami           = "ami-0c322300a1dd5dc79"
  instance_type = "t2.micro"
  security_groups = ["terraform-sg"]
  key_name = "ansible-key"
  root_block_device {
    delete_on_termination = true
    volume_type = "gp2"
    volume_size = "10"
  }

  tags = {
    Name = "terraform-instance"
  }
  volume_tags = {
    Name = "terraform_volume"
  }
/***
  provisioner "file" {
    source      = "platform.sh"
    destination = "/tmp/platform.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/platform.sh",
      "sudo /tmp/platform.sh"
    ]
  }

  connection {
    type     = "ssh"
    host     = self.public_ip
    user     = "ec2-user"
    password = ""
    private_key = "${file("/root/terraform/key.pem")}"
  }
***/
}

