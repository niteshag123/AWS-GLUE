output "id" {
  description = "Glue crawler ID"
  value       = aws_glue_crawler.this.id
}

output "name" {
  description = "Glue crawler name"
  value       = aws_glue_crawler.this.name
}

output "arn" {
  description = "Glue crawler ARN"
  value       = aws_glue_crawler.this.arn
}
