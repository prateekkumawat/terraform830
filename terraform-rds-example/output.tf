output "rds_instance_endpoint" {
  value       = aws_db_instance.use1rds.endpoint
}

output "rds_instance_id" {
  value       = aws_db_instance.use1rds.id
}

output "rds_instance_arn" {
  value       = aws_db_instance.use1rds.arn
}