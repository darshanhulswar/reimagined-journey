provider "aws" {
    region = "us-east-1"
    access_key = ""
    secret_key = ""
}

resource "aws_instance" "ec2" {
    ami = "ami-0953476d60561c955"
    instance_type = "t2.medium"
    security_groups = [ "default" ]
    key_name = "project"
    root_block_device {
      volume_size = 20
      volume_type = "gp3"
      delete_on_termination = true
    }
    tags = {
      Name = "Jenkins-admin-server"
    }
    user_data = file("server-script.sh")
}

output "PublicIP" {
  value = aws_instance.ec2.public_ip
}