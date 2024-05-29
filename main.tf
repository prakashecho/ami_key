# Configure the AWS provider
provider "aws" {
  region = "us-east-1a"  # Replace with your desired AWS region
}

# Define the EC2 instance with encrypted EBS volume
resource "aws_instance" "ami_kms" {
  ami                    = "ami-0a240a5c4a9a12eec"  # Replace with your encrypted AMI ID
  instance_type          = "t2.small"
  key_name               = "pra"  # Replace with your key pair name
  vpc_security_group_ids = ["sg-05a8229081657059c"]  # Replace with your security group ID(s)

  ebs_block_device {
    device_name  = "/dev/xvda"
    volume_type  = "gp2"
    volume_size  = 8
    encrypted    = true
    kms_key_id   = "22ad3ccd-28a1-4d05-ad73-5f284cea93b3"  # Specify the KMS key ID used for encryption
  }

  tags = {
    Name = "ExampleInstance"
  }
}

# Output the public IP address of the instance
output "instance_public_ip" {
  value = aws_instance.ami_kms.public_ip
}
