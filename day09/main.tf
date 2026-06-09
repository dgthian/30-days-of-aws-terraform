/**resource "aws_instance" "example" {
  ami           = "ami-0130c3a072f3832ff"
  instance_type = var.allowed_vm_types[0]
  region        = var.allow_region[0]

  tags = var.tags

  lifecycle {
    create_before_destroy = false // Destroy the old instance before creating a new one
    prevent_destroy = false // Allow the instance to be destroyed when the configuration is destroyed
  }
}**/

/**
 * This S3 bucket is used to store critical data for the application.
 * It is configured with lifecycle rules to prevent accidental deletion.
 * The bucket will be destroyed when the Terraform configuration is destroyed,
 * but it will not be recreated if it already exists, ensuring that critical data is not lost.
 */
/**resource "aws_s3_bucket" "critical_data" {
  bucket = "lab-terraform-state-bucket-unique-name-12345"

  lifecycle {
    prevent_destroy = false // Allow the bucket to be destroyed when the configuration is destroyed
  }
}


# Get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Get availability zones
data "aws_availability_zones" "available" {
  state = "available"
}


# Launch Template for Auto Scaling Group
resource "aws_launch_template" "app_server" {
  name_prefix   = "app-server-"
  image_id      = data.aws_ami.amazon_linux_2.id
  instance_type = var.allowed_vm_types[1]

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      var.resource_tags,
      {
        Name = "App Server from ASG"
        Demo = "ignore_changes"
      }
    )
  }
}


# Auto Scaling Group to manage EC2 instances
resource "aws_autoscaling_group" "app_servers" {
  name               = "app-servers-asg"
  min_size           = 1
  max_size           = 5
  desired_capacity   = 2
  health_check_type  = "EC2"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

  launch_template {
    id      = aws_launch_template.app_server.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "App Server ASG"
    propagate_at_launch = true
  }

  tag {
    key                 = "Demo"
    value               = "ignore_changes"
    propagate_at_launch = false
  }

  # Lifecycle Rule: Ignore changes to desired_capacity
  # This is useful when auto-scaling policies or external systems modify capacity
  # Terraform won't try to revert capacity changes made outside of Terraform
  lifecycle {
    ignore_changes = [
      desired_capacity,
      # Also ignore load_balancers if added later by other processes
    ]
  }
}
 

# Use Case: Replace EC2 instances when security group changes
# Security Group
resource "aws_security_group" "app_sg" {
  name        = "app-security-group"
  description = "Security group for application servers"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP from anywhere"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS from anywhere"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = merge(
    var.resource_tags,
    {
      Name = "App Security Group"
      Demo = "replace_triggered_by"
    }
  )
}

#EC2 Instance that gets replaced when security group changes
resource "aws_instance" "app_with_sg" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.allowed_vm_types[0]
  region        = var.region
  security_groups = [aws_security_group.app_sg.name] 
  tags = var.tags

  lifecycle {
    replace_triggered_by = [
      aws_security_group.app_sg.id # Replace instance if the security group changes
    ]
  }
}  
**/

resource "aws_s3_bucket" "compliance_bucket" {
  bucket =  "compliance-bucket-09062026-${var.environment}-${var.allow_region[0]}"
  tags = var.tags
  lifecycle {
    postcondition {
      condition     = contains(keys(var.tags), "Compliance")
      error_message = "ERROR: Bucket must have a 'Compliance' tag key."
    }
  }
}  