output "instance_id" {
  value = aws_instance.webtext.id
}

output "public_ip" {
  value = aws_instance.webtext.public_ip
}

output "ssh_command" {
  value = "ssh -i ~/.ssh/webtext-app ubuntu@${aws_instance.webtext.public_ip}"
}