output "id" {
  description = "Glue trigger ID"
  value       = aws_glue_trigger.this.id
}

output "name" {
  description = "Glue trigger name"
  value       = aws_glue_trigger.this.name
}

output "arn" {
  description = "Glue trigger ARN"
  value       = aws_glue_trigger.this.arn
}
