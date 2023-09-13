
# data "aws_availability_zone" "az" {
#   filter {
#     name  = "Name"
#     value = "IHSM Private Product Subnet - 10.228.111.0/25"
#   }
# }

# output "az_details" {
#   value = data.aws_availability_zone.az.*
# }