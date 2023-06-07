# Latest SLE 15.4 AMI
data "aws_ami" "hostos" {
  most_recent = true
  owners      = ["013907871322"]

  filter {
    name   = "name"
    values = ["suse-sles-15-sp4*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# Latest openSUSE Leap 15.4 AMI
data "aws_ami" "clientos" {
  most_recent = true
  owners      = ["679593333241"]

  filter {
    name   = "name"
    values = ["openSUSE-Leap-15.4*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}
