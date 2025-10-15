resource "aws_instance" "simple_ec2_instance" {
  ami           = "ami-02d26659fd82cf299"
  instance_type   = "t3.micro"

  tags = {
    Name = "ec2 instance for linting"
  }
}
