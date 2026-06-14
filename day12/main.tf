
locals {
  formatted_project_name = lower(replace(var.project_name, " ", "-"))
  new_tags = merge(var.default_tags, var.environment_tags)
  formatted_bucket_name = replace(substr(lower(replace(var.bucket_name, " ", "-")), 0, 63),"!", "") //aws s3 bucket names must be between 3 and 63 characters long, and can only contain lowercase letters, numbers, and hyphens. This line formats the bucket name accordingly and ensures it does not exceed the maximum length. 
  port_list = split(",", var.allowed_ports)
  sg_rule = [ for port in local.port_list : 
  {
    name = "port-${port}" 
    port = port
    description = "Allow traffic on port ${port}"
  }
  ]

  instance_size = lookup(var.instance_size, var.environment_tags.environment, "t3.micro") // This line looks up the instance size based on the environment tag. If the environment is not found in the instance_size map, it defaults to "t3.micro".

  all_locations = concat(var.user_locations, var.default_locations)

  unique_locations = toset(local.all_locations)

  positive_cost = [for cost in var.monthly_cost : abs(cost)] 
  max_cost = max(local.positive_cost...)
  min_cost = min(local.positive_cost...)
  total_cost = sum(local.positive_cost)
  avg_cost = local.total_cost / length(local.positive_cost)

  current_timestamp = timestamp()
  format1 = formatdate("yyyyMMdd", local.current_timestamp)
  format2 = formatdate("YYYY-MM-DD", local.current_timestamp)
  timestamp_name = "backup-${local.format1}"

  config_file_exists = fileexists("./config.json")
  config_data = local.config_file_exists ? jsondecode(file("./config.json")) : {}
}

resource "aws_s3_bucket" "firsts3" {
  bucket = local.formatted_bucket_name
  tags = local.new_tags
}  