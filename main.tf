provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0ba259e664698cbfc"  # Replace with your AMI ID
  instance_type = "t2.micro"
  key_name      = "test1"  # Replace with your key pair name

  tags = {
    Name = "Docker"
  }
}

