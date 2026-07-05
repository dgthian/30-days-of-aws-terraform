# Local values for VPC Peering Demo

locals {
# User data template for EC2 instances in the primary region
  primary_user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              echo "<h1>Welcome to the Primary Region Web Server - ${var.primary_region}</h1>" > /var/www/html/index.html
              echo "<p>Private IP: $(hostname -I) </p>" >> /var/www/html/index.html"   
              EOF

# User data template for EC2 instances in the secondary region
  secondary_user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              echo "<h1>Welcome to the Secondary Region Web Server - ${var.secondary_region}</h1>" > /var/www/html/index.html
              echo "<p>Private IP: $(hostname -I) </p>" >> /var/www/html/index.html"   
              EOF
}

