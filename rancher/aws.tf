resource "aws_security_group" "rmsdemo_sg_allowall" {
  name        = "${var.prefix}-allowall"

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_key_pair" "rmsdemo_key_pair" {
  key_name_prefix = "${var.prefix}-keypair"
  public_key      = tls_private_key.ssh_key.public_key_openssh
}


resource "aws_instance" "rke2_master_instance" {
  ami = data.aws_ami.hostos.id
  instance_type = var.aws_master_instance_type
  count = var.rke2_master_node_count

  key_name = aws_key_pair.rmsdemo_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.rmsdemo_sg_allowall.id]

  root_block_device {
    volume_size = 16
  }

  provisioner "remote-exec" {
    inline = ["sudo hostnamectl set-hostname ${format("%s-master-%02s", var.prefix, count.index + 1)}"]
  }


  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = local.node_username
      private_key = tls_private_key.ssh_key.private_key_pem
    }

  tags = {
    Name = format("%s-master-%02s", var.prefix, count.index + 1)
  }
}
