#-------------------------------------------------------
# Output of AWS Glue Catalog Database
#-------------------------------------------------------
output "Database_name" {
  description = "Glue database name"
  value       = var.deploy_glue_catalog_table == true ? module.glue_catalog_database[0].name : 0
}

output "Database_arn" {
  description = "Glue database arn"
  value       = var.deploy_glue_catalog_table == true ? module.glue_catalog_database[0].arn : 0
}

#-------------------------------------------------------
# Output of AWS Glue Catalog Table
#-------------------------------------------------------
output "Table_name" {
  description = "Glue Table name"
  value       = var.deploy_glue_catalog_table == true ? module.glue_catalog_table[0].name : 0
}

output "Table_arn" {
  description = "Glue Table arn"
  value       = var.deploy_glue_catalog_table == true ? module.glue_catalog_table[0].arn : 0
}

#-------------------------------------------------------
# Output of AWS Glue Job
#-------------------------------------------------------
output "job_name" {
  description = "Glue job name"
  value       = var.deploy_glue_job == true ? module.glue_job[0].name : 0
}

output "job_arn" {
  description = "Glue job ARN"
  value       = var.deploy_glue_job == true ? module.glue_job[0].arn : 0
}

#-------------------------------------------------------
# Output of AWS Glue connections
#-------------------------------------------------------
output "connection_name" {
  description = "Glue Connection name"
  value       = var.deploy_glue_connection == true ? module.glue_connection[0].name : 0
}

output "connection_arn" {
  description = "Glue Connection ARN"
  value       = var.deploy_glue_connection == true ? module.glue_connection[0].arn : 0
}

#-------------------------------------------------------
# Output of AWS Glue Trigger
#-------------------------------------------------------
output "trigger_name" {
  description = "Glue trigger name"
  value       = var.deploy_glue_trigger == true ? module.glue_trigger[0].name : 0
}

output "trigger_arn" {
  description = "Glue trigger ARN"
  value       = var.deploy_glue_trigger == true ? module.glue_trigger[0].arn : 0
}

#-------------------------------------------------------
# Output of AWS IAM Role Name
#-------------------------------------------------------
output "IAM_Role_Name" {
  description = "IAM Role of Glue Service"
  value       = var.iam_role_name == "" ? aws_iam_role.glue_role[0].name : 0
}

#-------------------------------------------------------
# Output of AWS CloudWatch Log Group Name
#-------------------------------------------------------
output "CW_Group_Name" {
  description = "CW Log Group Name of Glue Service"
  value       = var.deploy_glue_job == true ? aws_cloudwatch_log_group.glue_job_cw_group[0].name : 0
}