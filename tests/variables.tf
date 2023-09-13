variable "region" {
  type        = string
  description = "AWS Region"
  default     = "eu-west-2"
}

variable "deploy_glue_catalog_table" {
  type        = bool
  description = "Set to false to prevent the module from creating any resources"
  default     = true
}

variable "deploy_glue_crawler" {
  type        = bool
  description = "Set to false to prevent the module from creating any resources"
  default     = true
}

variable "deploy_glue_job" {
  type        = bool
  description = "Set to false to prevent the module from creating any resources"
  default     = true
}

variable "deploy_glue_connection" {
  type        = bool
  description = "Set to false to prevent the module from creating any resources"
  default     = true
}

variable "deploy_glue_trigger" {
  type        = bool
  description = "Set to false to prevent the module from creating any resources"
  default     = true
}

variable "service_name" {
  description = "Set it to BRD, SPRD, RED, Entity, Equity"
  type        = string
  default     = "BRD"
}

variable "glue_version" {
  type        = string
  description = "The version of glue to use"
  default     = "4.0"
}

variable "iam_role_name" {
  type        = string
  description = "IAM Role Name for Glue Service. In case if not provided, glue modle will create new IAM Role"
  default     = ""
}

variable "bucket_name" {
  type        = string
  description = "Bucket Name for Glue Job Script"
  default     = "terraform-glue-poc"
}

variable "environment" {
  type        = string
  description = "ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT'"
  default     = "test"
}

variable "glue_job_cw_group" {
  type        = string
  description = "Cloudwatch Log Group Name"
  default     = "cloudwatch_tf_glue"
}

variable "create_connection" {
  type        = bool
  description = "value"
  default     = true
}

variable "postgres_db_name" {
  type        = string
  description = "Name of the database"
  default     = "mrd_vendor_raw"
}

variable "postgres_jdbc_url" {
  type        = string
  description = "JDBC url of the database"
  default     = "jdbc:postgresql://mrdqa.ciordawhkw3c.eu-west-2.rds.amazonaws.com:5432"
}

variable "conn_user" {
  type        = string
  description = "Username for the database"
  default     = "core_ref_data"
}

variable "conn_pass" {
  type        = string
  description = "Password for the database"
  default     = "core_ref_data"
}

variable "sg_ids" {
  type        = string
  description = "Security group for the connection network"
  default     = "sg-088b0b4f8c709673e"
}

variable "conn_type" {
  type        = string
  description = "Database conenction type"
  default     = "JDBC"
}

variable "conn_subnet" {
  type        = string
  description = "Subnet for the connection network"
  default     = "subnet-0290f481158da9bf0"
}

variable "conn_azs" {
  type        = string
  description = "Availabilty zone for the connection network"
  default     = "eu-west-2a"
}