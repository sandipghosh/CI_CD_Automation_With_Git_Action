
resource "aws_instance" "simple_ec2_instance" {
  ami           = "ami-02d26659fd82cf299"
  instance_type   = "t3.micro"

  metadata_options {
    http_tokens                 = "required" # require IMDSv2
    http_endpoint               = "enabled"  # optional (enabled/disabled)
    http_put_response_hop_limit = 1
  }

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    encrypted   = true
    kms_key_id  = aws_kms_key.ebs.arn # optional: use your CMK
  }

  tags = {
    Name = "ec2 instance for linting"
  }
}


resource "aws_kms_key" "ebs" {
  description             = "KMS key for EBS encryption"
  enable_key_rotation     = true
  rotation_period_in_days = 90
}

resource "aws_ebs_encryption_by_default" "default" {
  enabled = true
}