output "alb_sec_group_id" {
  value       = aws_security_group.alb_sec_group.id
}

output "web_sec_group_id" {
  value       = aws_security_group.web_sec_group.id
}

output "db_sec_group_id" {
  value       = aws_security_group.db_sec_group.id
}
