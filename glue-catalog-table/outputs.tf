output "id" {
  description = "Glue catalog table ID"
  value       = aws_glue_catalog_table.this.id
}

output "name" {
  description = "Glue catalog table name"
  value       = aws_glue_catalog_table.this.name
}

output "arn" {
  description = "Glue catalog table ARN"
  value       = aws_glue_catalog_table.this.arn
}
