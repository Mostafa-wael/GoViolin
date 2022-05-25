output "Name" {
    value = aws_instance.ec2_instance[*].tags["Name"]
}
output "public_dns" {
    value = aws_instance.ec2_instance[*].public_dns
}


data "aws_caller_identity" "current" {}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}