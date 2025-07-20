output "web_instance_id" {
  value = [aws_instance.web_1.id, aws_instance.web_2.id]
}
