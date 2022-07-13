resource "aws_instance" "test" {
  ami = "ami-02d1e544b84bf7502"
  instance_type = "t2.micro"
  subnet_id = var.subnet_id

  tags = {
    Name = "Test"
  }
}