output "name" {
  description = "Glue Connection Service Name"
  value       = aws_glue_connection.glue_connection_vpc.name
}

output "arn" {
  description = "Glue Connection Service ARN"
  value       = aws_glue_connection.glue_connection_vpc.arn
}