#!/bin/bash
set -euxo pipefail

# Install and start the Apache web server
dnf install -y httpd

# Ask the instance metadata service (IMDSv2) who this server is
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 300")
INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/instance-id)
AZ=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/placement/availability-zone)

# Write a homepage that shows which server answered
cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html>
  <head><title>Three-Tier App</title></head>
  <body>
    <h1>Three-tier architecture on AWS, built with Terraform</h1>
    <p>Served by instance: <strong>$INSTANCE_ID</strong></p>
    <p>Availability Zone: <strong>$AZ</strong></p>
  </body>
</html>
EOF

systemctl enable --now httpd