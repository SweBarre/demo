resource "aws_security_group" "fleetdemo_sg_allowall" {
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

resource "aws_key_pair" "fleetdemo_key_pair" {
  key_name_prefix = "${var.prefix}-keypair"
  public_key      = tls_private_key.ssh_key.public_key_openssh
}


resource "aws_instance" "k3s_instance" {
  ami = data.aws_ami.hostos.id
  instance_type = var.aws_instance_type
  count = var.k3s_cluster_count

  key_name = aws_key_pair.fleetdemo_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.fleetdemo_sg_allowall.id]

  root_block_device {
    volume_size = 16
  }

  provisioner "remote-exec" {
    inline = ["sudo hostnamectl set-hostname ${format("%s-fleet-%02s", var.prefix, count.index + 1)}"]
  }


  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = local.node_username
      private_key = tls_private_key.ssh_key.private_key_pem
    }

  tags = {
    Name = format("%s-fleet-%02s", var.prefix, count.index + 1)
  }
}
