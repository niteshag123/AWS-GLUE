locals {
  data_source = "s3://${var.bucket_name}/resources.csv"

  common_tags = {
    CostCenter  = "00298"
    Service     = "Refdata"
    User        = "nitesh.agarwal@spglobal.com"
    Environment = var.environment
  }
}

#-------------------------------------------------------
# AWS Glue Catalog Database
#-------------------------------------------------------

module "glue_catalog_database" {
  source = "../glue-catalog-database"
  count  = var.deploy_glue_catalog_table == true ? 1 : 0

  catalog_database_name        = lower("${var.service_name}-${var.environment}-${var.region}-glue-db")
  catalog_database_description = "Glue Catalog database for the data located in ${local.data_source}"
  location_uri                 = local.data_source
  common_tags                  = local.common_tags
}

#-------------------------------------------------------
# AWS Glue Catalog Table
#-------------------------------------------------------

module "glue_catalog_table" {
  source = "../glue-catalog-table"
  count  = var.deploy_glue_catalog_table == true ? 1 : 0

  catalog_table_name        = lower("${var.service_name}-${var.environment}-${var.region}-glue-table")
  catalog_table_description = "Test Glue Catalog table"
  database_name             = module.glue_catalog_database[0].name

  storage_descriptor = {
    # Physical location of the table
    location = local.data_source
  }
}

#-------------------------------------------------------
# AWS Glue Crawler
#-------------------------------------------------------
# Crawls the data in the S3 bucket and puts the results into a database in the Glue Data Catalog. The crawler will read the first 2 MB of data from that file, and recognize the schema.
module "glue_crawler" {
  source = "../glue-crawler"
  count  = var.deploy_glue_crawler == true && var.deploy_glue_catalog_table == true ? 1 : 0

  role_arn            = var.iam_role_name != "" ? data.aws_iam_role.glue_role[0].arn : aws_iam_role.glue_role[0].arn
  crawler_name        = lower("${var.service_name}-${var.environment}-${var.region}-glue-crawler")
  crawler_description = "Glue crawler that processes data in ${local.data_source} and writes the metadata into a Glue Catalog database"
  database_name       = module.glue_catalog_database[0].name
  schedule            = "cron(0 1 * * ? *)"
  common_tags         = local.common_tags

  schema_change_policy = {
    delete_behavior = "LOG"
    update_behavior = null
  }

  catalog_target = [
    {
      database_name = module.glue_catalog_database[0].name
      tables        = [module.glue_catalog_table[0].name]
    }
  ]

}

# -------------------------------------------------------
# AWS Glue Job
# -------------------------------------------------------
resource "aws_cloudwatch_log_group" "glue_job_cw_group" {
  count = var.deploy_glue_job == true ? 1 : 0

  name              = lower("${var.service_name}-${var.environment}-${var.region}-glue-cw-group")
  retention_in_days = 180
  tags              = merge(local.common_tags, { Name = var.glue_job_cw_group })
}

module "glue_job" {
  source = "../glue-job"
  count  = var.deploy_glue_job == true ? 1 : 0

  job_name          = lower("${var.service_name}-${var.environment}-${var.region}-glue-job")
  job_description   = "Glue Job that runs Python script"
  role_arn          = var.iam_role_name != "" ? data.aws_iam_role.glue_role[0].arn : aws_iam_role.glue_role[0].arn
  glue_version      = var.glue_version
  connections       = var.deploy_glue_connection == true ? [module.glue_connection[0].name] : []
  worker_type       = "G.1X"
  number_of_workers = 5
  max_retries       = 0
  timeout           = 2880

  command = {
    python_version  = "3"
    name            = "glueetl"
    script_location = "s3://${var.bucket_name}/temp/glue_poc_script.py"
    # script_location = "s3://aws-mrd-vendor-files-qa/edi-global/mrd-edi-fi/edi_raw_to_latest.py"
  }

  default_arguments = {
    "--enable-job-insights"              = "true"
    "--continuous-log-logGroup"          = aws_cloudwatch_log_group.glue_job_cw_group[0].name
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-continuous-log-filter"     = "true"
    "--enable-metrics"                   = "true"
    "--TempDir"                          = "s3://${var.bucket_name}/temp"
    # "--TempDir"      = "s3://aws-mrd-vendor-files-qa/edi-global/mrd-edi-fi/temp/"
    "--job-language" = "python"
  }

  depends_on  = [aws_cloudwatch_log_group.glue_job_cw_group]
  common_tags = local.common_tags
}

#-------------------------------------------------------
# AWS Glue connections
#-------------------------------------------------------

module "glue_connection" {
  source = "../glue-connection"
  count  = var.deploy_glue_connection == true ? 1 : 0

  name = lower("${var.service_name}-${var.environment}-${var.region}-connection")
  url  = "${var.postgres_jdbc_url}/${var.postgres_db_name}"
  user = var.conn_user
  pass = var.conn_pass

  subnet = var.conn_subnet
  azs    = var.conn_azs
  sg_ids = ["${var.sg_ids}"]
  type   = var.conn_type
}

#-------------------------------------------------------
# AWS Glue Trigger
#-------------------------------------------------------

module "glue_trigger" {
  source = "../glue-trigger"
  count  = var.deploy_glue_trigger == true ? 1 : 0

  trigger_name        = lower("${var.service_name}-${var.environment}-${var.region}-glue-trigger")
  trigger_enabled     = true
  start_on_creation   = true
  trigger_description = "Glue Trigger that triggers a Glue Job on a schedule"
  schedule            = "cron(15 12 * * ? *)"
  type                = "SCHEDULED"

  actions = [
    {
      job_name = module.glue_job[0].name
      # The job run timeout in minutes. It overrides the timeout value of the job
      timeout = 10
    }
  ]

  common_tags = local.common_tags
}
