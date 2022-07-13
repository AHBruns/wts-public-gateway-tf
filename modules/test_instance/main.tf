provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "test" {
  ami = "ami-0cff7528ff583bf9a"
  instance_type = "t2.micro"
  subnet_id = var.subnet_id

  tags = {
    Name = "Test"
  }
}