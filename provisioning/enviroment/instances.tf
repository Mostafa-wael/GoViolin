# Create the Ec2 Instance
resource "aws_instance" "ec2_instance" {
  count                 = length(var.instance_name) # Create all the instance names specified in the variable
  ami                   = var.instance_ami
  instance_type         = var.instance_type
  key_name              = var.instance_key
  subnet_id             = aws_subnet.public_subnet.id
  security_groups       = [aws_security_group.sg.id]
  availability_zone     = var.availability_zone
  user_data             = var.instance_start_script
  tags = {
    Name = "${var.server_name}_${var.instance_name[count.index]}"
  }
  lifecycle { # lifecycle is set to ignore ami changes (use this if you don’t want your instance to recreate when the ami updates)
     ignore_changes = [ami]
  }
}
