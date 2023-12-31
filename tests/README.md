## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_glue_catalog_database"></a> [glue\_catalog\_database](#module\_glue\_catalog\_database) | ../glue-catalog-database | n/a |
| <a name="module_glue_catalog_table"></a> [glue\_catalog\_table](#module\_glue\_catalog\_table) | ../glue-catalog-table | n/a |
| <a name="module_glue_connection"></a> [glue\_connection](#module\_glue\_connection) | ../glue-connection | n/a |
| <a name="module_glue_crawler"></a> [glue\_crawler](#module\_glue\_crawler) | ../glue-crawler | n/a |
| <a name="module_glue_job"></a> [glue\_job](#module\_glue\_job) | ../glue-job | n/a |
| <a name="module_glue_trigger"></a> [glue\_trigger](#module\_glue\_trigger) | ../glue-trigger | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.glue_job_cw_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_role.glue_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cloudwatch_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.glue_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.s3_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy.cloudwatch-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.glue-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.s3-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_role.glue_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Bucket Name for Glue Job Script | `string` | `"terraform-glue-poc"` | no |
| <a name="input_conn_azs"></a> [conn\_azs](#input\_conn\_azs) | Availabilty zone for the connection network | `string` | `"eu-west-2a"` | no |
| <a name="input_conn_pass"></a> [conn\_pass](#input\_conn\_pass) | Password for the database | `string` | `"core_ref_data"` | no |
| <a name="input_conn_subnet"></a> [conn\_subnet](#input\_conn\_subnet) | Subnet for the connection network | `string` | `"subnet-0290f481158da9bf0"` | no |
| <a name="input_conn_type"></a> [conn\_type](#input\_conn\_type) | Database conenction type | `string` | `"JDBC"` | no |
| <a name="input_conn_user"></a> [conn\_user](#input\_conn\_user) | Username for the database | `string` | `"core_ref_data"` | no |
| <a name="input_create_connection"></a> [create\_connection](#input\_create\_connection) | value | `bool` | `true` | no |
| <a name="input_deploy_glue_catalog_table"></a> [deploy\_glue\_catalog\_table](#input\_deploy\_glue\_catalog\_table) | Set to false to prevent the module from creating any resources | `bool` | `true` | no |
| <a name="input_deploy_glue_connection"></a> [deploy\_glue\_connection](#input\_deploy\_glue\_connection) | Set to false to prevent the module from creating any resources | `bool` | `true` | no |
| <a name="input_deploy_glue_crawler"></a> [deploy\_glue\_crawler](#input\_deploy\_glue\_crawler) | Set to false to prevent the module from creating any resources | `bool` | `true` | no |
| <a name="input_deploy_glue_job"></a> [deploy\_glue\_job](#input\_deploy\_glue\_job) | Set to false to prevent the module from creating any resources | `bool` | `true` | no |
| <a name="input_deploy_glue_trigger"></a> [deploy\_glue\_trigger](#input\_deploy\_glue\_trigger) | Set to false to prevent the module from creating any resources | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `"test"` | no |
| <a name="input_glue_job_cw_group"></a> [glue\_job\_cw\_group](#input\_glue\_job\_cw\_group) | Cloudwatch Log Group Name | `string` | `"cloudwatch_tf_glue"` | no |
| <a name="input_glue_version"></a> [glue\_version](#input\_glue\_version) | The version of glue to use | `string` | `"4.0"` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | IAM Role Name for Glue Service. In case if not provided, glue modle will create new IAM Role | `string` | `""` | no |
| <a name="input_postgres_db_name"></a> [postgres\_db\_name](#input\_postgres\_db\_name) | Name of the database | `string` | `"mrd_vendor_raw"` | no |
| <a name="input_postgres_jdbc_url"></a> [postgres\_jdbc\_url](#input\_postgres\_jdbc\_url) | JDBC url of the database | `string` | `"jdbc:postgresql://mrdqa.ciordawhkw3c.eu-west-2.rds.amazonaws.com:5432"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | `"eu-west-2"` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Set it to BRD, SPRD, RED, Entity, Equity | `string` | `"BRD"` | no |
| <a name="input_sg_ids"></a> [sg\_ids](#input\_sg\_ids) | Security group for the connection network | `string` | `"sg-088b0b4f8c709673e"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_CW_Group_Name"></a> [CW\_Group\_Name](#output\_CW\_Group\_Name) | CW Log Group Name of Glue Service |
| <a name="output_Database_arn"></a> [Database\_arn](#output\_Database\_arn) | Glue database arn |
| <a name="output_Database_name"></a> [Database\_name](#output\_Database\_name) | Glue database name |
| <a name="output_IAM_Role_Name"></a> [IAM\_Role\_Name](#output\_IAM\_Role\_Name) | IAM Role of Glue Service |
| <a name="output_Table_arn"></a> [Table\_arn](#output\_Table\_arn) | Glue Table arn |
| <a name="output_Table_name"></a> [Table\_name](#output\_Table\_name) | Glue Table name |
| <a name="output_connection_arn"></a> [connection\_arn](#output\_connection\_arn) | Glue Connection ARN |
| <a name="output_connection_name"></a> [connection\_name](#output\_connection\_name) | Glue Connection name |
| <a name="output_job_arn"></a> [job\_arn](#output\_job\_arn) | Glue job ARN |
| <a name="output_job_name"></a> [job\_name](#output\_job\_name) | Glue job name |
| <a name="output_trigger_arn"></a> [trigger\_arn](#output\_trigger\_arn) | Glue trigger ARN |
| <a name="output_trigger_name"></a> [trigger\_name](#output\_trigger\_name) | Glue trigger name |
