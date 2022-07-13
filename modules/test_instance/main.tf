provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "test" {
  ami = "ami-0cff7528ff583bf9a"
  instance_type = "t2.micro"
  subnet_id = var.subnet_id
  associate_public_ip_address = true

  tags = {
    Name = "Test"
  }
}