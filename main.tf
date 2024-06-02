# Configure the AWS provider
provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS 
}

# Define the EC2 instance with encrypted EBS volume
resource "aws_instance" "ami_kms" {
  ami                    = "ami-081649c240df9e1d9"  # Replace with your encrypted AMI ID
  instance_type          = "t2.small"
  key_name               = "pra"  # Replace with your key pair name
  vpc_security_group_ids = ["sg-05a8229081657059c"]  # Replace with your security group ID(s)

  
  tags = {
    Name = "Instance"
  }
}

# Output the public IP address of the instance
output "instance_public_ip" {
  value = aws_instance.ami_kms.public_ip
}
